// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class UpdateFrequency extends SettingsEvent {
  final String frequency;
  UpdateFrequency({
    required this.frequency,
  });
}

class UpdateChannelSpacing extends SettingsEvent {
  final String spacing;
  UpdateChannelSpacing({
    required this.spacing,
  });
}

class UpdateTxPower extends SettingsEvent {
  final String txPower;
  UpdateTxPower({
    required this.txPower,
  });
}

class UpdateOption extends SettingsEvent {
  final OFDMOptions option;
  UpdateOption({
    required this.option,
  });
}

class UpdateChannel extends SettingsEvent {
  final int channel;
  UpdateChannel({
    required this.channel,
  });
}

class UpdateRate extends SettingsEvent {
  final OFDMRate rate;
  UpdateRate({
    required this.rate,
  });
}

final class SaveSettings extends SettingsEvent {}

class UpdateRadioType extends SettingsEvent {
  final RadioSettingsType radioSettingsType;

  UpdateRadioType(this.radioSettingsType);
}

class UpdateBandwidthTime extends SettingsEvent {
  final FSKBandwidthTime bandwidthTime;

  UpdateBandwidthTime(this.bandwidthTime);
}

class UpdateMIDXS extends SettingsEvent {
  final MIDXS midxs;

  UpdateMIDXS(this.midxs);
}

class UpdateMIDXSBits extends SettingsEvent {
  final MIDXSBits midxsBits;

  UpdateMIDXSBits(this.midxsBits);
}

class UpdateMord extends SettingsEvent {
  final FSKModulationOrder mord;

  UpdateMord(this.mord);
}

class UpdateSRate extends SettingsEvent {
  final FSKSymbolRate sRate;

  UpdateSRate(this.sRate);
}

class UpdatePDTM extends SettingsEvent {
  final PDTMMode pdtm;

  UpdatePDTM(this.pdtm);
}

class UpdateRXO extends SettingsEvent {
  final RXOOption rxo;

  UpdateRXO(this.rxo);
}

class UpdateRXPTO extends SettingsEvent {
  final RXPTOOption rxpto;

  UpdateRXPTO(this.rxpto);
}

class UpdateMSE extends SettingsEvent {
  final MSEOption mse;

  UpdateMSE(this.mse);
}

class UpdateFECS extends SettingsEvent {
  final FECSOption fecs;

  UpdateFECS(this.fecs);
}

class UpdateFECIE extends SettingsEvent {
  final FECIEOption fecie;

  UpdateFECIE(this.fecie);
}

class UpdateSFD32 extends SettingsEvent {
  final SFD32Option sfd32;

  UpdateSFD32(this.sfd32);
}

class UpdateCSFD1 extends SettingsEvent {
  final CSFD1Option csfd1;

  UpdateCSFD1(this.csfd1);
}

class UpdateCSFD0 extends SettingsEvent {
  final CSFD0Option csfd0;

  UpdateCSFD0(this.csfd0);
}

class UpdateSFD extends SettingsEvent {
  final SFDOption sfd;

  UpdateSFD(this.sfd);
}

class UpdateDW extends SettingsEvent {
  final DWOption dw;

  UpdateDW(this.dw);
}

class UpdateFreqInversion extends SettingsEvent {
  final bool value;

  UpdateFreqInversion(this.value);
}

class UpdatePreambleInversion extends SettingsEvent {
  final bool value;
  UpdatePreambleInversion(this.value);
}

class UpdateSftq extends SettingsEvent {
  final bool value;
  UpdateSftq(this.value);
}

class UpdateRawbit extends SettingsEvent {
  final bool value;
  UpdateRawbit(this.value);
}

class UpdatePe extends SettingsEvent {
  final bool value;
  UpdatePe(this.value);
}

class UpdateEn extends SettingsEvent {
  final bool value;
  UpdateEn(this.value);
}

class UpdateFSKPE extends SettingsEvent {
  final int? fskpe0;
  final int? fskpe1;
  final int? fskpe2;
  UpdateFSKPE({
    this.fskpe0,
    this.fskpe1,
    this.fskpe2,
  });
}

class UpdatePreambleLenght extends SettingsEvent {
  final int value;

  UpdatePreambleLenght(this.value);
}
