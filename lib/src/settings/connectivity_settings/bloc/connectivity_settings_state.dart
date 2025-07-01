part of 'connectivity_settings_bloc.dart';

class ConnectivitySettingsState {
  final bool isChangesSaved;
  final ConnectivitySettings connectivitySettings;

  const ConnectivitySettingsState({
    this.isChangesSaved = false,
    required this.connectivitySettings,
  });

  ConnectivitySettingsState copyWith({
    bool? isChangesSaved,
    ConnectivitySettings? connectivitySettings,
  }) {
    return ConnectivitySettingsState(
      isChangesSaved: isChangesSaved ?? this.isChangesSaved,
      connectivitySettings: connectivitySettings ?? this.connectivitySettings,
    );
  }

  bool get settingsHasChanges =>
      connectivitySettings.ip.trim().isNotEmpty &&
      connectivitySettings.port.trim().isNotEmpty;
}
