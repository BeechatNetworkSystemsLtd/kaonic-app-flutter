import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/models/user_model.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/service/user_service.dart';
import 'package:meta/meta.dart';
import 'package:objectbox/objectbox.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required CallService callService,
    required UserService userService,
    required KaonicCommunicationService kaonicCommunicationService,
  })  : _userService = userService,
        _callService = callService,
        _kaonicCommunicationService = kaonicCommunicationService,
        super(HomeState(user: userService.user)) {
    on<_InitEvent>(_initEvent);
    on<_UpdatedUser>(_updatedUser);
    on<_UpdatedNodes>(_updatedNodes);
    on<_HandleCallStatus>(_handleCallStatus);

    add(_InitEvent());

    if (userService.user != null) {
      _nodesSubscription = _kaonicCommunicationService.nodes.listen(
        (event) => add(_UpdatedNodes(nodes: event)),
      );
    }
  }

  final UserService _userService;
  final CallService _callService;
  final KaonicCommunicationService _kaonicCommunicationService;
  late final StreamSubscription<Query<UserModel>>? _userSubscription;
  late final StreamSubscription<dynamic>? _nodesSubscription;
  late final StreamSubscription<String>? _callNavigationEventsSubscription;

  @override
  close() async {
    _userSubscription?.cancel();
    _nodesSubscription?.cancel();
    _callNavigationEventsSubscription?.cancel();
    super.close();
  }

  FutureOr<void> _initEvent(_InitEvent event, Emitter<HomeState> emit) {
    _userSubscription = _userService.watchCurrentUser()?.listen((user) {
      final newUser = user.findFirst();
      if (newUser == null) return;
      add(_UpdatedUser(user: newUser));
    });

    _callNavigationEventsSubscription =
        _callService.navigationEvents.listen((navEvent) {
      final navigationInfo = navEvent.split('/');
      add(_HandleCallStatus(
        callId: navigationInfo[1],
        address: navigationInfo.last,
      ));
    });
  }

  FutureOr<void> _updatedUser(_UpdatedUser event, Emitter<HomeState> emit) {
    emit(state.copyWith(user: event.user));
  }

  FutureOr<void> _updatedNodes(_UpdatedNodes event, Emitter<HomeState> emit) {
    emit(state.copyWith(nodes: event.nodes));
  }

  FutureOr<void> _handleCallStatus(
      _HandleCallStatus event, Emitter<HomeState> emit) {
    emit(IncomingCall.fromParentState(state, event.callId, event.address));
  }
}
