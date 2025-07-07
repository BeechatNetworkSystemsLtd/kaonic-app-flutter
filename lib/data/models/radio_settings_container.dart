import 'package:kaonic/data/models/radio_settings.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class RadioSettingsContainer {
  @Id()
  int id;
  final radioSettingsA = ToOne<RadioSettings>();
  final radioSettingsB = ToOne<RadioSettings>();

  RadioSettingsContainer({
    this.id = 0,
  });
}
