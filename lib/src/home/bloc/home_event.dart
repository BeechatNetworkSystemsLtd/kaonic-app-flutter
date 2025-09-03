part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class _InitEvent extends HomeEvent {}

final class _HandleCallStatus extends HomeEvent {
  _HandleCallStatus({
    required this.callId,
    required this.address,
  });

  final String callId;
  final String address;
}

final class _UpdatedNodes extends HomeEvent {
  _UpdatedNodes({required this.nodes});

  final List<String> nodes;
}

final class _UpdatedUser extends HomeEvent {
  _UpdatedUser({required this.user});

  final UserModel user;
}

final class RemoveContact extends HomeEvent {
  RemoveContact({required this.contact});

  final String contact;
}

final class OnChatNavigate extends HomeEvent {
  OnChatNavigate(this.isInChatPage);

  final bool isInChatPage;
}

final class OnUpdateLastMessages extends HomeEvent {
  final Map<String, KaonicEvent?> lastMessages;

  OnUpdateLastMessages(this.lastMessages);
}
