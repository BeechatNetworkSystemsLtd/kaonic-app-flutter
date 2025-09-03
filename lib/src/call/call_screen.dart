import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/extensions/date_time_extension.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/src/call/bloc/call_bloc.dart';
import 'package:kaonic/src/widgets/icon_circle_button.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
import 'package:kaonic/src/widgets/user_icon_widget.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class CallScreen extends StatefulWidget {
  final CallScreenStateInfo callState;
  const CallScreen({
    super.key,
    required this.callState,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _canPop = false;

  void _navigateToChat() {
    _canPop = true;
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      child: BlocProvider(
        create: (context) => CallBloc(
            callState: widget.callState,
            callService: context.read<CallService>()),
        child: BlocConsumer<CallBloc, CallState>(
          listener: (context, state) {
            if (state is EndCallState) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            final isCallInProgress = state.callState?.callScreenState ==
                CallScreenState.callInProgress;
            return Scaffold(
              floatingActionButton: isCallInProgress
                  ? FloatingActionButton(
                      onPressed: _navigateToChat,
                      backgroundColor: AppColors.grey1,
                      child: Icon(
                        Icons.chat,
                        color: AppColors.yellow,
                      ),
                    )
                  : null,
              body: ScreenContainer(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 10.h + MediaQuery.of(context).padding.top,
                    bottom: 10.h + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.callState?.callScreenState.getTitle(state
                                          .usernameAddressHex
                                          ?.substring(0, 5) ??
                                      'Unknown') ??
                                  '',
                              style: TextStyles.text24
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              state.usernameAddressHex ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.text24.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            if (state.callState?.callStart != null &&
                                state.callState?.callScreenState ==
                                    CallScreenState.callInProgress)
                              _CallDurationChip(
                                callStart: state.callState!.callStart!,
                              ),
                            SizedBox(height: 25.h),
                            _AnimatedUserIconWidget(),
                            SizedBox(height: 150.h),
                            AnimatedSwitcher(
                              duration: Durations.medium2,
                              child: switch (state.callState?.callScreenState) {
                                CallScreenState.incoming => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconCircleButton(
                                        icon: Icons.call_end,
                                        onTap: () {
                                          context
                                              .read<CallBloc>()
                                              .add(EndCall());
                                        },
                                        color: AppColors.negative,
                                      ),
                                      IconCircleButton(
                                        icon: Icons.call,
                                        onTap: () {
                                          context
                                              .read<CallBloc>()
                                              .add(AcceptCall());
                                        },
                                        color: AppColors.positive,
                                      )
                                    ],
                                  ),
                                CallScreenState.outgoing ||
                                CallScreenState.callInProgress =>
                                  IconCircleButton(
                                    icon: Icons.call_end,
                                    onTap: () {
                                      context.read<CallBloc>().add(EndCall());
                                    },
                                    color: AppColors.negative,
                                  ),
                                CallScreenState.finished => Opacity(
                                    opacity: 0.5,
                                    child: IconCircleButton(
                                      icon: Icons.call_end,
                                      onTap: () {},
                                      color: AppColors.negative,
                                    ),
                                  ),
                                _ => const SizedBox(),
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CallDurationChip extends StatefulWidget {
  final DateTime callStart;
  const _CallDurationChip({
    super.key,
    required this.callStart,
  });

  @override
  State<_CallDurationChip> createState() => _CallDurationChipState();
}

class _CallDurationChipState extends State<_CallDurationChip> {
  Timer? _timer;

  void _initTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.positive.withValues(alpha: 0.25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            widget.callStart.getCallDuration,
            style: TextStyles.text14.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedUserIconWidget extends StatefulWidget {
  const _AnimatedUserIconWidget({super.key});

  @override
  State<_AnimatedUserIconWidget> createState() =>
      _AnimatedUserIconWidgetState();
}

class _AnimatedUserIconWidgetState extends State<_AnimatedUserIconWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _animation = Tween(begin: 1.0, end: 1.05).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return UserIconWidget(
            padding: 30 * _animation.value,
            iconSize: 70 * _animation.value,
          );
        },
      ),
    );
  }
}
