import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/service/call_service.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc({
    required CallService callService,
    required CallScreenState callState,
  })  : _callService = callService,
        super(CallState(
            callState: callState,
            usernameAddressHex: callService.activeCallAddress)) {
    on<_InitCall>(_initCall);
    on<EndCall>(_endCall);
    on<AcceptCall>(_acceptCall);
    on<_UpdateCallState>(_onUpdateCallState);

    add(_InitCall());
  }

  late final StreamSubscription<CallScreenState>? _callStateSubscription;
  late final CallService _callService;

  @override
  close() async {
    _callStateSubscription?.cancel();
    super.close();
  }

  FutureOr<void> _initCall(_InitCall event, Emitter<CallState> emit) {
    _callStateSubscription = _callService.callState.listen((callState) {
      add(_UpdateCallState(callState));
    });
  }

  void _onUpdateCallState(_UpdateCallState event, Emitter<CallState> emit) {
    emit(state.copyWith(callState: event.callSate));
    if (event.callSate == CallScreenState.finished) {
      emit(EndCallState());
    }
  }

  FutureOr<void> _endCall(EndCall event, Emitter<CallState> emit) {
    _callService.rejectCall();
  }

  FutureOr<void> _acceptCall(AcceptCall event, Emitter<CallState> emit) {
    _callService.answerCall();
  }
}
