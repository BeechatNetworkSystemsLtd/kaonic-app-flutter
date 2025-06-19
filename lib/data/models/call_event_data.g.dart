// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_event_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallEventData _$CallEventDataFromJson(Map<String, dynamic> json) =>
    CallEventData(
      address: json['address'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      callId: json['call_id'] as String,
    );

Map<String, dynamic> _$CallEventDataToJson(CallEventData instance) =>
    <String, dynamic>{
      'address': instance.address,
      'timestamp': instance.timestamp,
      'call_id': instance.callId,
    };
