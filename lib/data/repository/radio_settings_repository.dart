import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/data/models/radio_settings_container.dart';
import 'package:kaonic/data/repository/storage.dart';

import '../../objectbox.g.dart';

class RadioSettingsRepository {
  RadioSettingsRepository({required StorageService storageService}) {
    _settingsContainer =
        storageService.initRepository<RadioSettingsContainer>();
    _radioSettingsBox = storageService.initRepository<RadioSettings>();
  }

  late final Box<RadioSettingsContainer> _settingsContainer;
  late final Box<RadioSettings> _radioSettingsBox;

  RadioSettingsContainer? getSettingContainer() {
    final container = _settingsContainer.getAll().firstOrNull;
    return container;
  }

  void saveSettings(
    RadioSettings radioSettingsA,
    RadioSettings radioSettingsB,
  ) {
    final radioAId = _radioSettingsBox.put(radioSettingsA);
    final radioBId = _radioSettingsBox.put(radioSettingsB);

    final container = RadioSettingsContainer();
    container.radioSettingsA.targetId = radioAId;
    container.radioSettingsB.targetId = radioBId;

    _settingsContainer
      ..removeAll()
      ..put(container);
  }
}
