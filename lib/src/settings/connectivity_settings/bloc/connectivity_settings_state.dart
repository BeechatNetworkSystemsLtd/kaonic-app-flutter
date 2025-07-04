part of 'connectivity_settings_bloc.dart';

class ConnectivitySettingsState {
  final bool isChangesSaved;
  final String ipAddressValidationErrorText;
  final ConnectivitySettings connectivitySettings;

  const ConnectivitySettingsState({
    this.isChangesSaved = false,
    required this.connectivitySettings,
    this.ipAddressValidationErrorText = '',
  });

  ConnectivitySettingsState copyWith({
    bool? isChangesSaved,
    String? ipAddressValidationErrorText,
    ConnectivitySettings? connectivitySettings,
  }) {
    return ConnectivitySettingsState(
      isChangesSaved: isChangesSaved ?? this.isChangesSaved,
      connectivitySettings: connectivitySettings ?? this.connectivitySettings,
      ipAddressValidationErrorText:
          ipAddressValidationErrorText ?? this.ipAddressValidationErrorText,
    );
  }

  bool get settingsHasChanges =>
      connectivitySettings.ip.trim().isNotEmpty &&
      connectivitySettings.port.trim().isNotEmpty &&
      ipAddressValidationErrorText.isEmpty;
}
