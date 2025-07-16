import 'package:kaonic/data/enums/phy_config_type_enum.dart';
import 'package:kaonic/data/enums/radio_settings_type_enum.dart';
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

  RadioSettingsContainer? _getSettingContainer() {
    final container = _settingsContainer.getAll().firstOrNull;
    return container;
  }

  RadioSettings get radioSettingsA {
    return _getSettingContainer()?.radioSettingsA.target ?? RadioSettings();
  }

  RadioSettings get radioSettingsB {
    return _getSettingContainer()?.radioSettingsB.target ?? RadioSettings();
  }

  PhyConfigTypeEnum get phyConfig {
    return PhyConfigTypeEnum.values
        .elementAt(_getSettingContainer()?.phyConfig ?? 0);
  }

  RadioSettingsType get radioSettingsType {
    return RadioSettingsType.values
        .elementAt(_getSettingContainer()?.radioSettingsType ?? 0);
  }

  void saveSettings(
    RadioSettings radioSettingsA,
    RadioSettings radioSettingsB,
    int radioSettingsType,
    int phyConfig,
  ) {
    final radioAId = _radioSettingsBox.put(radioSettingsA);
    final radioBId = _radioSettingsBox.put(radioSettingsB);

    final container = RadioSettingsContainer(
      phyConfig: phyConfig,
      radioSettingsType: radioSettingsType,
    );
    container.radioSettingsA.targetId = radioAId;
    container.radioSettingsB.targetId = radioBId;

    _settingsContainer
      ..removeAll()
      ..put(container);
  }
}
