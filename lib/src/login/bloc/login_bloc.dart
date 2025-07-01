import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/repository/connectivity_settings_repository.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/service/user_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final KaonicCommunicationService _kaonicCommunicationService;
  final ConnectivitySettingsRepository _connectivitySettingRepository;

  LoginBloc(
      this._kaonicCommunicationService, this._connectivitySettingRepository,
      {required UserService userService})
      : _userService = userService,
        super(LoginInitial(btnEnabled: false)) {
    on<LoginInputsChanged>(_handleLoginInputsChanged);
    on<LoginUser>(_handleUserLogin);
  }

  final UserService _userService;

  FutureOr<void> _handleLoginInputsChanged(
      LoginInputsChanged event, Emitter<LoginState> emit) {
    emit(LoginInitial(btnEnabled: event.username.length > 2));
  }

  FutureOr<void> _handleUserLogin(LoginUser event, Emitter<LoginState> emit) {
    final responseUser = _userService.loginUser(event.username, event.passcode);

    if (responseUser == null) {
      emit(LoginFailure());
    } else {
      _kaonicCommunicationService.startService(
        _connectivitySettingRepository.getConnectivitySetting(),
      );
      emit(LoginSuccess());
    }
  }
}
