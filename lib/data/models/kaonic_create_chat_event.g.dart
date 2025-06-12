// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kaonic_create_chat_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatCreateEvent _$ChatCreateEventFromJson(Map<String, dynamic> json) =>
    ChatCreateEvent(
      address: json['address'] as String,
      chatId: json['chat_id'] as String,
      chatName: json['chat_name'] as String? ?? '',
    );

Map<String, dynamic> _$ChatCreateEventToJson(ChatCreateEvent instance) =>
    <String, dynamic>{
      'address': instance.address,
      'chat_id': instance.chatId,
      'chat_name': instance.chatName,
    };
