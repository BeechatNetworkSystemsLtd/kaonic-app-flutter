import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/enums/phy_config_type_enum.dart';
import 'package:kaonic/data/enums/radio_settings_type_enum.dart';
import 'package:kaonic/data/extensions/radio_settings_type_extension.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/settings/radio_settings/bloc/settings_bloc.dart';
import 'package:kaonic/src/settings/radio_settings/widgets/fsk_setting_widget.dart';
import 'package:kaonic/src/settings/radio_settings/widgets/ofdm_setting_widget.dart';
import 'package:kaonic/src/settings/widgets/settings_item.dart';
import 'package:kaonic/src/widgets/custom_appbar.dart';
import 'package:kaonic/src/widgets/custom_selected_button.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/theme/theme.dart';
import 'package:kaonic/utils/dialog_util.dart';

class RadioSettingsScreen extends StatelessWidget {
  const RadioSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(
        context.read(),
        communicationService: context.read(),
      ),
      child: Builder(
        builder: (context) {
          final bloc = context.read<SettingsBloc>();

          return Scaffold(
            appBar: CustomAppbar(
              title: S.of(context).radioSettings,
            ),
            floatingActionButton: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                  label: S.of(context).save,
                  onPressed: () {
                    bloc.add(SaveSettings());
                  },
                ),
                MainButton(
                  label: S.of(context).presets,
                  width: 150,
                  onPressed: () {
                    DialogUtil.showPresetsDialog(
                      context,
                      onYes: (preset) {
                        bloc.add(SetPreset(preset));
                      },
                      presets: bloc.state.presets,
                    );
                  },
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (ctxBloc, state) {
                  return Column(
                    spacing: 32,
                    children: [
                      Row(
                        spacing: 25,
                        children: RadioSettingsType.values
                            .map(
                              (value) => Expanded(
                                child: CustomSelectedButton<RadioSettingsType>(
                                  text: value.title,
                                  onTap: (value) {
                                    ctxBloc
                                        .read<SettingsBloc>()
                                        .add(UpdateRadioType(value));
                                  },
                                  value: value,
                                  borderRadius: 12,
                                  groupValue: state.radioSettingsType,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Expanded(
                        child: _RadioSettingsWidget(
                          radioSettings: state.radioSettings,
                        ),
                      ),
                      SizedBox(height: 55),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RadioSettingsWidget extends StatefulWidget {
  final RadioSettings radioSettings;
  const _RadioSettingsWidget({
    required this.radioSettings,
  });

  @override
  State<_RadioSettingsWidget> createState() => _RadioSettingsWidgetState();
}

class _RadioSettingsWidgetState extends State<_RadioSettingsWidget> {
  late final TextEditingController _frequencyController;
  late final TextEditingController _spacingController;
  late final TextEditingController _txPowerController;

  void _updateControllers(SettingsState state) {
    _frequencyController.text = state.radioSettings.frequency;
    _spacingController.text = state.radioSettings.channelSpacing;
    _txPowerController.text = state.radioSettings.txPower;
  }

  @override
  void initState() {
    super.initState();
    _frequencyController =
        TextEditingController(text: widget.radioSettings.frequency);
    _spacingController =
        TextEditingController(text: widget.radioSettings.channelSpacing);
    _txPowerController =
        TextEditingController(text: widget.radioSettings.txPower);
  }

  @override
  void dispose() {
    _frequencyController.dispose();
    _spacingController.dispose();
    _txPowerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listenWhen: (prev, curr) =>
          prev.radioSettingsType != curr.radioSettingsType ||
          prev.radioSettings != curr.radioSettings,
      listener: (context, state) {
        _updateControllers(state);
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              SettingsItem(
                S.current.Frequency,
                child: MainTextField(
                  controller: _frequencyController,
                  hint: '',
                  onChange: (value) => context
                      .read<SettingsBloc>()
                      .add(UpdateFrequency(frequency: value)),
                  keyboardType: TextInputType.number,
                  suffix: Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: Text('kHz',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              SettingsItem(
                S.current.txPower,
                child: MainTextField(
                  controller: _txPowerController,
                  hint: '',
                  onChange: (value) => context
                      .read<SettingsBloc>()
                      .add(UpdateTxPower(txPower: value)),
                  keyboardType: TextInputType.number,
                  suffix: Padding(
                    padding: EdgeInsets.only(top: 14.h),
                    child: Text('dB',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              SettingsItem(S.current.Channel,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: AppColors.grey2,
                    ),
                    child: DropdownButton<int>(
                      value: state.radioSettings.channel,
                      isExpanded: true,
                      items: List.generate(11, (index) => index + 1)
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<SettingsBloc>()
                              .add(UpdateChannel(channel: value));
                        }
                      },
                    ),
                  )),
              SettingsItem(S.current.ChannelSpacing,
                  child: MainTextField(
                      controller: _spacingController,
                      hint: '',
                      onChange: (value) => context
                          .read<SettingsBloc>()
                          .add(UpdateChannelSpacing(spacing: value)),
                      keyboardType: TextInputType.number,
                      suffix: Padding(
                        padding: EdgeInsets.only(top: 14.h),
                        child: Text('kHz',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            )),
                      ))),
              SizedBox(height: 2),
              Text(
                "Modulation Settings".toUpperCase(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 2),
              Row(
                spacing: 25,
                children: PhyConfigTypeEnum.values
                    .map(
                      (value) => Expanded(
                        child: CustomSelectedButton<PhyConfigTypeEnum>(
                          text: value.name.toUpperCase(),
                          onTap: (value) {
                            context
                                .read<SettingsBloc>()
                                .add(UpdateRadioOfdmFckType(value));
                          },
                          value: value,
                          borderRadius: 12,
                          groupValue: state.phyConfig,
                        ),
                      ),
                    )
                    .toList(),
              ),
              switch (state.phyConfig) {
                PhyConfigTypeEnum.ofdm => OfdmSettingWidget(),
                PhyConfigTypeEnum.fsk =>
                  FskSettingWidget(radioSettings: state.radioSettings),
              }
            ],
          ),
        );
      },
    );
  }
}
