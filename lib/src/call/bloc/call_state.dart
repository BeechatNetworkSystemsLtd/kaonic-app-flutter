part of 'call_bloc.dart';

@immutable
final class CallState {
  const CallState({
    this.usernameAddressHex,
    this.callState,
  });

  final String? usernameAddressHex;
  final CallScreenState? callState;

  CallState copyWith({
    String? usernameAddressHex,
    CallScreenState? callState,
  }) =>
      CallState(
        callState: callState ?? this.callState,
        usernameAddressHex: usernameAddressHex ?? this.usernameAddressHex,
      );
}

final class EndCallState extends CallState {}
