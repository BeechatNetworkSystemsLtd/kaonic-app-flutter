part of 'chat_bloc.dart';

@immutable
final class ChatState {
  const ChatState({
    required this.address,
    this.messages = const [],
    this.flagScrollToDown = false,
    this.myAddress = '',
    required this.callState,
    this.isCallEndedOnPop = false,
  });

  final List<KaonicEvent<KaonicEventData>> messages;
  final String address;
  final String myAddress;
  final bool flagScrollToDown;
  final CallScreenStateInfo callState;
  final bool isCallEndedOnPop;

  ChatState copyWith({
    List<KaonicEvent<KaonicEventData>>? messages,
    bool flagScrollToDown = false,
    String? myAddress,
    CallScreenStateInfo? callState,
    bool? isCallEndedOnPop,
  }) =>
      ChatState(
        address: address,
        callState: callState ?? this.callState,
        flagScrollToDown: flagScrollToDown,
        messages: messages ?? this.messages,
        myAddress: myAddress ?? this.myAddress,
        isCallEndedOnPop: isCallEndedOnPop ?? this.isCallEndedOnPop,
      );
}

final class NavigateToCall extends ChatState {
  const NavigateToCall({
    required super.address,
    required super.messages,
    required super.myAddress,
    required super.flagScrollToDown,
    required super.callState,
  });
}
