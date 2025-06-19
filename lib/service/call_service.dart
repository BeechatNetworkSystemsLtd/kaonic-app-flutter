import 'dart:async';

import 'package:kaonic/data/models/call_event_data.dart';
import 'package:kaonic/data/models/kaonic_event_type.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';

enum CallScreenState {
  idle,
  incoming,
  outgoing,
  callInProgress,
  finished;

  String getTitle([String? user]) => switch (this) {
        incoming => '$user CALLING',
        outgoing => 'CALLING...',
        callInProgress => 'IN CALL WITH $user',
        finished => 'CALL ENDED',
        _ => ''
      };
}

class CallService {
  CallService(KaonicCommunicationService kaonicService) {
    _kaonicService = kaonicService;
    _listenCallEvents();
  }

  late final KaonicCommunicationService _kaonicService;

  final _navigationEventsController = BehaviorSubject<String>();
  Stream<String> get navigationEvents => _navigationEventsController.stream;

  final _callStateController = StreamController<CallScreenState>.broadcast();
  Stream<CallScreenState> get callState => _callStateController.stream;

  String? _activeCallId;
  String? get activeCallId => _activeCallId;

  String? _activeCallAddress;
  String? get activeCallAddress => _activeCallAddress;

  void dispose() {
    _navigationEventsController.close();
    _callStateController.close();
  }

  void _listenCallEvents() {
    _kaonicService.eventsStream
        .where((event) => KaonicEventType.callEvents.contains(event.type))
        .listen((event) {
      final callEventData = event.data as CallEventData;
      switch (event.type) {
        case KaonicEventType.CALL_INVOKE:
          _handleCallInvoke(callEventData.callId, callEventData.address);
        case KaonicEventType.CALL_ANSWER:
          _handleCallAnswer(callEventData.callId, callEventData.address);
        case KaonicEventType.CALL_REJECT:
        case KaonicEventType.CALL_TIMEOUT:
          _handleCallReject(callEventData.callId, callEventData.address);
      }
    });
  }

  void createCall(String address) {
    if (_activeCallId != null) return;

    _activeCallId = const Uuid().v4();
    _activeCallAddress = address;

    _kaonicService.startCall(_activeCallId!, _activeCallAddress!);
    _callStateController.add(CallScreenState.outgoing);
  }

  void answerCall() {
    if (_activeCallId == null || _activeCallAddress == null) return;

    _kaonicService.answerCall(_activeCallId!, _activeCallAddress!);
    _callStateController.add(CallScreenState.callInProgress);
  }

  void rejectCall() {
    if (_activeCallId == null || _activeCallAddress == null) return;

    _kaonicService.rejectCall(_activeCallId!, _activeCallAddress!);
    _callStateController.add(CallScreenState.finished);

    Future.delayed(const Duration(milliseconds: 150), () {
      _callStateController.add(CallScreenState.idle);
    });

    _activeCallId = null;
    _activeCallAddress = null;
  }

  void _handleCallInvoke(String callId, String address) {
    _activeCallId = callId;
    _activeCallAddress = address;

    _callStateController.add(CallScreenState.incoming);

    _navigationEventsController.add("incomingCall/$callId/$address");
  }

  void _handleCallReject(String callId, String address) {
    if (callId != _activeCallId) return;

    _callStateController.add(CallScreenState.finished);

    // Delay before resetting to idle state
    Future.delayed(const Duration(milliseconds: 150), () {
      _callStateController.add(CallScreenState.idle);
    });

    _activeCallId = null;
    _activeCallAddress = null;
  }

  void _handleCallAnswer(String callId, String address) {
    if (callId != _activeCallId) return;

    _callStateController.add(CallScreenState.callInProgress);
  }
}
