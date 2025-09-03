import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/models/connectivity_settings.dart';
import 'package:kaonic/data/repository/connectivity_settings_repository.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';
import 'package:kaonic/utils/validation_util.dart';

part 'connectivity_settings_event.dart';
part 'connectivity_settings_state.dart';

class ConnectivitySettingsBloc
    extends Bloc<ConnectivitySettingsEvent, ConnectivitySettingsState> {
  final KaonicCommunicationService _kaonicCommunicationService;

  ConnectivitySettingsBloc(
    this._kaonicCommunicationService,
    ConnectivitySettingsRepository connectivitySettingRepository,
  )   : _connectivitySettingRepository = connectivitySettingRepository,
        super(ConnectivitySettingsState(
          connectivitySettings:
              connectivitySettingRepository.getConnectivitySetting(),
        )) {
    on<SaveChanges>(_onSaveChanges);
    on<ChangeSettings>(_onChangeSettings);
  }

  late final ConnectivitySettingsRepository _connectivitySettingRepository;

  void _onSaveChanges(_, Emitter<ConnectivitySettingsState> emit) {
    _connectivitySettingRepository.saveSettings(state.connectivitySettings);
    _kaonicCommunicationService.startService(state.connectivitySettings);
    emit(state.copyWith(isChangesSaved: true));
  }

  void _onChangeSettings(
      ChangeSettings event, Emitter<ConnectivitySettingsState> emit) {
    emit(state.copyWith(
      connectivitySettings: event.settings,
      ipAddressValidationErrorText:
          ValidationUtil.validateIpAddress(event.settings.ip),
    ));
  }
}
