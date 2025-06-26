import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/src/call/bloc/call_bloc.dart';
import 'package:kaonic/src/widgets/icon_circle_button.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
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
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 150.h, top: 25.h),
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: AppColors.grey2,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: EdgeInsets.all(30.w),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                ),
                              ),
                            ),
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
