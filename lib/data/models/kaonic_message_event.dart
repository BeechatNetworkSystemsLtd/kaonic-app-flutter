import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:uuid/uuid.dart';

part 'kaonic_message_event.g.dart';

abstract class MessageEvent extends KaonicEventData {
  final String id;
  @JsonKey(name: 'chat_id')
  final String chatId;

  MessageEvent({
    required super.address,
    required super.timestamp,
    required this.id,
    required this.chatId,
  });

  MessageEvent.empty()
      : id = '',
        chatId = '',
        super(address: '', timestamp: 0);
}

@JsonSerializable()
class MessageTextEvent extends MessageEvent {
  final String? text;

  MessageTextEvent({
    required super.address,
    required super.timestamp,
    required super.id,
    required super.chatId,
    this.text,
  });

  MessageTextEvent.withUuid({
    required String address,
    required int timestamp,
    required String chatId,
    String? text,
  }) : this(
          address: address,
          timestamp: timestamp,
          id: const Uuid().v4(),
          chatId: chatId,
          text: text,
        );

  factory MessageTextEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageTextEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageTextEventToJson(this);
}

@JsonSerializable()
class MessageFileEvent extends MessageEvent {
  final String fileName;
  final int fileSize;
  int fileSizeProcessed = 0;
  String? path;

  MessageFileEvent({
    required super.timestamp,
    required super.id,
    required super.chatId,
    required this.fileName,
    required this.fileSize,
    super.address = "",
    this.fileSizeProcessed = 0,
    this.path,
  });

  MessageFileEvent.empty()
      : fileName = '',
        fileSize = 0,
        fileSizeProcessed = 0,
        path = null,
        super(address: '', timestamp: 0, id: '', chatId: '');

  factory MessageFileEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageFileEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageFileEventToJson(this);
}
