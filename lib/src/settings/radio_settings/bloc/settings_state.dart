// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState {
  SettingsState({
    this.radioSettingsType = RadioSettingsType.rfa,
    this.radioSettings = const RadioSettings(),
  });

  final RadioSettingsType radioSettingsType;
  final RadioSettings radioSettings;

  bool get buttonEnabled =>
      radioSettings.frequency.isNotEmpty &&
      int.tryParse(radioSettings.frequency) != null &&
      radioSettings.txPower.isNotEmpty &&
      int.tryParse(radioSettings.txPower) != null &&
      radioSettings.channelSpacing.isNotEmpty &&
      int.tryParse(radioSettings.channelSpacing) != null;

  SettingsState copyWith({
    RadioSettingsType? radioSettingsType,
    RadioSettings? radioSettings,
  }) {
    return SettingsState(
      radioSettings: radioSettings ?? this.radioSettings,
      radioSettingsType: radioSettingsType ?? this.radioSettingsType,
    );
  }
}
