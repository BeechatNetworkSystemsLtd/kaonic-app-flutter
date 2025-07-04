// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState {
  SettingsState({
    this.radioSettingsType = RadioSettingsType.rfa,
    this.phyConfig = PhyConfigTypeEnum.ofdm,
    required this.radioSettingsA,
    required this.radioSettingsB,
    this.presets = const [],
  });

  final RadioSettingsType radioSettingsType;
  final PhyConfigTypeEnum phyConfig;
  final RadioSettings radioSettingsA;
  final RadioSettings radioSettingsB;
  final List<RadioPresetModel> presets;

  bool get _isRfa => radioSettingsType == RadioSettingsType.rfa;

  RadioSettings get radioSettings => _isRfa ? radioSettingsA : radioSettingsB;

  bool get buttonEnabled {
    RadioSettings settings = _isRfa ? radioSettingsA : radioSettingsB;
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
    List<RadioPresetModel>? presets,
  }) {
    return SettingsState(
      presets: presets ?? this.presets,
      radioSettingsA: radioSettingsA ?? this.radioSettingsA,
      phyConfig: phyConfig ?? this.phyConfig,
      radioSettingsB: radioSettingsB ?? this.radioSettingsB,
      radioSettingsType: radioSettingsType ?? this.radioSettingsType,
    );
  }
}
