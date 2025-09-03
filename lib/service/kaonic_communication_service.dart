import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kaonic/data/enums/phy_config_type_enum.dart';
import 'package:kaonic/data/models/call_event_data.dart';
import 'package:kaonic/data/models/connectivity_settings.dart';
import 'package:kaonic/data/models/kaonic_create_chat_event.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/data/models/kaonic_event_type.dart';
import 'package:kaonic/data/models/kaonic_message_event.dart';
import 'package:kaonic/data/models/preset_models/radio_preset_model.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';

enum KaonicCommunicationType {
  tcp,
  kaonicClient,
}

class KaonicCommunicationService {
  static const defaultFrequency = "869535";
  static const defaultChannelSpacing = "200";
  static const defaultTxPower = "10";
  final kaonicMethodChannel =
      MethodChannel('network.beechat.app.kaonic/kaonic');
  final kaonicEventChannel =
      EventChannel('network.beechat.app.kaonic.service/kaonicEvents');

  final _nodesSubject = BehaviorSubject<List<String>>();
  Stream<List<String>> get nodes => _nodesSubject.stream;

  final _eventsController = StreamController<KaonicEvent>.broadcast();
  Stream<KaonicEvent> get eventsStream =>
      _eventsController.stream.asBroadcastStream();

  KaonicCommunicationService() {
    kaonicEventChannel.receiveBroadcastStream().listen(_listenKaonicEvents);
  }

  void startService(ConnectivitySettings connectivitySettings) {
    kaonicMethodChannel.invokeMethod('startService', {
      'connectivity': connectivitySettings.toJson(),
    });
  }

  Future<String> createChat(String address) async {
    final chatId = const Uuid().v4();
    await kaonicMethodChannel.invokeMethod('createChat', {
      "address": address,
      "chatId": chatId,
    });

    return chatId;
  }

  void sendTextMessage(String address, String message, String chatId) {
    kaonicMethodChannel.invokeMethod('sendTextMessage', {
      "address": address,
      "message": message,
      "chatId": chatId,
    });
  }

  void sendFileMessage(String address, String filePath, String chatId) {
    kaonicMethodChannel.invokeMethod('sendFileMessage', {
      "address": address,
      "filePath": filePath,
      "chatId": chatId,
    });
  }

  void sendConfig({
    required RadioSettings radioSettings,
    required PhyConfigTypeEnum configType,
  }) {
    kaonicMethodChannel.invokeMethod(
      'sendConfig',
      radioSettings.toJsonStringConfig(configType),
    );
  }

  Future<List<RadioPresetModel>> getPresets() async {
    final result = await kaonicMethodChannel.invokeMethod('getPresets');
    final json = jsonDecode(result);

    return (json as List)
        .map((preset) => RadioPresetModel.fromJson(preset))
        .toList();
  }

  void startCall(String callId, String address) {
    kaonicMethodChannel.invokeMethod('startCall', {
      "address": address,
      "callId": callId,
    });
  }

  void answerCall(String callId, String address) {
    kaonicMethodChannel.invokeMethod('answerCall', {
      "address": address,
      "callId": callId,
    });
  }

  void rejectCall(String callId, String address) {
    kaonicMethodChannel.invokeMethod('rejectCall', {
      "address": address,
      "callId": callId,
    });
  }

  Future<String> myAddress() async {
    return await kaonicMethodChannel.invokeMethod('myAddress');
  }

  void _listenKaonicEvents(dynamic event) {
    try {
      final eventJson = jsonDecode(event) as Map<String, dynamic>;
      if (!eventJson.containsKey('type')) return;

      final eventType = eventJson['type']?.toString() ?? '';

      print('eventType $eventType');

      KaonicEvent? kaonicEvent;
      switch (eventType) {
        case KaonicEventType.CONTACT_FOUND:
          final address = eventJson.containsKey('data')
              ? (eventJson['data'] as Map<String, dynamic>)['address']
                      ?.toString() ??
                  ''
              : '';
          if (address.isNotEmpty &&
              (!_nodesSubject.hasValue ||
                  !_nodesSubject.value.contains(address))) {
            if (_nodesSubject.hasValue) {
              _nodesSubject.add([..._nodesSubject.value, address]);
            } else {
              _nodesSubject.add([address]);
            }
          }
          return;
        case KaonicEventType.MESSAGE_TEXT:
          kaonicEvent = KaonicEvent<MessageTextEvent>.fromJson(
              eventJson,
              (json) =>
                  MessageTextEvent.fromJson(json as Map<String, dynamic>));
        case KaonicEventType.MESSAGE_FILE:
          kaonicEvent = KaonicEvent<MessageFileEvent>.fromJson(
              eventJson,
              (json) =>
                  MessageFileEvent.fromJson(json as Map<String, dynamic>));
        case KaonicEventType.CHAT_CREATE:
          kaonicEvent = KaonicEvent<ChatCreateEvent>.fromJson(eventJson,
              (json) => ChatCreateEvent.fromJson(json as Map<String, dynamic>));
        case KaonicEventType.CALL_INVOKE:
        case KaonicEventType.CALL_ANSWER:
        case KaonicEventType.CALL_REJECT:
        case KaonicEventType.CALL_TIMEOUT:
          kaonicEvent = KaonicEvent<CallEventData>.fromJson(eventJson,
              (json) => CallEventData.fromJson(json as Map<String, dynamic>));
      }

      if (kaonicEvent != null) {
        _eventsController.add(kaonicEvent);
      }
    } catch (e) {
      print(e.toString());

      return;
    }
  }
}
