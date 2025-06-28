import 'package:flutter/material.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/src/settings/widgets/settings_item.dart';
import 'package:kaonic/src/widgets/custom_appbar.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/theme/text_styles.dart';

class ConnectivitySettingScreen extends StatelessWidget {
  const ConnectivitySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: S.of(context).connectivitySettings,
      ),
      floatingActionButton: MainButton(
        label: S.of(context).save,
        onPressed: () {
          // TODO
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          children: [
            SizedBox.shrink(),
            SettingsItem(
              S.of(context).ip,
              child: MainTextField(
                keyboardType: TextInputType.number,
              ),
            ),
            SettingsItem(
              S.of(context).port,
              child: MainTextField(
                keyboardType: TextInputType.number,
              ),
            ),
            SettingsItem(
              S.of(context).connectivityType,
              child: DropdownMenu(
                textStyle: TextStyles.text14.copyWith(color: Colors.white),
                onSelected: (type) {
                  // TODO
                },
                dropdownMenuEntries: KaonicCommunicationType.values
                    .map((type) => DropdownMenuEntry(
                          value: type,
                          label: type.title,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
