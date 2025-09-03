part of 'call_bloc.dart';

@immutable
final class CallState {
  const CallState({
    this.usernameAddressHex,
    this.callState,
  });

  final String? usernameAddressHex;
  final CallScreenStateInfo? callState;

  CallState copyWith({
    String? usernameAddressHex,
    CallScreenStateInfo? callState,
  }) =>
      CallState(
        callState: callState ?? this.callState,
        usernameAddressHex: usernameAddressHex ?? this.usernameAddressHex,
      );
}

final class EndCallState extends CallState {}
