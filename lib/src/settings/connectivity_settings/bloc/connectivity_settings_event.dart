part of 'connectivity_settings_bloc.dart';

@immutable
class ConnectivitySettingsEvent {}

class SaveChanges extends ConnectivitySettingsEvent {}

class ChangeSettings extends ConnectivitySettingsEvent {
  final ConnectivitySettings settings;

  ChangeSettings(this.settings);
}
