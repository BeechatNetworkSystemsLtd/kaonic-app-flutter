import 'package:flutter/material.dart';
import 'package:kaonic/theme/text_styles.dart';

class ItemWithRadio extends StatelessWidget {
  final String label;
  final List<Widget> list;
  const ItemWithRadio({
    super.key,
    required this.label,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.text18Bold.copyWith(color: Colors.white),
        ),
        GridView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3.8,
          ),
          children: list,
        ),
      ],
    );
  }
}
