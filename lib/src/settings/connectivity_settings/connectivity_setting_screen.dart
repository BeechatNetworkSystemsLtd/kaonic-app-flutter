import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/extensions/communication_type_extension.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/src/settings/connectivity_settings/bloc/connectivity_settings_bloc.dart';
import 'package:kaonic/src/settings/widgets/settings_item.dart';
import 'package:kaonic/src/widgets/custom_appbar.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/theme/text_styles.dart';

class ConnectivitySettingScreen extends StatefulWidget {
  const ConnectivitySettingScreen({super.key});

  @override
  State<ConnectivitySettingScreen> createState() =>
      _ConnectivitySettingScreenState();
}

class _ConnectivitySettingScreenState extends State<ConnectivitySettingScreen> {
  final _ipController = TextEditingController();
  final _portController = TextEditingController();
  late final ConnectivitySettingsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _initConnectivitySettings();
  }

  void _initConnectivitySettings() {
    _bloc = ConnectivitySettingsBloc(
      context.read(),
      context.read(),
    );

    _ipController.text = _bloc.state.connectivitySettings.ip;
    _portController.text = _bloc.state.connectivitySettings.port;
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<ConnectivitySettingsBloc, ConnectivitySettingsState>(
        listenWhen: (prev, curr) => prev.isChangesSaved != curr.isChangesSaved,
        listener: (context, state) {
          if (state.isChangesSaved) Navigator.pop(context);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppbar(
              title: S.of(context).connectivitySettings,
            ),
            floatingActionButton: MainButton(
              label: S.of(context).save,
              onPressed: () {
                if (state.settingsHasChanges) {
                  _bloc.add(SaveChanges());
                }
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 16,
                children: [
                  SizedBox.shrink(),
                  SettingsItem(
                    S.of(context).ip,
                    child: MainTextField(
                      controller: _ipController,
                      keyboardType: TextInputType.number,
                      errorText: state.ipAddressValidationErrorText,
                      onChange: (ip) => _bloc.add(ChangeSettings(
                          state.connectivitySettings.copyWith(ip: ip))),
                    ),
                  ),
                  SettingsItem(
                    S.of(context).port,
                    child: MainTextField(
                      controller: _portController,
                      keyboardType: TextInputType.number,
                      onChange: (port) => _bloc.add(ChangeSettings(
                          state.connectivitySettings.copyWith(port: port))),
                    ),
                  ),
                  SettingsItem(
                    S.of(context).connectivityType,
                    child: DropdownMenu(
                      initialSelection: state.connectivitySettings.type,
                      textStyle:
                          TextStyles.text14.copyWith(color: Colors.white),
                      onSelected: (type) {
                        _bloc.add(
                          ChangeSettings(
                            state.connectivitySettings
                                .copyWith(connectivityType: type?.index),
                          ),
                        );
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
        },
      ),
    );
  }
}
