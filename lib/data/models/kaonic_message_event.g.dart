// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kaonic_message_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageTextEvent _$MessageTextEventFromJson(Map<String, dynamic> json) =>
    MessageTextEvent(
      address: json['address'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      isRead: json['isRead'] as bool? ?? false,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      text: json['text'] as String?,
    );

Map<String, dynamic> _$MessageTextEventToJson(MessageTextEvent instance) =>
    <String, dynamic>{
      'address': instance.address,
      'timestamp': instance.timestamp,
      'id': instance.id,
      'chat_id': instance.chatId,
      'isRead': instance.isRead,
      'date': instance.date?.toIso8601String(),
      'text': instance.text,
    };

MessageFileEvent _$MessageFileEventFromJson(Map<String, dynamic> json) =>
    MessageFileEvent(
      timestamp: (json['timestamp'] as num).toInt(),
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      fileName: json['fileName'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      address: json['address'] as String? ?? "",
      isRead: json['isRead'] as bool? ?? false,
      fileSizeProcessed: (json['fileSizeProcessed'] as num?)?.toInt() ?? 0,
      path: json['path'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$MessageFileEventToJson(MessageFileEvent instance) =>
    <String, dynamic>{
      'address': instance.address,
      'timestamp': instance.timestamp,
      'id': instance.id,
      'chat_id': instance.chatId,
      'isRead': instance.isRead,
      'date': instance.date?.toIso8601String(),
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'fileSizeProcessed': instance.fileSizeProcessed,
      'path': instance.path,
    };
