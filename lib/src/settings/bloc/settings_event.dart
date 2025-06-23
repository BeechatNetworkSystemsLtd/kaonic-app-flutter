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
