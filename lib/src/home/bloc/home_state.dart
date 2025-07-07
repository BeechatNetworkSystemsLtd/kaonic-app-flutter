part of 'home_bloc.dart';

@immutable
final class HomeState {
  const HomeState({
    this.user,
    this.unreadMessages = const {},
    this.nodes = const [],
    this.isInChatPage = false,
  });

  final UserModel? user;
  final List<String> nodes;
  final Map<String, int> unreadMessages;
  final bool isInChatPage;

  HomeState copyWith({
    UserModel? user,
    Map<String, int>? unreadMessages,
    List<String>? nodes,
    bool? isInChatPage,
  }) =>
      HomeState(
        user: user ?? this.user,
        isInChatPage: isInChatPage ?? this.isInChatPage,
        unreadMessages: unreadMessages ?? this.unreadMessages,
        nodes: nodes ?? this.nodes,
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
      );
}
