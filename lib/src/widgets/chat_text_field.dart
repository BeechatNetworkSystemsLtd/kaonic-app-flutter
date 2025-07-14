import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    this.onChange,
    this.controller,
    this.keyboardType,
    this.errorText = '',
    required this.onSendMessage,
    required this.onFilePick,
    super.key,
  });

  final ValueChanged<String>? onChange;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String errorText;
  final VoidCallback onSendMessage;
  final VoidCallback onFilePick;

  // final _baseBorder = OutlineInputBorder(
  //     borderRadius: BorderRadius.circular(22),
  //     borderSide: const BorderSide(color: AppColors.grey3));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TextField(
              onChanged: onChange,
              controller: controller,
              keyboardType: keyboardType,
              cursorColor: AppColors.grey3,
              style: TextStyles.text14.copyWith(color: Colors.white),
              decoration: InputDecoration(
                isDense: false,
                hintText: S.of(context).typeAMessage,
                hintStyle: TextStyles.text14.copyWith(
                    fontStyle: FontStyle.italic, color: AppColors.grey3),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 13.h, horizontal: 32.w),
                border: InputBorder.none,
                suffixIcon: _ChatActionIconButton(
                  icon: Icons.send,
                  onTap: onSendMessage,
                ),
                prefixIcon: _ChatActionIconButton(
                  onTap: onFilePick,
                  icon: Icons.add_circle,
                ),
              ),
            ),
          ),
        ),
        if (errorText.isNotEmpty) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              errorText,
              style: TextStyles.text16.copyWith(color: AppColors.red),
            ),
          ),
        ],
      ],
    );
  }
}

class _ChatActionIconButton extends StatelessWidget {
  const _ChatActionIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.color = AppColors.white,
  });

  final VoidCallback onTap;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
