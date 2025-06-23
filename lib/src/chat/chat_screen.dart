
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                      style: TextStyles.text24.copyWith(color: Colors.white),
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
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocConsumer<ChatBloc, ChatState>(
                    listener: (context, state) {
                      if (state is NavigateToCall) {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.call,
                          arguments: CallScreenState.outgoing,
                        );
                        return;
                      }

                      if (state.flagScrollToDown) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          Expanded(
                              child: ListView.separated(
                                  controller: _scrollController,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final message = state.messages[index].data;
                                    print('message ${message.runtimeType}');

                                    return ChatItem(
                                      message: state.messages[index].data
                                          as MessageEvent,
                                      peerAddress: widget.address,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10.h),
                                  itemCount: state.messages.length)),
                          SizedBox(height: 10.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MainButton(
                                label: S.of(context).pickFile,
                                removePadding: true,
                                onPressed: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    _chatBloc.add(FilePicked(file: result));
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
                                      if (_textController.text.isEmpty) return;

                                      _chatBloc.add(SendMessage(
                                          message: _textController.text));
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
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
