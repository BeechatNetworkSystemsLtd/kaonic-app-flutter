import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

@Entity()
class MessageDataContainer {
  @Id()
  int id;
  final String jsonString;

  MessageDataContainer({
    this.id = 0,
    required this.jsonString,
  });
}
