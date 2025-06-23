// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kaonic_contact_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactFoundEvent _$ContactFoundEventFromJson(Map<String, dynamic> json) =>
    ContactFoundEvent(
      address: json['address'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$ContactFoundEventToJson(ContactFoundEvent instance) =>
    <String, dynamic>{
      'address': instance.address,
      'timestamp': instance.timestamp,
    };
