import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/enums/phy_config_type_enum.dart';
import 'package:kaonic/data/enums/radio_settings_type_enum.dart';
import 'package:kaonic/data/models/preset_models/radio_preset_model.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/data/repository/radio_settings_repository.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

typedef RadioValueChanged = RadioSettings Function(RadioSettings);

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final RadioSettingsRepository _radioSettingsRepository;
  SettingsBloc(
    this._radioSettingsRepository, {
    required KaonicCommunicationService communicationService,
  })  : _communicationService = communicationService,
        super(SettingsState(
          radioSettingsA: _radioSettingsRepository.radioSettingsA,
          radioSettingsB: _radioSettingsRepository.radioSettingsB,
          phyConfig: _radioSettingsRepository.phyConfig,
          radioSettingsType: _radioSettingsRepository.radioSettingsType,
        )) {
    on<UpdateFrequency>(_onUpdateFrequency);
    on<UpdateChannelSpacing>(_onUpdateChannelSpacing);
    on<UpdateChannel>(_onUpdateChannel);
    on<UpdateOption>(_onUpdateOption);
    on<UpdateRate>(_onUpdateRate);
    on<UpdateTxPower>(_onUpdateTxPower);
    on<SaveSettings>(_saveSettings);
    on<UpdateRadioType>(_onUpdateRadioType);
    on<UpdateBandwidthTime>(_onUpdateBandwidthTime);
    on<UpdateMIDXS>(_onUpdateMIDXS);
    on<UpdateMIDXSBits>(_onUpdateMIDXSBits);
    on<UpdateMord>(_onUpdateMord);
    on<UpdateSRate>(_onUpdateSRate);
    on<UpdatePDTM>(_onUpdatePDTM);
    on<UpdateRXO>(_onUpdateRXO);
    on<UpdateRXPTO>(_onUpdateRXPTO);
    on<UpdateMSE>(_onUpdateMSE);
    on<UpdateFECS>(_onUpdateFECS);
    on<UpdateFECIE>(_onUpdateFECIE);
    on<UpdateSFD32>(_onUpdateSFD32);
    on<UpdateCSFD1>(_onUpdateCSFD1);
    on<UpdateCSFD0>(_onUpdateCSFD0);
    on<UpdateSFD>(_onUpdateSFD);
    on<UpdateSFDT>(_onUpdateSFDT);
    on<UpdateDW>(_onUpdateDW);
    on<UpdateFreqInversion>(_onUpdateFreqInversion);
    on<UpdatePreambleInversion>(_onUpdatePreambleInversion);
    on<UpdateSftq>(_onUpdateSftq);
    on<UpdateRawbit>(_onUpdateRawbit);
    on<UpdatePe>(_onUpdatePe);
    on<UpdateEn>(_onUpdateEn);
    on<UpdateFSKPE>(_onUpdateFSKPE);
    on<UpdatePreambleLenght>(_onUpdatePreambleLenght);
    on<UpdateRadioOfdmFckType>(_onUpdateRadioOfdmFck);
    on<UpdatePDT>(_updatePDT);
    on<_GetPresets>(_onGetPresets);
    on<SetPreset>(_onSetPreset);
    on<UpdateSfd>(_onUpdateSfd);

    add(_GetPresets());
  }
  final KaonicCommunicationService _communicationService;

  void _updateSetting(
    Emitter<SettingsState> emit,
    RadioValueChanged update,
  ) {
    emit(
      isRfa
          ? state.copyWith(radioSettingsA: update(state.radioSettingsA))
          : state.copyWith(radioSettingsB: update(state.radioSettingsB)),
    );
  }

  Future<void> _saveSettings(
      SaveSettings event, Emitter<SettingsState> emit) async {
    _communicationService.sendConfig(
      radioSettings: state.radioSettings,
      configType: state.phyConfig,
    );

    _radioSettingsRepository.saveSettings(
      state.radioSettingsA,
      state.radioSettingsB,
      state.radioSettingsType.index,
      state.phyConfig.index,
    );

    emit(state.copyWith(isSaved: true));
  }

  bool get isRfa => state.radioSettingsType == RadioSettingsType.rfa;

  void _onUpdateRadioType(UpdateRadioType event, Emitter<SettingsState> emit) {
    emit(state.copyWith(radioSettingsType: event.radioSettingsType));
    _updateSetting(
        emit, (rs) => rs.copyWith(module: event.radioSettingsType.index));
  }

  void _onUpdateFrequency(UpdateFrequency event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(frequency: event.frequency));
  }

  void _onUpdateChannelSpacing(
      UpdateChannelSpacing event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(channelSpacing: event.spacing));
  }

  void _onUpdateChannel(UpdateChannel event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(channel: event.channel));
  }

  void _onUpdateOption(UpdateOption event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(option: event.option));
  }

  void _onUpdateRate(UpdateRate event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(rate: event.rate));
  }

  void _onUpdateTxPower(UpdateTxPower event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(txPower: event.txPower));
  }

  void _onUpdateBandwidthTime(
      UpdateBandwidthTime event, Emitter<SettingsState> emit) {
    _updateSetting(
        emit, (rs) => rs.copyWith(btIndex: event.bandwidthTime.index));
  }

  void _onUpdateMIDXS(UpdateMIDXS event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(midxsIndex: event.midxs.index));
  }

  void _onUpdateMIDXSBits(UpdateMIDXSBits event, Emitter<SettingsState> emit) {
    _updateSetting(
        emit, (rs) => rs.copyWith(midxsBitsIndex: event.midxsBits.index));
  }

  void _onUpdateMord(UpdateMord event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(mordIndex: event.mord.index));
  }

  void _onUpdateSRate(UpdateSRate event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(srateIndex: event.sRate.index));
  }

  void _onUpdatePDTM(UpdatePDTM event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(pdtmIndex: event.pdtm.index));
  }

  void _onUpdateRXO(UpdateRXO event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(rxoIndex: event.rxo.index));
  }

  void _onUpdateRXPTO(UpdateRXPTO event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(rxptoIndex: event.rxpto.index));
  }

  void _onUpdateMSE(UpdateMSE event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(mseIndex: event.mse.index));
  }

  void _onUpdateFECS(UpdateFECS event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(fecsIndex: event.fecs.index));
  }

  void _onUpdateFECIE(UpdateFECIE event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(fecieIndex: event.fecie.index));
  }

  void _onUpdateSFD32(UpdateSFD32 event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(sfd32Index: event.sfd32.index));
  }

  void _onUpdateCSFD1(UpdateCSFD1 event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(csfd1Index: event.csfd1.index));
  }

  void _onUpdateCSFD0(UpdateCSFD0 event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(csfd0Index: event.csfd0.index));
  }

  void _onUpdateSFD(UpdateSFD event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(sfdIndex: event.sfd.index));
  }

  void _onUpdateDW(UpdateDW event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(dwIndex: event.dw.index));
  }

  void _onUpdateFreqInversion(
      UpdateFreqInversion event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(freqInversion: event.value));
  }

  void _onUpdatePreambleInversion(
      UpdatePreambleInversion event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(preambleInversion: event.value));
  }

  void _onUpdateSftq(UpdateSftq event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(sftq: event.value));
  }

  void _onUpdateRawbit(UpdateRawbit event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(rawbit: event.value));
  }

  void _onUpdatePe(UpdatePe event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(pe: event.value));
  }

  void _onUpdateEn(UpdateEn event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(en: event.value));
  }

  void _onUpdateFSKPE(UpdateFSKPE event, Emitter<SettingsState> emit) {
    _updateSetting(
        emit,
        (rs) => rs.copyWith(
              fskpe0: event.fskpe0,
              fskpe1: event.fskpe1,
              fskpe2: event.fskpe2,
            ));
  }

  void _onUpdatePreambleLenght(
      UpdatePreambleLenght event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(preambleLength: event.value));
  }

  FutureOr<void> _onUpdateRadioOfdmFck(
      UpdateRadioOfdmFckType event, Emitter<SettingsState> emit) {
    emit(state.copyWith(phyConfig: event.phyConfig));
  }

  FutureOr<void> _onUpdateSFDT(
      UpdateSFDT event, Emitter<SettingsState> emit) async {
    _updateSetting(emit, (rs) => rs.copyWith(sfdt: event.value));
  }

  FutureOr<void> _updatePDT(UpdatePDT event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.copyWith(pdt: event.value));
  }

  void _onGetPresets(_, Emitter<SettingsState> emit) async {
    final presets = await _communicationService.getPresets();

    emit(state.copyWith(presets: presets));
  }

  void _onSetPreset(SetPreset event, Emitter<SettingsState> emit) {
    _updateSetting(emit, (rs) => rs.fromRadioPreset(event.preset));
    emit(state.copyWith(phyConfig: event.preset.phyConfig.type));
  }

  FutureOr<void> _onUpdateSfd(
      UpdateSfd event, Emitter<SettingsState> emit) async {
    _updateSetting(
        emit,
        (rs) => rs.copyWith(
              sfd0: event.sfd0,
              sfd1: event.sfd1,
            ));
  }
}
