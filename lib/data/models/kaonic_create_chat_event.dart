import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/models/kaonic_event.dart';

part 'kaonic_create_chat_event.g.dart';

@JsonSerializable()
class ChatCreateEvent extends KaonicEventData {
  @JsonKey(name: 'chat_id')
  final String chatId;

  @JsonKey(name: 'chat_name')
  final String chatName;

  ChatCreateEvent({
    required super.address,
    required this.chatId,
    this.chatName = '',
  }) : super(timestamp: DateTime.now().millisecondsSinceEpoch);

  factory ChatCreateEvent.empty() {
    return ChatCreateEvent(
      address: '',
      chatId: '',
      chatName: '',
    );
  }

  factory ChatCreateEvent.fromJson(Map<String, dynamic> json) =>
      _$ChatCreateEventFromJson(json);

  Map<String, dynamic> toJson() => _$ChatCreateEventToJson(this);
}
