import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/enums/radio_settings_type_enum.dart';
import 'package:kaonic/data/extensions/fsk_bandwidth_extension.dart';
import 'package:kaonic/data/extensions/midsx_extension.dart';
import 'package:kaonic/data/extensions/midx_bits_extension.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/data/repository/radio_settings_repository.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final RadioSettingsRepository _radioSettingsRepository;
  SettingsBloc(
    this._radioSettingsRepository, {
    required KaonicCommunicationService communicationService,
  })  : _communicationService = communicationService,
        super(SettingsState(
          radioSettingsA: _radioSettingsRepository
                  .getSettingContainer()
                  ?.radioSettingsA
                  .target ??
              RadioSettings(),
          radioSettingsB: _radioSettingsRepository
                  .getSettingContainer()
                  ?.radioSettingsB
                  .target ??
              RadioSettings(),
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
    on<UpdateDW>(_onUpdateDW);
    on<UpdateFreqInversion>(_onUpdateFreqInversion);
    on<UpdatePreambleInversion>(_onUpdatePreambleInversion);
    on<UpdateSftq>(_onUpdateSftq);
    on<UpdateRawbit>(_onUpdateRawbit);
    on<UpdatePe>(_onUpdatePe);
    on<UpdateEn>(_onUpdateEn);
    on<UpdateFSKPE>(_onUpdateFSKPE);
    on<UpdatePreambleLenght>(_onUpdatePreambleLenght);
  }
  final KaonicCommunicationService _communicationService;

  Future<void> _saveSettings(
      SaveSettings event, Emitter<SettingsState> emit) async {
    _communicationService.sendConfig(
      mcs: state.radioSettings.rate.index,
      optionNumber: state.radioSettings.option.index,
      module: 0,
      frequency: int.parse(state.radioSettings.frequency),
      channel: state.radioSettings.channel,
      channelSpacing: int.parse(state.radioSettings.channelSpacing),
      txPower: int.parse(state.radioSettings.txPower),
      bt: state.radioSettings.bandwidthTime.value,
      midxs: state.radioSettings.midxs.value,
      midxsBits: state.radioSettings.midxsBits.value,
      mord: state.radioSettings.mord.value,
      srate: state.radioSettings.srate.value,
      pdtm: state.radioSettings.pdtm.value,
      rxo: state.radioSettings.rxo.value,
      rxpto: state.radioSettings.rxpto.value,
      mse: state.radioSettings.mse.value,
      fecs: state.radioSettings.fecs.value,
      fecie: state.radioSettings.fecie.value,
      sfd32: state.radioSettings.sfd32.value,
      csfd1: state.radioSettings.csfd1.value,
      csfd0: state.radioSettings.csfd0.value,
      sfd: state.radioSettings.sfd.value,
      dw: state.radioSettings.dw.value,
      freqInversion: state.radioSettings.freqInversion,
      preambleInversion: state.radioSettings.preambleInversion,
      sftq: state.radioSettings.sftq,
      rawbit: state.radioSettings.rawbit,
      pe: state.radioSettings.pe,
      en: state.radioSettings.en,
      fskpe0: state.radioSettings.fskpe0,
      fskpe1: state.radioSettings.fskpe1,
      fskpe2: state.radioSettings.fskpe2,
      preambleLength: state.radioSettings.preambleLength,
    );

    _radioSettingsRepository.saveSettings(
      state.radioSettingsA,
      state.radioSettingsB,
    );
  }

  bool get isRfa => state.radioSettingsType == RadioSettingsType.rfa;

  void _onUpdateRadioType(UpdateRadioType event, Emitter<SettingsState> emit) {
    emit(state.copyWith(radioSettingsType: event.radioSettingsType));
  }

  void _onUpdateFrequency(UpdateFrequency event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(frequency: event.frequency)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(frequency: event.frequency)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateChannelSpacing(
      UpdateChannelSpacing event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(channelSpacing: event.spacing)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(channelSpacing: event.spacing)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateChannel(UpdateChannel event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(channel: event.channel)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(channel: event.channel)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateOption(UpdateOption event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(option: event.option)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(option: event.option)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateRate(UpdateRate event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(rate: event.rate)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(rate: event.rate)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateTxPower(UpdateTxPower event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(txPower: event.txPower)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(txPower: event.txPower)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateBandwidthTime(
      UpdateBandwidthTime event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(btIndex: event.bandwidthTime.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(btIndex: event.bandwidthTime.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateMIDXS(UpdateMIDXS event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(midxsIndex: event.midxs.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(midxsIndex: event.midxs.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateMIDXSBits(UpdateMIDXSBits event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA
                .copyWith(midxsBitsIndex: event.midxsBits.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB
                .copyWith(midxsBitsIndex: event.midxsBits.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateMord(UpdateMord event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(mordIndex: event.mord.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(mordIndex: event.mord.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateSRate(UpdateSRate event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(srateIndex: event.sRate.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(srateIndex: event.sRate.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdatePDTM(UpdatePDTM event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(pdtmIndex: event.pdtm.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(pdtmIndex: event.pdtm.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateRXO(UpdateRXO event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(rxoIndex: event.rxo.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(rxoIndex: event.rxo.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateRXPTO(UpdateRXPTO event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(rxptoIndex: event.rxpto.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(rxptoIndex: event.rxpto.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateMSE(UpdateMSE event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(mseIndex: event.mse.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(mseIndex: event.mse.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateFECS(UpdateFECS event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(fecsIndex: event.fecs.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(fecsIndex: event.fecs.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateFECIE(UpdateFECIE event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(fecieIndex: event.fecie.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(fecieIndex: event.fecie.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateSFD32(UpdateSFD32 event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(sfd32Index: event.sfd32.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(sfd32Index: event.sfd32.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateCSFD1(UpdateCSFD1 event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(csfd1Index: event.csfd1.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(csfd1Index: event.csfd1.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateCSFD0(UpdateCSFD0 event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(csfd0Index: event.csfd0.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(csfd0Index: event.csfd0.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateSFD(UpdateSFD event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(sfdIndex: event.sfd.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(sfdIndex: event.sfd.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateDW(UpdateDW event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(dwIndex: event.dw.index)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(dwIndex: event.dw.index)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateFreqInversion(
      UpdateFreqInversion event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(freqInversion: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(freqInversion: event.value)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdatePreambleInversion(
      UpdatePreambleInversion event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(preambleInversion: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(preambleInversion: event.value)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateSftq(UpdateSftq event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(sftq: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(sftq: event.value)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateRawbit(UpdateRawbit event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(rawbit: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(rawbit: event.value)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdatePe(UpdatePe event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(pe: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(pe: event.value)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateEn(UpdateEn event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(en: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(en: event.value)
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdateFSKPE(UpdateFSKPE event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(
                fskpe0: event.fskpe0,
                fskpe1: event.fskpe1,
                fskpe2: event.fskpe2,
              )
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(
                fskpe0: event.fskpe0,
                fskpe1: event.fskpe1,
                fskpe2: event.fskpe2,
              )
            : state.radioSettingsB,
      ),
    );
  }

  void _onUpdatePreambleLenght(
      UpdatePreambleLenght event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        radioSettingsA: isRfa
            ? state.radioSettingsA.copyWith(preambleLength: event.value)
            : state.radioSettingsA,
        radioSettingsB: !isRfa
            ? state.radioSettingsB.copyWith(preambleLength: event.value)
            : state.radioSettingsB,
      ),
    );
  }
}
