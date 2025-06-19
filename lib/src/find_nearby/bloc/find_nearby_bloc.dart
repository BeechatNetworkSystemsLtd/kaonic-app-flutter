import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/models/contact_model.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/service/user_service.dart';
import 'package:meta/meta.dart';

part 'find_nearby_event.dart';
part 'find_nearby_state.dart';

class FindNearbyBloc extends Bloc<FindNearbyEvent, FindNearbyState> {
  FindNearbyBloc({
    required KaonicCommunicationService communicationService,
    required UserService userService,
  })  : _communicationService = communicationService,
        _userService = userService,
        super(const FindNearbyState()) {
    on<_DeviceListUpdated>(_initialLoading);
    on<AddContact>(_addContact);

    nodesSubscription = _communicationService.nodes.listen(
      (nodes) {
        add(_DeviceListUpdated(devices: nodes));
      },
    );
  }

  final KaonicCommunicationService _communicationService;
  final UserService _userService;
  StreamSubscription<dynamic>? nodesSubscription;

  @override
  Future<void> close() async {
    nodesSubscription?.cancel();
    super.close();
  }

  FutureOr<void> _initialLoading(
      _DeviceListUpdated event, Emitter<FindNearbyState> emit) async {
    emit(state.copyWith(
        devices: event.devices, contacts: _userService.user?.contacts ?? []));
  }

  FutureOr<void> _addContact(AddContact event, Emitter<FindNearbyState> emit) {
    final ContactModel contact = ContactModel(address: event.contact);
    _userService.user?.contacts.add(contact);
    _userService.updateCurrentUser();
    emit(SuccessfullyAddedContact(contact: contact));
  }
}
