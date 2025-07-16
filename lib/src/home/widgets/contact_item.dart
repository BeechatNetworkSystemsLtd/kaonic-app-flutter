import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/models/contact_model.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/widgets/user_icon_widget.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.contact,
    required this.onTap,
    this.onIdentifyTap,
    this.nearbyFound = false,
    this.unreadCount,
    required this.onLongPress,
    this.lastMessage,
  });

  final ContactModel contact;
  final Function() onTap;
  final Function()? onIdentifyTap;
  final bool nearbyFound;
  final int? unreadCount;
  final VoidCallback onLongPress;
  final KaonicEvent? lastMessage;

  @override
  Widget build(BuildContext context) {
    final messageData = lastMessage?.data;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(42),
      child: Row(
        children: [
          UserIconWidget(
            padding: 8,
            iconSize: 24,
            bgColor: AppColors.yellow,
            iconColor: AppColors.black,
          ),
          SizedBox(width: 10.w),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          contact.address,
                          style: TextStyles.text16
                              .copyWith(color: AppColors.grey5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onIdentifyTap != null)
                        Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(48),
                            onTap: onIdentifyTap,
                            child: Ink(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48),
                                  color: AppColors.grey2),
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                S.of(context).labelIdentify,
                                style: TextStyles.text14
                                    .copyWith(color: AppColors.grey5),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: nearbyFound ? AppColors.yellow : null,
                            border: nearbyFound
                                ? null
                                : Border.all(color: AppColors.yellow),
                          ),
                          child: const SizedBox(width: 8, height: 8),
                        ),
                      )
                    ],
                  ),
                ),
                if (lastMessage != null &&
                    (lastMessage is KaonicEvent<MessageTextEvent> ||
                        lastMessage is KaonicEvent<MessageFileEvent>))
                  Builder(builder: (context) {
                    final text = lastMessage is KaonicEvent<MessageTextEvent>
                        ? (messageData as MessageTextEvent).text ?? ''
                        : (messageData as MessageFileEvent).fileName;

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        text,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.text16.copyWith(
                          color: AppColors.white,
                          fontWeight: (messageData as MessageEvent).isRead
                              ? FontWeight.w400
                              : FontWeight.w800,
                        ),
                      ),
                    );
                  })
              ],
            ),
          )
        ],
      ),
    );
  }
}
