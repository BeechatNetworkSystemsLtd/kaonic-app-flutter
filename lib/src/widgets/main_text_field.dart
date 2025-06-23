import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class MainTextField extends StatelessWidget {
  MainTextField({
    this.hint,
    this.onChange,
    this.controller,
    this.suffix,
    this.keyboardType,
    super.key,
  });
  final String? hint;
  final ValueChanged<String>? onChange;
  final TextEditingController? controller;
  final Widget? suffix;
  final TextInputType? keyboardType;

  final _baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(color: AppColors.grey3));

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.grey3,
      style: TextStyles.text14.copyWith(color: Colors.white),
      decoration: InputDecoration(
        isDense: false,
        fillColor: AppColors.grey2,
        filled: true,
        hintText: hint ?? S.of(context).hint,
        hintStyle: TextStyles.text14
            .copyWith(fontStyle: FontStyle.italic, color: AppColors.grey3),
        contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 32.w),
        border: _baseBorder,
        enabledBorder: _baseBorder,
        focusedBorder: _baseBorder,
        suffixIcon: suffix,
      ),
    );
  }
}
