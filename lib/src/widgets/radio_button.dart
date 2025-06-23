import 'package:flutter/material.dart';
import 'package:kaonic/theme/text_styles.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    required this.label,
    required this.onChanged,
    required this.groupValue,
    required this.value,
    super.key,
  });
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyles.text14.copyWith(color: Colors.white),
        ),
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: Colors.white,
        )
      ],
    );
  }
}
