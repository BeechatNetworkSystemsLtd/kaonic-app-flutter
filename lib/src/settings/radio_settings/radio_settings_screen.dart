import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/src/settings/radio_settings/bloc/settings_bloc.dart';
import 'package:kaonic/src/settings/widgets/settings_item.dart';
import 'package:kaonic/src/widgets/custom_appbar.dart';
import 'package:kaonic/src/widgets/main_button.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/src/widgets/radio_button.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class RadioSettingsScreen extends StatefulWidget {
  const RadioSettingsScreen({super.key});

  @override
  State<RadioSettingsScreen> createState() => _RadioSettingsScreenState();
}

class _RadioSettingsScreenState extends State<RadioSettingsScreen> {
  final _frequencyController =
      TextEditingController(text: KaonicCommunicationService.defaultFrequency);
  final _spacingController = TextEditingController(
      text: KaonicCommunicationService.defaultChannelSpacing);
  final _txPowerController =
      TextEditingController(text: KaonicCommunicationService.defaultTxPower);

  // Widget _item(String label, {required Widget child}) => Row(
  //       children: [
  //         Text(
  //           label,
  //           style: TextStyles.text18Bold.copyWith(color: Colors.white),
  //         ),
  //         SizedBox(width: 16),
  //         Expanded(child: child),
  //       ],
  //     );

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
  void dispose() {
    _frequencyController.dispose();
    _spacingController.dispose();
    _txPowerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(communicationService: context.read()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: S.of(context).radioSettings,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (ctxBloc, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    child: Text(
                      S.current.radio,
                      style:
                          TextStyles.text18Bold.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  SettingsItem(
                    S.current.Frequency,
                    child: MainTextField(
                      controller: _frequencyController,
                      hint: '',
                      onChange: (value) => ctxBloc
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
                      onChange: (value) => ctxBloc
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
                          value: state.channel,
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
                                      Padding(
                                          padding: EdgeInsets.only(right: 16))
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              ctxBloc
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
                          onChange: (value) => ctxBloc
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
                                  ctxBloc
                                      .read<SettingsBloc>()
                                      .add(UpdateOption(option: value));
                                }
                              },
                              groupValue: state.option,
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
                                  ctxBloc
                                      .read<SettingsBloc>()
                                      .add(UpdateRate(rate: value));
                                }
                              },
                              groupValue: state.rate,
                              value: e),
                        )
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: MainButton(
                      label: S.of(context).save,
                      onPressed: () {
                        ctxBloc.read<SettingsBloc>().add(SaveSettings());
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
