import 'dart:async';

import 'package:kaonic/data/models/kaonic_create_chat_event.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/data/models/kaonic_event_type.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/data/repository/messages_repository.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:rxdart/subjects.dart';

// Function(address, chatId)
typedef OnChatIdChanged = Function(String, String);

class ChatService {
  ChatService._privateConstructor();

  static final ChatService _instance = ChatService._privateConstructor();

  factory ChatService(
    KaonicCommunicationService kaonicService,
    MessagesRepository messageRepository,
  ) {
    _instance._kaonicService = kaonicService;
    _instance._messageRepository = messageRepository;
    _instance._listenMessages();
    _instance.myAddress();

    return _instance;
  }

  late final KaonicCommunicationService _kaonicService;
  late final MessagesRepository _messageRepository;

  /// key is address of chat id
  final _messagesSubject =
      BehaviorSubject<Map<String, List<KaonicEvent>>>.seeded({});

  /// key is contact address,
  /// value is chatUUID
  final _contactChats = <String, String>{};

  String? _activeContactAddress;
  String? _myAddress;

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

  Future<String> myAddress() async {
    _myAddress = await _kaonicService.myAddress();
    return _myAddress ?? '';
  }

  Future<String> createChat(String address) async {
    final chatId = await _kaonicService.createChat(address);

    _activeContactAddress = address;
    // _contactChats[address] = chatId;
    _putOrUpdateChatId(chatId, address, needOnChatUpdated: false);
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
    final isMessagesEmpty = messageList.isEmpty;

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

    final peerAdrees = data.address != _myAddress ? data.address : null;

    _activeContactAddress = peerAdrees ?? _activeContactAddress;
    _saveMessages(messageList, isMessagesEmpty);
  }

  void _putOrUpdateChatId(String chatId, String address,
      {bool needOnChatUpdated = true}) {
    // final containsAddressWithChatID = _contactChats.containsKey(address);
    // _contactChats[address] = chatId;
    // if (containsAddressWithChatID) {
    //   onChatIDUpdated?.call(address, chatId);
    // }

    final prevChatId = _contactChats[address];
    _contactChats[address] = chatId;
    if (prevChatId != null) {
      final currentMap = Map<String, List<KaonicEvent>>.from(
          _messagesSubject.valueOrNull ?? {});

      final messages = currentMap[prevChatId] ?? [];
      currentMap.remove(prevChatId);
      currentMap[chatId] = messages;
      _saveMessages(messages);
      _messagesSubject.add(currentMap);
      if (needOnChatUpdated) {
        onChatIDUpdated?.call(address, chatId);
      }
    } else if (_activeContactAddress != null) {
      final messages = _messageRepository.getMessages();
      if (messages.containsKey(_activeContactAddress)) {
        _messagesSubject.add({chatId: messages[_activeContactAddress]!});
      }
    }
  }

  void _saveMessages(List<KaonicEvent> messages,
      [bool isMessagesEmpty = false]) {
    List<KaonicEvent>? messagesToSave;
    if (isMessagesEmpty) {
      final localMessages = _messageRepository.getMessages();
      if (_activeContactAddress == localMessages.keys.first) {
        messagesToSave = List<KaonicEvent>.from(localMessages.values.first)
          ..addAll(messages);
      }
    }

    if (_activeContactAddress == null) return;

    _messageRepository.saveMessages({
      _activeContactAddress!: messagesToSave ?? messages,
    });
  }
}
