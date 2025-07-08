import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kaonic/data/extensions/date_time_extension.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';
import 'package:open_file/open_file.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.message,
    required this.peerAddress,
    required this.myAddress,
  });

  final MessageEvent message;
  final String peerAddress;
  final String myAddress;

  @override
  Widget build(BuildContext context) {
    final bool isMyMessage = message.address == myAddress;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey3),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      margin: EdgeInsets.only(
        left: !isMyMessage ? 0 : 100.w,
        right: !isMyMessage ? 100.w : 0,
      ),
      child: _child(),
    );
  }

  Widget _child() {
    switch (message) {
      case MessageTextEvent m:
        return Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                m.text ?? '',
                style: TextStyles.text14.copyWith(color: Colors.white),
              ),
            ),
            if (m.date != null)
              Text(
                m.date!.messageTime,
                style: TextStyles.text14.copyWith(color: AppColors.grey3),
              ),
          ],
        );
      case MessageFileEvent f:
        return GestureDetector(
            onTap: f.path == null ? null : () => OpenFile.open(f.path!),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.file_present_rounded, color: Colors.white),
                    SizedBox(
                      width: 16,
                    ),
                    Row(
                      children: [
                        if (f.path == null)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: const SizedBox(
                                width: 7,
                                height: 7,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                  color: AppColors.yellow,
                                )),
                          ),
                        // if (message.address != peerAddress)
                        //   Padding(
                        //     padding: const EdgeInsets.only(right: 4),
                        //     child: Icon(
                        //       Icons.upload,
                        //       color: Colors.grey,
                        //       size: 16,
                        //     ),
                        //   ),
                        // Text(
                        //   '${((f.bytes?.length ?? 0) / 1024).toStringAsFixed(1)} kB',
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        if (f.date != null)
                          Text(
                            f.date!.messageTime,
                            style: TextStyles.text14
                                .copyWith(color: AppColors.grey3),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ));
    }

    return const SizedBox.shrink();
  }
}
