import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class SolidButton extends StatelessWidget {
  final Color color;
  final bool enabled;
  final Color textColor;
  final Color? splashColor;
  final String textButton;
  final VoidCallback? onTap;
  final double borderRadius;
  final IconData? defaultIcon;
  final String? icon;
  final Color? iconColor;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final TextStyle? textStyle; 

  const SolidButton({
    super.key,
    required this.textButton,
    this.icon,
    this.onTap,
    this.padding,
    this.iconColor,
    this.splashColor,
    this.defaultIcon,
    this.enabled = true,
    this.borderRadius = 32,
    this.margin = EdgeInsets.zero,
    this.color = AppColors.white,
    this.textColor = AppColors.black,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            padding ?? EdgeInsets.symmetric(vertical: 16),
          ),
          splashFactory: InkRipple.splashFactory,
          textStyle: WidgetStatePropertyAll(TextStyles.text18.copyWith(
            height: 1,
            fontWeight: FontWeight.w600,
            color: textColor,
          )),
          overlayColor: WidgetStatePropertyAll(
            splashColor ?? AppColors.white.withValues(alpha: 0.25),
          ),
          backgroundColor:
              WidgetStatePropertyAll(enabled ? color : AppColors.grey5),
          foregroundColor: WidgetStatePropertyAll(textColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (enabled) onTap?.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.w,
          children: [
            if (defaultIcon != null)
              Icon(
                defaultIcon,
                color: iconColor,
              )
            else if (icon != null)
              Image.asset(icon!),
            Text(
              textButton,
            ),
          ],
        ),
      ),
    );
  }
}
