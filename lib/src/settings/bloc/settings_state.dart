// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

class SettingsState {
  SettingsState(
      {this.frequency = KaonicCommunicationService.defaultFrequency,
      this.channelSpacing = KaonicCommunicationService.defaultChannelSpacing,
      this.channel = 11,
      this.option = OFDMOptions.option1,
      this.rate = OFDMRate.MCS_6,
      this.txPower = KaonicCommunicationService.defaultTxPower});
  final String frequency;
  final String txPower;
  final int channel;
  final String channelSpacing;
  final OFDMOptions option;
  final OFDMRate rate;

  bool get buttonEnabled =>
      frequency.isNotEmpty &&
      int.tryParse(frequency) != null &&
      txPower.isNotEmpty &&
      int.tryParse(txPower) != null &&
      channelSpacing.isNotEmpty &&
      int.tryParse(channelSpacing) != null;

  SettingsState copyWith({
    String? frequency,
    String? txPower,
    int? channel,
    String? channelSpacing,
    OFDMOptions? option,
    OFDMRate? rate,
  }) {
    return SettingsState(
      frequency: frequency ?? this.frequency,
      txPower: txPower ?? this.txPower,
      channel: channel ?? this.channel,
      channelSpacing: channelSpacing ?? this.channelSpacing,
      option: option ?? this.option,
      rate: rate ?? this.rate,
    );
  }
}
