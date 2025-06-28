import 'package:flutter/material.dart';
import 'package:kaonic/theme/text_styles.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
    this.label, {
    super.key,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyles.text18Bold.copyWith(color: Colors.white),
        ),
        SizedBox(width: 16),
        Expanded(child: child),
      ],
    );
  }
}
