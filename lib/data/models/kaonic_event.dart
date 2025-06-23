import 'package:json_annotation/json_annotation.dart';
part 'kaonic_event.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class KaonicEvent<T extends KaonicEventData> {
  final String type;
  final T? data;

  KaonicEvent({required this.type, this.data});

  factory KaonicEvent.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$KaonicEventFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$KaonicEventToJson(this, toJsonT);
}

abstract class KaonicEventData {
  final String address;
  final int timestamp;

  KaonicEventData({required this.address, required this.timestamp});
}
