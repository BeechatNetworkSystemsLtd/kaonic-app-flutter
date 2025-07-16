import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kaonic/data/extensions/bytes_extension.dart';
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
        final value = f.fileSizeProcessed / f.fileSize;
        final isUploaded = f.fileSizeProcessed == f.fileSize;
        return GestureDetector(
          onTap: f.path == null ? null : () => OpenFile.open(f.path!),
          child: Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  spacing: 8,
                  children: [
                    isUploaded
                        ? const Icon(
                            Icons.file_present_rounded,
                            color: Colors.white,
                          )
                        : SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              value: value,
                              color: AppColors.white,
                            ),
                          ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            f.fileName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.text14
                                .copyWith(color: AppColors.white),
                          ),
                          Text(
                            f.fileSize.toReadableSize,
                            style: TextStyles.text14
                                .copyWith(color: AppColors.grey3),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (f.date != null)
                Text(
                  f.date!.messageTime,
                  style: TextStyles.text14.copyWith(color: AppColors.grey3),
                ),
            ],
          ),
        );
    }

    return const SizedBox.shrink();
  }
}
