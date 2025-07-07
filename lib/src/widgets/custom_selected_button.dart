import 'package:flutter/material.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class CustomSelectedButton<T> extends StatelessWidget {
  final T value;
  final String text;
  final T groupValue;
  final bool withAlign;
  final double? borderRadius;
  final ValueChanged<T> onTap;

  const CustomSelectedButton({
    super.key,
    this.borderRadius,
    required this.text,
    required this.onTap,
    required this.value,
    this.withAlign = true,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final bgColor = isSelected ? AppColors.yellow : AppColors.white;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isSelected ? bgColor : null,
        border: isSelected ? null : Border.all(color: bgColor, width: 3),
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
      ),
      child: InkWell(
        onTap: () => onTap(value),
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          child: withAlign
              ? Align(
                  child: Text(
                    text,
                    style: TextStyles.text18.copyWith(
                        color: isSelected ? AppColors.black : Colors.white,
                        fontWeight: isSelected ? FontWeight.bold : null),
                  ),
                )
              : Text(
                  text,
                  style: TextStyles.text18.copyWith(
                      color: isSelected ? AppColors.black : Colors.white),
                ),
        ),
      ),
    );
  }
}
