import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:uuid/uuid.dart';

part 'kaonic_message_event.g.dart';

abstract class MessageEvent extends KaonicEventData {
  final String id;
  @JsonKey(name: 'chat_id')
  final String chatId;
  bool isRead;
  final DateTime? date;

  MessageEvent({
    required super.address,
    required super.timestamp,
    required this.id,
    required this.chatId,
    this.isRead = false,
    this.date,
  });

  MessageEvent.empty()
      : id = '',
        chatId = '',
        isRead = false,
        date = null,
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
    super.isRead,
    DateTime? date,
    this.text,
  }) : super(date: date ?? DateTime.now());

  MessageTextEvent.withUuid({
    required String address,
    required int timestamp,
    required String chatId,
    String? text,
    DateTime? date,
  }) : this(
          address: address,
          timestamp: timestamp,
          id: const Uuid().v4(),
          chatId: chatId,
          text: text,
          date: date ?? DateTime.now(),
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
    super.isRead,
    this.fileSizeProcessed = 0,
    this.path,
    DateTime? date,
  }) : super(date: date ?? DateTime.now());

  MessageFileEvent.empty(DateTime? date)
      : fileName = '',
        fileSize = 0,
        fileSizeProcessed = 0,
        path = null,
        super(
          address: '',
          timestamp: 0,
          id: '',
          chatId: '',
          date: date ?? DateTime.now(),
        );

  factory MessageFileEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageFileEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageFileEventToJson(this);
}
