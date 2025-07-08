import 'dart:convert';

import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/data/models/message_data_container.dart';
import 'package:kaonic/data/repository/storage.dart';

import '../../objectbox.g.dart';

class MessagesRepository {
  MessagesRepository({required StorageService storageService}) {
    _messagesContainer = storageService.initRepository<MessageDataContainer>();
  }

  late final Box<MessageDataContainer> _messagesContainer;

  Map<String, List<KaonicEvent>> getMessages() {
    if (_messagesContainer.isEmpty()) return {};
    final dataContainer = _messagesContainer.getAll().first;

    final json = (jsonDecode(dataContainer.jsonString) as Map<String, dynamic>);

    final Map<String, List<KaonicEvent>> messages = json.map((k, v) {
      final jsonValues = (v as List).map((value) {
        final isFileMessage = value.containsKey('path');
        final jsonWithType = {
          'data': value,
          'type': isFileMessage ? 'MessageFile' : 'Message'
        };
        return isFileMessage
            ? KaonicEvent<MessageFileEvent>.fromJson(
                jsonWithType,
                (json) =>
                    MessageFileEvent.fromJson(json as Map<String, dynamic>))
            : KaonicEvent<MessageTextEvent>.fromJson(
                jsonWithType,
                (json) {
                  return MessageTextEvent.fromJson(
                      json as Map<String, dynamic>);
                },
              );
      }).toList();
      return MapEntry(k, jsonValues);
    });

    return messages;
  }

  Map<String, String> get getContactChats {
    if (_messagesContainer.isEmpty()) return {};
    final dataContainer = _messagesContainer.getAll().first;

    if (dataContainer.contactChatsJson.isEmpty) return {};

    return dataContainer.contactChats;
  }

  void saveMessages(Map<String, List<KaonicEvent>> messages,
      Map<String, String> contactChats) {
    _messagesContainer.removeAll();
    final mapWithoutClases = messages.map((k, v) {
      final jsonValues = v.map((value) {
        final isFileMessage = value.data is MessageFileEvent;
        return isFileMessage
            ? (value.data as MessageFileEvent).toJson()
            : (value.data as MessageTextEvent).toJson();
      }).toList();
      return MapEntry(k, jsonValues);
    });

    final dataContainer = MessageDataContainer(
      jsonString: jsonEncode(mapWithoutClases),
      contactChatsJson: jsonEncode(contactChats),
    );

    _messagesContainer.put(dataContainer);
  }
}
