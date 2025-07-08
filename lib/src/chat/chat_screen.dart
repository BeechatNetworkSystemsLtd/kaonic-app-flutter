import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kaonic/data/extensions/date_time_extension.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/routes.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/service/chat_service.dart';
import 'package:kaonic/src/chat/bloc/chat_bloc.dart';
import 'package:kaonic/src/chat/widgets/chat_item.dart';
import 'package:kaonic/src/widgets/circle_button.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/src/widgets/screen_container.dart';
import 'package:kaonic/theme/assets.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';
import 'package:kaonic/utils/dialog_util.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.address,
  });

  final String address;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatBloc _chatBloc;

  @override
  void initState() {
    _chatBloc = ChatBloc(
      callService: context.read<CallService>(),
      address: widget.address,
      chatService: context.read<ChatService>(),
    );
    [Permission.manageExternalStorage, Permission.accessMediaLocation]
        .request()
        .then(
      (value) {
        print("object");
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _chatBloc,
      child: BlocListener<ChatBloc, ChatState>(
        listenWhen: (prev, curr) =>
            prev.isCallEndedOnPop != curr.isCallEndedOnPop,
        listener: (context, state) {
          if (state.isCallEndedOnPop) Navigator.of(context).pop();
        },
        child: BlocSelector<ChatBloc, ChatState, CallScreenStateInfo>(
          selector: (state) => state.callState,
          builder: (context, callState) {
            final isCallInProgress =
                callState.callScreenState == CallScreenState.callInProgress;
            return PopScope(
              canPop: !isCallInProgress,
              onPopInvoked: (didPop) async {
                if (didPop) return;

                if (isCallInProgress) {
                  final result =
                      await DialogUtil.showDefaultDialogWithResult<bool>(
                    context,
                    title: S.of(context).doYouWantToEndTheCall,
                    onYes: () => Navigator.of(context).pop(true),
                  );

                  if (result == true) {
                    _chatBloc.add(EndCallAndPop());
                  }
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Scaffold(
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
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Align(
                                alignment: Alignment.centerLeft,
                                child: BackButton(
                                  color: Colors.white,
                                )),
                            Text(
                              widget.address.length > 15
                                  ? widget.address.substring(0, 15)
                                  : widget.address,
                              textAlign: TextAlign.center,
                              style: TextStyles.text24
                                  .copyWith(color: Colors.white),
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: CircleButton(
                                  icon: Assets.iconPhone,
                                  onTap: () {
                                    _chatBloc.add(InitiateCall());
                                  },
                                )),
                          ],
                        ),
                        if (isCallInProgress)
                          _CallIndicatorWidget(callState: callState),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: BlocConsumer<ChatBloc, ChatState>(
                            listener: (context, state) {
                              if (state is NavigateToCall) {
                                Navigator.of(context).pushNamed(
                                  Routes.call,
                                  arguments: CallScreenStateInfo(
                                    callScreenState: CallScreenState.outgoing,
                                  ),
                                );
                                return;
                              }

                              if (state.flagScrollToDown) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollController.jumpTo(_scrollController
                                      .position.maxScrollExtent);
                                });
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      controller: _scrollController,
                                      itemBuilder: (context, index) {
                                        final item = state.sortedMessages
                                            .elementAt(index);

                                        final date = item.first.data?.date ??
                                            DateTime.now();

                                        return Column(
                                          spacing: 12,
                                          children: [
                                            Text(
                                              date.formatedDay,
                                              style: TextStyles.text18Bold
                                                  .copyWith(
                                                      color: AppColors.white),
                                            ),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final message =
                                                    item.elementAt(index);

                                                return ChatItem(
                                                  myAddress: state.myAddress,
                                                  message: message.data!,
                                                  peerAddress: widget.address,
                                                );
                                              },
                                              separatorBuilder: (_, __) =>
                                                  SizedBox(height: 10.h),
                                              itemCount: item.length,
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 12.h),
                                      itemCount: state.sortedMessages.length,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      MainButton(
                                        label: S.of(context).pickFile,
                                        removePadding: true,
                                        onPressed: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles();
                                          if (result != null) {
                                            _chatBloc
                                                .add(FilePicked(file: result));
                                          }
                                        },
                                        width: 75,
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Flexible(
                                              child: MainTextField(
                                            hint: 'Message...',
                                            controller: _textController,
                                          )),
                                          SizedBox(width: 10.w),
                                          MainButton(
                                            label: S.of(context).labelSend,
                                            removePadding: true,
                                            onPressed: () {
                                              if (_textController.text.isEmpty)
                                                return;

                                              _chatBloc.add(SendMessage(
                                                  message:
                                                      _textController.text));
                                              _textController.clear();
                                            },
                                            width: 75,
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _CallIndicatorWidget extends StatefulWidget {
  const _CallIndicatorWidget({
    super.key,
    required this.callState,
  });

  final CallScreenStateInfo callState;

  @override
  State<_CallIndicatorWidget> createState() => _CallIndicatorWidgetState();
}

class _CallIndicatorWidgetState extends State<_CallIndicatorWidget> {
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.call,
          arguments: CallScreenStateInfo(
            callScreenState: CallScreenState.callInProgress,
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.yellow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.iconPhone,
                colorFilter: ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '${S.of(context).ongoingCall}...',
                style: TextStyles.text14,
              ),
              Spacer(),
              if (widget.callState.callStart != null)
                Text(
                  widget.callState.callStart!.getCallDuration,
                  style: TextStyles.text14,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
