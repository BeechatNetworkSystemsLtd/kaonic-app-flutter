// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kaonic_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KaonicEvent<T> _$KaonicEventFromJson<T extends KaonicEventData>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    KaonicEvent<T>(
      type: json['type'] as String,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$KaonicEventToJson<T extends KaonicEventData>(
  KaonicEvent<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'type': instance.type,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
