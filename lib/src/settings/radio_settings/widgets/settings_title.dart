import 'package:flutter/material.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.grey3))),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.text18Bold.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
