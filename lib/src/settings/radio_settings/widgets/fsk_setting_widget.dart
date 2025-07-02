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
import 'package:kaonic/src/widgets/radio_button.dart';
import 'package:kaonic/theme/theme.dart';

class FskSettingWidget extends StatelessWidget {
  const FskSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, RadioSettings>(
      selector: (state) => state.radioSettings,
      builder: (context, radioSettings) {
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
                      context.read<SettingsBloc>().add(UpdateMIDXS(value));
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
                      context.read<SettingsBloc>().add(UpdateMIDXSBits(value));
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
                      context.read<SettingsBloc>().add(UpdateMord(value));
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
                      context.read<SettingsBloc>().add(UpdateSRate(value));
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
                          context.read<SettingsBloc>().add(UpdatePDTM(value));
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
                          context.read<SettingsBloc>().add(UpdateRXO(value));
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
                          context.read<SettingsBloc>().add(UpdateRXPTO(value));
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
                          context.read<SettingsBloc>().add(UpdateMSE(value));
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
                          context.read<SettingsBloc>().add(UpdateFECS(value));
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
                          context.read<SettingsBloc>().add(UpdateFECIE(value));
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
                          context.read<SettingsBloc>().add(UpdateSFD32(value));
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
                      context.read<SettingsBloc>().add(UpdateCSFD1(value));
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
                      context.read<SettingsBloc>().add(UpdateCSFD0(value));
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
                          context.read<SettingsBloc>().add(UpdateSFD(value));
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
                          context.read<SettingsBloc>().add(UpdateDW(value));
                        }
                      },
                      groupValue: radioSettings.dw,
                      value: e,
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
