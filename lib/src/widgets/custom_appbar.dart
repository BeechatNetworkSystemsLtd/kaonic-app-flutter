import 'package:flutter/material.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final double? leadingWidth;
  final Color backgroundColor;
  final Widget? leadingWidget;
  final bool showLeadingWidget;
  final Widget? customActionButton;

  const CustomAppbar({
    super.key,
    this.title = '',
    this.leadingWidth,
    this.leadingWidget,
    this.customActionButton,
    this.centerTitle = true,
    this.showLeadingWidget = true,
    this.backgroundColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: leadingWidth,
      leading: showLeadingWidget
          ? leadingWidget ?? BackButton(color: AppColors.white)
          : null,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: TextStyles.text24.copyWith(color: Colors.white),
      ),
      actions: [
        if (customActionButton != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: customActionButton!,
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
