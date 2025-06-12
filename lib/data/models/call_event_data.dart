import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:uuid/uuid.dart';

part 'call_event_data.g.dart';

@JsonSerializable()
class CallEventData extends KaonicEventData {
  @JsonKey(name: 'call_id')
  final String callId;
  final String id;

  CallEventData({
    required super.address,
    required super.timestamp,
    required this.callId,
  }) : id = const Uuid().v4();

  CallEventData.withCurrentTimestamp({
    required super.address,
    required this.callId,
  })  : id = const Uuid().v4(),
        super(timestamp: DateTime.now().millisecondsSinceEpoch);

  CallEventData.empty()
      : callId = '',
        id = const Uuid().v4(),
        super(address: '', timestamp: 0);

  factory CallEventData.fromJson(Map<String, dynamic> json) =>
      _$CallEventDataFromJson(json);

  Map<String, dynamic> toJson() => _$CallEventDataToJson(this);
}
