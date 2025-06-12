import 'dart:async';

import 'package:kaonic/data/models/kaonic_create_chat_event.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/data/models/kaonic_event_type.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:rxdart/subjects.dart';

// Function(address, chatId)
typedef OnChatIdChanged = Function(String, String);

class ChatService {
  ChatService(KaonicCommunicationService kaonicService) {
    _kaonicService = kaonicService;
    _listenMessages();
  }

  late final KaonicCommunicationService _kaonicService;

  /// key is address of chat id
  final _messagesSubject =
      BehaviorSubject<Map<String, List<KaonicEvent>>>.seeded({});

  /// key is contact address,
  /// value is chatUUID
  final _contactChats = <String, String>{};

  OnChatIdChanged? onChatIDUpdated;

  void _listenMessages() {
    _kaonicService.eventsStream
        .where((event) => KaonicEventType.messageEvents.contains(event.type))
        .listen((event) {
      switch (event.type) {
        case KaonicEventType.CHAT_CREATE:
          _putOrUpdateChatId(
            (event.data as ChatCreateEvent).chatId,
            (event.data as ChatCreateEvent).address,
          );
        case KaonicEventType.MESSAGE_TEXT:
        case KaonicEventType.MESSAGE_FILE:
          _handleTextMessage(event);
      }
    });
  }

  Stream<List<KaonicEvent>> getChatMessages(String chatId) {
    return _messagesSubject.stream.map((messagesMap) {
      return messagesMap[chatId] ?? [];
    });
  }

  Future<String> createChat(String address) async {
    final chatId = await _kaonicService.createChat(address);

    _contactChats[address] = chatId;
    return chatId;
  }

  void sendTextMessage(String message, String address) async {
    _kaonicService.sendTextMessage(
        address, message, _contactChats[address] ?? "");
  }

  void sendFileMessage(String filePath, String address) async {
    final chatId = _contactChats[address];
    if (chatId == null) throw Exception('chatId == null');

    _kaonicService.sendFileMessage(address, filePath, chatId);
  }

  void _handleTextMessage(KaonicEvent message) {
    final data = message.data as MessageEvent;
    final currentMap =
        Map<String, List<KaonicEvent>>.from(_messagesSubject.valueOrNull ?? {});
    final messageList = List<KaonicEvent>.from(currentMap[data.chatId] ?? []);

    final existingMessages = messageList
        .where((msg) =>
            msg.data is MessageEvent &&
            (msg.data as MessageEvent).id == data.id)
        .toList();

    if (existingMessages.isNotEmpty) {
      final index = messageList.indexOf(existingMessages.first);
      if (index != -1) {
        messageList[index] = message;
      }
    } else {
      messageList.add(message);
    }

    currentMap[data.chatId] = messageList;

    _messagesSubject.add(currentMap);
  }

  void _putOrUpdateChatId(String chatId, String address) {
    final containsAddressWithChatID = _contactChats.containsKey(address);
    _contactChats[address] = chatId;
    if (containsAddressWithChatID) {
      onChatIDUpdated?.call(address, chatId);
    }
  }
}
