import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/service/call_service.dart';

part 'call_event.dart';
part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc({
    required CallService callService,
    required CallScreenStateInfo callState,
  })  : _callService = callService,
        super(CallState(
            callState: callState,
            usernameAddressHex: callService.activeCallAddress?.toUpperCase())) {
    on<_InitCall>(_initCall);
    on<EndCall>(_endCall);
    on<AcceptCall>(_acceptCall);
    on<_UpdateCallState>(_onUpdateCallState);

    _startTimer(callState);

    add(_InitCall());
  }

  late final StreamSubscription<CallScreenStateInfo>? _callStateSubscription;
  late final CallService _callService;
  Timer? _outgoingCallTimer;

  @override
  close() async {
    _outgoingCallTimer?.cancel();
    _callStateSubscription?.cancel();
    super.close();
  }

  void _startTimer(CallScreenStateInfo callState) {
    if (callState.callScreenState != CallScreenState.outgoing) return;

    int seconds = 0;
    _outgoingCallTimer?.cancel();
    _outgoingCallTimer = Timer.periodic(Duration(seconds: 1), (t) {
      if (state.callState?.callScreenState != CallScreenState.outgoing) {
        t.cancel();
      }

      if (seconds == 30) {
        add(EndCall());
        t.cancel();
      } else {
        seconds += 1;
      }
    });
  }

  FutureOr<void> _initCall(_InitCall event, Emitter<CallState> emit) {
    _callStateSubscription = _callService.callState.listen((callState) {
      add(_UpdateCallState(callState));
    });
  }

  void _onUpdateCallState(_UpdateCallState event, Emitter<CallState> emit) {
    emit(state.copyWith(callState: event.callSate));
    if (event.callSate.callScreenState == CallScreenState.finished) {
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
