import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/settings/radio_settings/bloc/settings_bloc.dart';
import 'package:kaonic/src/settings/radio_settings/widgets/setting_item_with_radio.dart';
import 'package:kaonic/src/widgets/radio_button.dart';

class OfdmSettingWidget extends StatelessWidget {
  const OfdmSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, RadioSettings>(
      selector: (state) => state.radioSettings,
      builder: (context, radioSettings) {
        return Column(
          spacing: 16,
          children: [
            ItemWithRadio(
              label: S.current.option,
              list: OFDMOptions.values
                  .map(
                    (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<SettingsBloc>()
                                .add(UpdateOption(option: value));
                          }
                        },
                        groupValue: radioSettings.option,
                        value: e),
                  )
                  .toList(),
            ),
            SizedBox(height: 8),
            ItemWithRadio(
              label: S.current.mcs,
              list: OFDMRate.values
                  .map(
                    (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            context
                                .read<SettingsBloc>()
                                .add(UpdateRate(rate: value));
                          }
                        },
                        groupValue: radioSettings.rate,
                        value: e),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
