// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState {
  SettingsState({
    this.radioSettingsType = RadioSettingsType.rfa,
    this.phyConfig = PhyConfigTypeEnum.ofdm,
    required this.radioSettingsA,
    required this.radioSettingsB,
  });

  final RadioSettingsType radioSettingsType;
  final PhyConfigTypeEnum phyConfig;
  final RadioSettings radioSettingsA;
  final RadioSettings radioSettingsB;

  RadioSettings get radioSettings => radioSettingsType == RadioSettingsType.rfa
      ? radioSettingsA
      : radioSettingsB;

  bool get buttonEnabled {
    RadioSettings settings = radioSettingsType == RadioSettingsType.rfa
        ? radioSettingsA
        : radioSettingsB;
    return settings.frequency.isNotEmpty &&
        int.tryParse(settings.frequency) != null &&
        settings.txPower.isNotEmpty &&
        int.tryParse(settings.txPower) != null &&
        settings.channelSpacing.isNotEmpty &&
        int.tryParse(settings.channelSpacing) != null;
  }

  SettingsState copyWith({
    RadioSettingsType? radioSettingsType,
    PhyConfigTypeEnum? phyConfig,
    RadioSettings? radioSettingsA,
    RadioSettings? radioSettingsB,
  }) {
    return SettingsState(
      radioSettingsA: radioSettingsA ?? this.radioSettingsA,
      phyConfig: phyConfig ?? this.phyConfig,
      radioSettingsB: radioSettingsB ?? this.radioSettingsB,
      radioSettingsType: radioSettingsType ?? this.radioSettingsType,
    );
  }
}
