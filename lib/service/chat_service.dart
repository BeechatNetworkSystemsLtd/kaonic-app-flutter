import 'dart:async';

import 'package:kaonic/data/models/kaonic_create_chat_event.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/data/models/kaonic_event_type.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/data/repository/messages_repository.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:rxdart/rxdart.dart';

// Function(address, chatId)
typedef OnChatIdChanged = Function(String, String);

class ChatService {
  ChatService._privateConstructor();

  static final ChatService _instance = ChatService._privateConstructor();
  bool _isInitialized = false;

  factory ChatService(
    KaonicCommunicationService kaonicService,
    MessagesRepository messageRepository,
  ) {
    if (_instance._isInitialized) return _instance;

    _instance._kaonicService = kaonicService;
    _instance._messageRepository = messageRepository;
    _instance._listenMessages();
    _instance.myAddress();
    if (_instance._contactChats.isEmpty) {
      _instance._contactChats = messageRepository.getContactChats;
    }
    if ((_instance._messagesSubject.valueOrNull ?? {}).isEmpty) {
      final messages = messageRepository.getMessages();
      _instance._messagesSubject.add(messages);
    }
    _instance._isInitialized = true;

    return _instance;
  }

  late final KaonicCommunicationService _kaonicService;
  late final MessagesRepository _messageRepository;

  /// key is address of chat id
  final _messagesSubject =
      BehaviorSubject<Map<String, List<KaonicEvent>>>.seeded({});

  late Stream<Map<String, KaonicEvent?>> lastMessagesStream =
      _messagesSubject.switchMap((map) {
    final lastMessages = _contactChats.map((k, v) {
      final messages = (map[v] ?? []).lastOrNull;
      return MapEntry(k, messages);
    });
    // _messageRepository.saveLastMessages(lastMessages);
    return Stream.value(lastMessages);
  });

  /// key is contact address,
  /// value is chatUUID
  var _contactChats = <String, String>{};

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
    return await _kaonicService.myAddress();
  }

  Future<String> createChat(String address) async {
    final chatId = await _kaonicService.createChat(address);

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

    _saveMessages();
  }

  void _putOrUpdateChatId(String chatId, String address,
      {bool needOnChatUpdated = true}) {
    // final containsAddressWithChatID = _contactChats.containsKey(address);
    // _contactChats[address] = chatId;
    // if (containsAddressWithChatID) {
    //   onChatIDUpdated?.call(address, chatId);
    // }

    var currentMap =
        Map<String, List<KaonicEvent>>.from(_messagesSubject.valueOrNull ?? {});

    if (_contactChats.isEmpty) {
      _contactChats = _messageRepository.getContactChats;
    }

    if (currentMap.isEmpty) {
      _messagesSubject.add(_messageRepository.getMessages());
    }

    currentMap =
        Map<String, List<KaonicEvent>>.from(_messagesSubject.valueOrNull ?? {});

    final prevChatId = _contactChats[address];
    _contactChats[address] = chatId;

    if (prevChatId != null) {
      final messages = currentMap[prevChatId] ?? [];
      currentMap.remove(prevChatId);
      currentMap[chatId] = messages;
      _messagesSubject.add(currentMap);
      _saveMessages();
      if (needOnChatUpdated) {
        onChatIDUpdated?.call(address, chatId);
      }
    }
  }

  void _saveMessages() {
    final currentMap =
        Map<String, List<KaonicEvent>>.from(_messagesSubject.valueOrNull ?? {});
    _messageRepository.saveMessages(currentMap, _contactChats);
  }
}
