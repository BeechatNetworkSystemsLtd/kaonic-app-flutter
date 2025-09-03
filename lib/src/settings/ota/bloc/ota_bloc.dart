import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kaonic/service/ota_service.dart';
import 'package:meta/meta.dart';

part 'ota_event.dart';
part 'ota_state.dart';

enum OtaProcessingState {
  idle,
  processing,
  cannotFetch,
  success,
  failure,
}

class OtaBloc extends Bloc<OtaEvent, OtaState> {
  OtaBloc({required OtaService otaService})
      : _otaService = otaService,
        super(OtaState(
          tagNameLocal: otaService.localTagName,
          tagNameRemote: otaService.remoteTagName,
          kaonicFwVersion: otaService.kaonicFwVersion,
        )) {
    on<DownloadFirmware>(_handleDownloadFirmware);
    on<CheckKaonicFirmware>(_handleCheckKaonicFirmware);
    on<UploadFirmware>(_handleUploadFirmware);
  }

  final OtaService _otaService;

  Future<void> _handleDownloadFirmware(
      DownloadFirmware event, Emitter<OtaState> emit) async {
    emit(state.copyWith(remoteFirmwareState: OtaProcessingState.processing));

    final result = await _otaService.checkRemoteLatestVersion();

    emit(state.copyWith(
      remoteFirmwareState:
          result ? OtaProcessingState.success : OtaProcessingState.failure,
      tagNameLocal: _otaService.localTagName,
      tagNameRemote: _otaService.remoteTagName,
    ));
    await Future.delayed(Duration(milliseconds: 800));

    emit(state.copyWith(remoteFirmwareState: OtaProcessingState.idle));
  }

  Future<void> _handleCheckKaonicFirmware(
      CheckKaonicFirmware event, Emitter<OtaState> emit) async {
    emit(state.copyWith(kaonicFirmwareState: OtaProcessingState.processing));

    final result = await _otaService.updateKaonicFWVersion();

    emit(state.copyWith(
        kaonicFirmwareState:
            result ? OtaProcessingState.success : OtaProcessingState.failure,
        kaonicFwVersion: _otaService.kaonicFwVersion));
    await Future.delayed(Duration(milliseconds: 800));
    emit(state.copyWith(kaonicFirmwareState: OtaProcessingState.idle));
  }

  Future<void> _handleUploadFirmware(
      UploadFirmware event, Emitter<OtaState> emit) async {
    emit(state.copyWith(
        kaonicUploadFirmwareState: OtaProcessingState.processing));

    final result = await _otaService.uploadOtaToKaonic();
    if (result) {
      add(CheckKaonicFirmware());
    }

    emit(state.copyWith(
        kaonicUploadFirmwareState:
            result ? OtaProcessingState.success : OtaProcessingState.failure,
        kaonicFwVersion: _otaService.kaonicFwVersion));
    await Future.delayed(Duration(milliseconds: 800));
    emit(state.copyWith(kaonicUploadFirmwareState: OtaProcessingState.idle));
  }
}
