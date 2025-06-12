part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class _IntiChat extends ChatEvent {}

final class _UpdatedChats extends ChatEvent {
  _UpdatedChats({required this.messages});

  final List<KaonicEvent<KaonicEventData>> messages;
}

final class SendMessage extends ChatEvent {
  SendMessage({required this.message});

  final String message;
}

final class InitiateCall extends ChatEvent {}

final class FilePicked extends ChatEvent {
  FilePicked({required this.file});
  final FilePickerResult file;
}
