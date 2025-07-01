import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

class RadioSettings {
  final String frequency;
  final String txPower;
  final int channel;
  final String channelSpacing;
  final OFDMOptions option;
  final OFDMRate rate;

  const RadioSettings({
    this.frequency = KaonicCommunicationService.defaultFrequency,
    this.channelSpacing = KaonicCommunicationService.defaultChannelSpacing,
    this.channel = 11,
    this.option = OFDMOptions.option1,
    this.rate = OFDMRate.MCS_6,
    this.txPower = KaonicCommunicationService.defaultTxPower,
  });

  RadioSettings copyWith({
    String? frequency,
    String? txPower,
    int? channel,
    String? channelSpacing,
    OFDMOptions? option,
    OFDMRate? rate,
  }) {
    return RadioSettings(
      frequency: frequency ?? this.frequency,
      txPower: txPower ?? this.txPower,
      channel: channel ?? this.channel,
      channelSpacing: channelSpacing ?? this.channelSpacing,
      option: option ?? this.option,
      rate: rate ?? this.rate,
    );
  }
}
