// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState {
  SettingsState({
    this.radioSettingsType = RadioSettingsType.rfa,
    required this.radioSettingsA,
    required this.radioSettingsB,
  });

  final RadioSettingsType radioSettingsType;
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
    RadioSettings? radioSettingsA,
    RadioSettings? radioSettingsB,
  }) {
    return SettingsState(
      radioSettingsA: radioSettingsA ?? this.radioSettingsA,
      radioSettingsB: radioSettingsB ?? this.radioSettingsB,
      radioSettingsType: radioSettingsType ?? this.radioSettingsType,
    );
  }
}
