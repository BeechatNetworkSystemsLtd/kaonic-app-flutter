import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/models/kaonic_event.dart';

part 'kaonic_contact_event.g.dart';

@JsonSerializable()
class ContactFoundEvent extends KaonicEventData {
  ContactFoundEvent({
    required super.address,
    required super.timestamp,
  });

  ContactFoundEvent.empty() : super(address: '', timestamp: 0);

  factory ContactFoundEvent.fromJson(Map<String, dynamic> json) =>
      _$ContactFoundEventFromJson(json);

  Map<String, dynamic> toJson() => _$ContactFoundEventToJson(this);
}
