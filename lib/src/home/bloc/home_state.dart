part of 'home_bloc.dart';

@immutable
final class HomeState {
  const HomeState({
    this.user,
    this.unreadMessages = const {},
    this.nodes = const [],
  });

  final UserModel? user;
  final List<String> nodes;
  final Map<String, int> unreadMessages;

  HomeState copyWith({
    UserModel? user,
    Map<String, int>? unreadMessages,
    List<String>? nodes,
  }) =>
      HomeState(
        user: user ?? this.user,
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
      );
}
