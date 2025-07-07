part of 'home_bloc.dart';

@immutable
final class HomeState {
  const HomeState({
    this.user,
    this.unreadMessages = const {},
    this.nodes = const [],
    this.isInChatPage = false,
    this.lastMessages = const {},
  });

  final UserModel? user;
  final List<String> nodes;
  final Map<String, int> unreadMessages;
  final bool isInChatPage;
  final Map<String, KaonicEvent?> lastMessages;

  HomeState copyWith({
    UserModel? user,
    Map<String, int>? unreadMessages,
    List<String>? nodes,
    bool? isInChatPage,
    Map<String, KaonicEvent?>? lastMessages,
  }) =>
      HomeState(
        user: user ?? this.user,
        isInChatPage: isInChatPage ?? this.isInChatPage,
        unreadMessages: unreadMessages ?? this.unreadMessages,
        nodes: nodes ?? this.nodes,
        lastMessages: lastMessages ?? this.lastMessages,
      );
}

final class IncomingCall extends HomeState {
  const IncomingCall({
    required super.nodes,
    required super.unreadMessages,
    required super.user,
    required this.address,
    required this.callId,
    required super.isInChatPage,
    required super.lastMessages,
  });

  final String? callId;
  final String? address;

  static IncomingCall fromParentState(
    HomeState state,
    String? callId,
    String? address,
  ) =>
      IncomingCall(
        nodes: state.nodes,
        unreadMessages: state.unreadMessages,
        user: state.user,
        callId: callId,
        address: address,
        isInChatPage: state.isInChatPage,
        lastMessages: state.lastMessages,
      );
}
