import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/models/preset_models/radio_preset_model.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class PresetsDialog extends StatefulWidget {
  const PresetsDialog({
    super.key,
    required this.onYes,
    required this.presets,
  });

  final ValueSetter<RadioPresetModel> onYes;
  final List<RadioPresetModel> presets;

  @override
  State<PresetsDialog> createState() => _PresetsDialogState();
}

class _PresetsDialogState extends State<PresetsDialog> {
  RadioPresetModel? _selectedPreset;

  bool _isSelected(RadioPresetModel preset) {
    return preset == _selectedPreset;
  }

  void _selectPreset(RadioPresetModel preset) {
    setState(() {
      _selectedPreset = preset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                S.of(context).presets,
                textAlign: TextAlign.center,
                style: TextStyles.text18.copyWith(color: Colors.white),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final preset = widget.presets.elementAt(index);

                return ListTile(
                  onTap: () => _selectPreset(preset),
                  title: Text(
                    preset.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.text18.copyWith(color: AppColors.white),
                  ),
                  leading: IgnorePointer(
                    child: Checkbox(
                      value: _isSelected(preset),
                      onChanged: (_) {},
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Container(
                height: 1,
                color: AppColors.grey5,
              ),
              itemCount: widget.presets.length,
            ),
            Row(
              children: [
                Flexible(
                    child: MainButton(
                  width: 150.w,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  label: S.of(context).cancel,
                )),
                SizedBox(width: 10.w),
                Flexible(
                  child: MainButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (_selectedPreset != null) {
                        widget.onYes(_selectedPreset!);
                      }
                    },
                    width: 150.w,
                    label: S.of(context).apply,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
