import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem(
      {super.key,
      required this.device,
      required this.onTap,
      this.onIdentifyTap,
      this.showAvailability = true});

  final String device;
  final Function() onTap;
  final Function()? onIdentifyTap;
  final bool showAvailability;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(42),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: AppColors.yellowGradient,
                  borderRadius: BorderRadius.circular(42)),
              child: SizedBox(
                height: 48,
                child: Align(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'User',
                      style: TextStyles.text18Bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            flex: 5,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                border: Border.all(color: AppColors.grey3),
              ),
              child: SizedBox(
                height: 48,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          device,
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
                      if (showAvailability)
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.yellow),
                            ),
                            child: const SizedBox(width: 12, height: 12),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
