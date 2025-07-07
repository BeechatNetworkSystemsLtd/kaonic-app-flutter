import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/theme/theme.dart';

class UserIconWidget extends StatelessWidget {
  final Color bgColor;
  final double padding;
  final Color iconColor;
  final double iconSize;
  const UserIconWidget({
    super.key,
    this.padding = 30,
    this.iconSize = 70,
    this.bgColor = AppColors.grey2,
    this.iconColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Padding(
        padding: EdgeInsets.all(padding.w),
        child: Icon(
          Icons.person,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
