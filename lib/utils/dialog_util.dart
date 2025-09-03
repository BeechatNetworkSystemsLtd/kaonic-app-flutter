import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:kaonic/data/models/preset_models/radio_preset_model.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/widgets/dialogs/preset_dialog_widget.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

abstract class DialogUtil {
  static void showDefaultDialog(
    BuildContext context, {
    required String title,
    required Function() onYes,
    String? buttonYesText,
    String? buttonNotText,
  }) =>
      showDialog(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: AppColors.black,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style:
                              TextStyles.text18.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Flexible(
                              child: MainButton(
                            width: 150.w,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            label: buttonNotText ?? S.of(context).labelNo,
                          )),
                          SizedBox(width: 10.w),
                          Flexible(
                              child: MainButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    onYes();
                                  },
                                  width: 150.w,
                                  label:
                                      buttonYesText ?? S.of(context).labelYes)),
                        ],
                      )
                    ],
                  ),
                ),
              ));

  static Future<T?> showDefaultDialogWithResult<T>(
    BuildContext context, {
    required String title,
    required VoidCallback onYes,
    String? buttonYesText,
    String? buttonNotText,
  }) =>
      showDialog<T>(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: AppColors.black,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style:
                              TextStyles.text18.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Flexible(
                              child: MainButton(
                            width: 150.w,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            label: buttonNotText ?? S.of(context).labelNo,
                          )),
                          SizedBox(width: 10.w),
                          Flexible(
                              child: MainButton(
                                  onPressed: () {
                                    onYes();
                                  },
                                  width: 150.w,
                                  label:
                                      buttonYesText ?? S.of(context).labelYes)),
                        ],
                      )
                    ],
                  ),
                ),
              ));

  static void showPresetsDialog(
    BuildContext context, {
    required ValueSetter<RadioPresetModel> onYes,
    required List<RadioPresetModel> presets,
  }) =>
      showDialog(
        context: context,
        builder: (context) {
          return PresetsDialog(
            onYes: onYes,
            presets: presets,
          );
        },
      );
}
