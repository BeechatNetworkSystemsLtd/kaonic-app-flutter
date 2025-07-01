import 'package:kaonic/data/repository/storage.dart';
import 'package:kaonic/data/models/connectivity_settings.dart';

import '../../objectbox.g.dart';

class ConnectivitySettingsRepository {
  ConnectivitySettingsRepository({required StorageService storageService}) {
    _settingsContainer = storageService.initRepository<ConnectivitySettings>();
  }

  late final Box<ConnectivitySettings> _settingsContainer;

  ConnectivitySettings getConnectivitySetting() {
    if (_settingsContainer.isEmpty()) return ConnectivitySettings();

    return _settingsContainer.getAll().first;
  }

  void saveSettings(ConnectivitySettings setting) {
    _settingsContainer
      ..removeAll()
      ..put(setting);
  }
}
