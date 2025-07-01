import 'package:kaonic/data/enums/radio_settings_type_enum.dart';

extension RadioSettingsTypeExtension on RadioSettingsType {
  String get title {
    switch (this) {
      case RadioSettingsType.rfa:
        return 'RF-A';
      case RadioSettingsType.rfb:
        return 'RF-B';
    }
  }
}
