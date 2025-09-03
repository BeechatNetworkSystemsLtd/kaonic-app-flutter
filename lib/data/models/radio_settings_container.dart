import 'package:kaonic/data/models/radio_settings.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class RadioSettingsContainer {
  @Id()
  int id;
  final radioSettingsA = ToOne<RadioSettings>();
  final radioSettingsB = ToOne<RadioSettings>();
  final int radioSettingsType;
  final int phyConfig;

  RadioSettingsContainer({
    this.id = 0,
    this.phyConfig = 0,
    this.radioSettingsType = 0,
  });
}
