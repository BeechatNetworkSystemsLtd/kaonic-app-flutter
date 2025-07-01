import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/enums/radio_settings_type_enum.dart';
import 'package:kaonic/data/extensions/radio_settings_type_extension.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/src/settings/radio_settings/bloc/settings_bloc.dart';
import 'package:kaonic/src/settings/widgets/settings_item.dart';
import 'package:kaonic/src/widgets/custom_appbar.dart';
import 'package:kaonic/src/widgets/custom_selected_button.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/src/widgets/radio_button.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class RadioSettingsScreen extends StatelessWidget {
  const RadioSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(communicationService: context.read()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: S.of(context).radioSettings,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: MainButton(
            label: S.of(context).save,
            onPressed: () {
              context.read<SettingsBloc>().add(SaveSettings());
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctxBloc, state) {
              return Column(
                spacing: 24,
                children: [
                  SizedBox.shrink(),
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
                              groupValue: state.radioSettingsType,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Expanded(child: _RadioSettingsWidget()),
                  SizedBox(height: 76),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RadioSettingsWidget extends StatefulWidget {
  const _RadioSettingsWidget({super.key});

  @override
  State<_RadioSettingsWidget> createState() => _RadioSettingsWidgetState();
}

class _RadioSettingsWidgetState extends State<_RadioSettingsWidget> {
  final _frequencyController =
      TextEditingController(text: KaonicCommunicationService.defaultFrequency);
  final _spacingController = TextEditingController(
      text: KaonicCommunicationService.defaultChannelSpacing);
  final _txPowerController =
      TextEditingController(text: KaonicCommunicationService.defaultTxPower);

  Widget _itemWithRadio(
    String label, {
    required List<Widget> list,
  }) =>
      Column(
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
                childAspectRatio: 3.8),
            children: list,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Align(
                child: Text(
                  S.current.radio,
                  style: TextStyles.text18Bold.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 24),
              _itemWithRadio(
                S.current.OFDMOption,
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
                          groupValue: state.radioSettings.option,
                          value: e),
                    )
                    .toList(),
              ),
              SizedBox(height: 24),
              _itemWithRadio(
                S.current.OFDMRate,
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
                          groupValue: state.radioSettings.rate,
                          value: e),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
