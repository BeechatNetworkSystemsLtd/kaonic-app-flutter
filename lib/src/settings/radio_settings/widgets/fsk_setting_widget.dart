import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/extensions/fsk_bandwidth_extension.dart';
import 'package:kaonic/data/extensions/midsx_extension.dart';
import 'package:kaonic/data/extensions/midx_bits_extension.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/generated/l10n.dart';
import 'package:kaonic/src/settings/radio_settings/bloc/settings_bloc.dart';
import 'package:kaonic/src/settings/radio_settings/widgets/setting_item_with_radio.dart';
import 'package:kaonic/src/settings/radio_settings/widgets/settings_title.dart';
import 'package:kaonic/src/settings/widgets/settings_item.dart';
import 'package:kaonic/src/widgets/main_text_field.dart';
import 'package:kaonic/src/widgets/radio_button.dart';
import 'package:kaonic/theme/text_styles.dart';
import 'package:kaonic/theme/theme.dart';

class FskSettingWidget extends StatefulWidget {
  final RadioSettings radioSettings;
  const FskSettingWidget({
    super.key,
    required this.radioSettings,
  });

  @override
  State<FskSettingWidget> createState() => _FskSettingWidgetState();
}

class _FskSettingWidgetState extends State<FskSettingWidget> {
  late final TextEditingController _preemphasis0Controller;
  late final TextEditingController _preemphasis1Controller;
  late final TextEditingController _preemphasis2Controller;
  late final TextEditingController _preambleLengthController;

  @override
  void initState() {
    super.initState();
    _preemphasis0Controller =
        TextEditingController(text: widget.radioSettings.fskpe0.toString());
    _preemphasis1Controller =
        TextEditingController(text: widget.radioSettings.fskpe1.toString());
    _preemphasis2Controller =
        TextEditingController(text: widget.radioSettings.fskpe2.toString());
    _preambleLengthController = TextEditingController(
        text: widget.radioSettings.preambleLength.toString());
  }

  @override
  void dispose() {
    _preemphasis0Controller.dispose();
    _preemphasis1Controller.dispose();
    _preemphasis2Controller.dispose();
    _preambleLengthController.dispose();
    super.dispose();
  }

  void _updateControllers(RadioSettings settings) {
    _preemphasis0Controller.text = settings.fskpe0.toString();
    _preemphasis1Controller.text = settings.fskpe1.toString();
    _preemphasis2Controller.text = settings.fskpe2.toString();
    _preambleLengthController.text = settings.preambleLength.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listenWhen: (prev, curr) =>
          prev.radioSettingsType != curr.radioSettingsType,
      listener: (context, state) {
        _updateControllers(state.radioSettings);
      },
      child: BlocSelector<SettingsBloc, SettingsState, RadioSettings>(
        selector: (state) => state.radioSettings,
        builder: (context, radioSettings) {
          final bloc = context.read<SettingsBloc>();
          return Column(
            spacing: 16,
            children: [
              SettingTitle(title: S.of(context).fsk),
              SettingsItem(
                S.current.bandwidthTime,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.bandwidthTime,
                    isExpanded: true,
                    items: FSKBandwidthTime.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<SettingsBloc>()
                            .add(UpdateBandwidthTime(value));
                      }
                    },
                  ),
                ),
              ),
              SettingsItem(
                S.current.modulationIndexScale,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.midxs,
                    isExpanded: true,
                    items: MIDXS.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.add(UpdateMIDXS(value));
                      }
                    },
                  ),
                ),
              ),
              SettingsItem(
                S.current.modulationIndex,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.midxsBits,
                    isExpanded: true,
                    items: MIDXSBits.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.add(UpdateMIDXSBits(value));
                      }
                    },
                  ),
                ),
              ),
              SettingsItem(
                S.current.modulationOrder,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.mord,
                    isExpanded: true,
                    items: FSKModulationOrder.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.add(UpdateMord(value));
                      }
                    },
                  ),
                ),
              ),
              SettingsItem(
                S.current.symbolRate,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.srate,
                    isExpanded: true,
                    items: FSKSymbolRate.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.add(UpdateSRate(value));
                      }
                    },
                  ),
                ),
              ),
              ItemWithRadio(
                label: S.current.pdtm,
                list: PDTMMode.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdatePDTM(value));
                          }
                        },
                        groupValue: radioSettings.pdtm,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.rxo,
                list: RXOOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateRXO(value));
                          }
                        },
                        groupValue: radioSettings.rxo,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.rxpto,
                list: RXPTOOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateRXPTO(value));
                          }
                        },
                        groupValue: radioSettings.rxpto,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.mse,
                list: MSEOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateMSE(value));
                          }
                        },
                        groupValue: radioSettings.mse,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.fecs,
                list: FECSOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateFECS(value));
                          }
                        },
                        groupValue: radioSettings.fecs,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.fecie,
                list: FECIEOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateFECIE(value));
                          }
                        },
                        groupValue: radioSettings.fecie,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.sfd32,
                list: SFD32Option.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateSFD32(value));
                          }
                        },
                        groupValue: radioSettings.sfd32,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              SettingsItem(
                S.current.csfd1,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.csfd1,
                    isExpanded: true,
                    items: CSFD1Option.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.add(UpdateCSFD1(value));
                      }
                    },
                  ),
                ),
              ),
              SettingsItem(
                S.current.csfd0,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.grey2,
                  ),
                  child: DropdownButton(
                    value: radioSettings.csfd0,
                    isExpanded: true,
                    items: CSFD0Option.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    e.description,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 16))
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        bloc.add(UpdateCSFD0(value));
                      }
                    },
                  ),
                ),
              ),
              ItemWithRadio(
                label: S.current.sfd,
                list: SFDOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateSFD(value));
                          }
                        },
                        groupValue: radioSettings.sfd,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              ItemWithRadio(
                label: S.current.dw,
                list: DWOption.values
                    .map(
                      (e) => CustomRadioButton(
                        label: e.name,
                        onChanged: (value) {
                          if (value != null) {
                            bloc.add(UpdateDW(value));
                          }
                        },
                        groupValue: radioSettings.dw,
                        value: e,
                      ),
                    )
                    .toList(),
              ),
              _ItemWithCheckBox(
                label: S.current.frequencyInversion,
                isSelected: radioSettings.freqInversion,
                onCheck: (value) {
                  if (value == null) return;
                  bloc.add(UpdateFreqInversion(value));
                },
              ),
              _ItemWithCheckBox(
                label: S.current.preambleInversion,
                isSelected: radioSettings.preambleInversion,
                onCheck: (value) {
                  if (value == null) return;
                  bloc.add(UpdatePreambleInversion(value));
                },
              ),
              _ItemWithCheckBox(
                label: S.current.sftq,
                isSelected: radioSettings.sftq,
                onCheck: (value) {
                  if (value == null) return;
                  bloc.add(UpdateSftq(value));
                },
              ),
              _ItemWithCheckBox(
                label: S.current.rawbit,
                isSelected: radioSettings.rawbit,
                onCheck: (value) {
                  if (value == null) return;
                  bloc.add(UpdateRawbit(value));
                },
              ),
              _ItemWithCheckBox(
                label: S.current.pe,
                isSelected: radioSettings.pe,
                onCheck: (value) {
                  if (value == null) return;
                  bloc.add(UpdatePe(value));
                },
              ),
              _ItemWithCheckBox(
                label: S.current.en,
                isSelected: radioSettings.en,
                onCheck: (value) {
                  if (value == null) return;
                  bloc.add(UpdateEn(value));
                },
              ),
              SettingsItem(
                '${S.current.preemphasis} 0',
                child: MainTextField(
                  controller: _preemphasis0Controller,
                  hint: 'values 0 - 255',
                  onChange: (value) {
                    if (value.isEmpty) return;
                    bloc.add(UpdateFSKPE(fskpe0: int.parse(value)));
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              SettingsItem(
                '${S.current.preemphasis} 1',
                child: MainTextField(
                  controller: _preemphasis1Controller,
                  hint: 'values 0 - 255',
                  onChange: (value) {
                    if (value.isEmpty) return;
                    bloc.add(UpdateFSKPE(fskpe1: int.parse(value)));
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              SettingsItem(
                '${S.current.preemphasis} 2',
                child: MainTextField(
                  controller: _preemphasis2Controller,
                  hint: 'values 0 - 255',
                  onChange: (value) {
                    if (value.isEmpty) return;
                    bloc.add(UpdateFSKPE(fskpe2: int.parse(value)));
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
              SettingsItem(
                S.current.preambleLength,
                child: MainTextField(
                  controller: _preambleLengthController,
                  hint: 'values 0 - 1023',
                  onChange: (value) {
                    if (value.isEmpty) return;
                    bloc.add(UpdatePreambleLenght(int.parse(value)));
                  },
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ItemWithCheckBox extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool?> onCheck;

  const _ItemWithCheckBox({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.text18Bold.copyWith(color: Colors.white),
        ),
        Checkbox(value: isSelected, onChanged: onCheck),
      ],
    );
  }
}
