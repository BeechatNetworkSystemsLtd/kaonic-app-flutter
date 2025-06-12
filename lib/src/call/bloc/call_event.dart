part of 'call_bloc.dart';

@immutable
sealed class CallEvent {}

final class _InitCall extends CallEvent {}

final class EndCall extends CallEvent {}

final class AcceptCall extends CallEvent {}

final class _UpdateCallState extends CallEvent {
  final CallScreenState callSate;

  _UpdateCallState(this.callSate);
}
