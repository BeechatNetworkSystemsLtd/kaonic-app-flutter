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
