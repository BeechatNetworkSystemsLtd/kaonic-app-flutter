import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class MessageDataContainer {
  @Id()
  int id;
  final String jsonString;
  final String contactChatsJson;

  MessageDataContainer({
    this.id = 0,
    required this.jsonString,
    required this.contactChatsJson,
  });

  Map<String, String> get contactChats =>
      Map<String, String>.from(jsonDecode(contactChatsJson));
}
