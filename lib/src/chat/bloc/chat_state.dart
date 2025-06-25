part of 'chat_bloc.dart';

@immutable
final class ChatState {
  const ChatState({
    required this.address,
    this.messages = const [],
    this.flagScrollToDown = false,
    this.myAddress = '',
  });

  final List<KaonicEvent<KaonicEventData>> messages;
  final String address;
  final String myAddress;
  final bool flagScrollToDown;

  ChatState copyWith({
    List<KaonicEvent<KaonicEventData>>? messages,
    bool flagScrollToDown = false,
    String? myAddress,
  }) =>
      ChatState(
        address: address,
        flagScrollToDown: flagScrollToDown,
        messages: messages ?? this.messages,
        myAddress: myAddress ?? this.myAddress,
      );
}

final class NavigateToCall extends ChatState {
  const NavigateToCall({
    required super.address,
    required super.messages,
    required super.myAddress,
    required super.flagScrollToDown,
  });
}
