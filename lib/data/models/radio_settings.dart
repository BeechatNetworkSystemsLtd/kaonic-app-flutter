import 'dart:convert';

import 'package:kaonic/data/enums/phy_config_type_enum.dart';
import 'package:kaonic/data/extensions/fsk_bandwidth_extension.dart';
import 'package:kaonic/data/extensions/midsx_extension.dart';
import 'package:kaonic/data/extensions/midx_bits_extension.dart';
import 'package:kaonic/data/models/preset_models/phy_config_model.dart';
import 'package:kaonic/data/models/preset_models/radio_preset_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

@Entity()
class RadioSettings {
  @Id()
  int id;
  // GENERAL
  final String frequency;
  final String txPower;
  final int channel;
  final String channelSpacing;
  // rfa=0, rfb=1
  final int module;

  // PHY OFDM
  @Property(type: PropertyType.int)
  int optionIndex;
  @Property(type: PropertyType.int)
  int rateIndex;

  //PHY FCK
  @Property(type: PropertyType.int)
  int btIndex;
  @Property(type: PropertyType.int)
  int midxsIndex;
  @Property(type: PropertyType.int)
  int midxsBitsIndex;
  @Property(type: PropertyType.int)
  int mordIndex;
  @Property(type: PropertyType.int)
  int srateIndex;
  @Property(type: PropertyType.int)
  int pdtmIndex;
  @Property(type: PropertyType.int)
  int rxoIndex;
  @Property(type: PropertyType.int)
  int rxptoIndex;
  @Property(type: PropertyType.int)
  int mseIndex;
  @Property(type: PropertyType.int)
  int fecsIndex;
  @Property(type: PropertyType.int)
  int fecieIndex;
  @Property(type: PropertyType.int)
  int sfd32Index;
  @Property(type: PropertyType.int)
  int csfd1Index;
  @Property(type: PropertyType.int)
  int csfd0Index;
  @Property(type: PropertyType.int)
  int sfdIndex;
  @Property(type: PropertyType.int)
  int dwIndex;
  final bool freqInversion;
  final bool preambleInversion;
  final bool sftq;
  final bool rawbit;
  final bool pe;
  final bool en;
  final int fskpe0;
  final int fskpe1;
  final int fskpe2;
  final int preambleLength;
  final int sfdt;
  final int pdt;
  final int sfd0;
  final int sfd1;

  // HELPERS
  @Transient()
  OFDMOptions get option => OFDMOptions.values[optionIndex];
  @Transient()
  OFDMRate get rate => OFDMRate.values[rateIndex];
  @Transient()
  FSKBandwidthTime get bandwidthTime => FSKBandwidthTime.values[btIndex];
  @Transient()
  MIDXS get midxs => MIDXS.values[midxsIndex];
  @Transient()
  MIDXSBits get midxsBits => MIDXSBits.values[midxsBitsIndex];
  @Transient()
  FSKModulationOrder get mord => FSKModulationOrder.values[mordIndex];
  @Transient()
  FSKSymbolRate get srate => FSKSymbolRate.values[srateIndex];
  @Transient()
  PDTMMode get pdtm => PDTMMode.values[pdtmIndex];
  @Transient()
  RXOOption get rxo => RXOOption.values[rxoIndex];
  @Transient()
  RXPTOOption get rxpto => RXPTOOption.values[rxptoIndex];
  @Transient()
  MSEOption get mse => MSEOption.values[mseIndex];
  @Transient()
  FECSOption get fecs => FECSOption.values[fecsIndex];
  @Transient()
  FECIEOption get fecie => FECIEOption.values[fecieIndex];
  @Transient()
  SFD32Option get sfd32 => SFD32Option.values[sfd32Index];
  @Transient()
  CSFD1Option get csfd1 => CSFD1Option.values[csfd1Index];
  @Transient()
  CSFD0Option get csfd0 => CSFD0Option.values[csfd0Index];
  @Transient()
  SFDOption get sfd => SFDOption.values[sfdIndex];
  @Transient()
  DWOption get dw => DWOption.values[dwIndex];

  RadioSettings({
    this.id = 0,
    this.frequency = KaonicCommunicationService.defaultFrequency,
    this.channelSpacing = KaonicCommunicationService.defaultChannelSpacing,
    this.module = 1,
    this.channel = 11,
    this.optionIndex = 0,
    this.rateIndex = 6,
    this.txPower = KaonicCommunicationService.defaultTxPower,
    this.btIndex = 0,
    this.midxsIndex = 0,
    this.midxsBitsIndex = 0,
    this.mordIndex = 0,
    this.srateIndex = 0,
    this.pdtmIndex = 0,
    this.rxoIndex = 0,
    this.rxptoIndex = 0,
    this.mseIndex = 0,
    this.fecsIndex = 0,
    this.fecieIndex = 0,
    this.sfd32Index = 0,
    this.csfd1Index = 0,
    this.csfd0Index = 0,
    this.sfdIndex = 0,
    this.dwIndex = 0,
    this.freqInversion = false,
    this.preambleInversion = false,
    this.sftq = false,
    this.sfdt = 8,
    this.rawbit = false,
    this.pe = false,
    this.en = false,
    this.fskpe0 = 0x0,
    this.fskpe1 = 0x0,
    this.fskpe2 = 0x0,
    this.preambleLength = 0x0,
    this.pdt = 5,
    this.sfd0 = 0,
    this.sfd1 = 0,
  });

  RadioSettings copyWith({
    int? id,
    String? frequency,
    String? txPower,
    int? channel,
    String? channelSpacing,
    int? optionIndex,
    int? rateIndex,
    int? btIndex,
    int? midxsIndex,
    int? midxsBitsIndex,
    int? mordIndex,
    int? srateIndex,
    int? pdtmIndex,
    int? rxoIndex,
    int? rxptoIndex,
    int? mseIndex,
    int? fecsIndex,
    int? fecieIndex,
    int? sfd32Index,
    int? csfd1Index,
    int? csfd0Index,
    int? sfdIndex,
    int? sfdt,
    int? dwIndex,
    OFDMOptions? option,
    OFDMRate? rate,
    FSKModulationOrder? mord,
    FSKSymbolRate? srate,
    PDTMMode? pdtm,
    RXOOption? rxo,
    RXPTOOption? rxpto,
    MSEOption? mse,
    FECSOption? fecs,
    FECIEOption? fecie,
    SFD32Option? sfd32,
    CSFD1Option? csfd1,
    CSFD0Option? csfd0,
    SFDOption? sfd,
    DWOption? dw,
    bool? freqInversion,
    bool? preambleInversion,
    bool? sftq,
    bool? rawbit,
    bool? pe,
    bool? en,
    int? fskpe0,
    int? fskpe1,
    int? fskpe2,
    int? preambleLength,
    int? pdt,
    int? sfd0,
    int? sfd1,
    int? module,
  }) {
    return RadioSettings(
      id: id ?? this.id,
      frequency: frequency ?? this.frequency,
      txPower: txPower ?? this.txPower,
      channel: channel ?? this.channel,
      btIndex: btIndex ?? this.btIndex,
      midxsIndex: midxsIndex ?? this.midxsIndex,
      midxsBitsIndex: midxsBitsIndex ?? this.midxsBitsIndex,
      channelSpacing: channelSpacing ?? this.channelSpacing,
      optionIndex: optionIndex ?? option?.index ?? this.optionIndex,
      rateIndex: rateIndex ?? rate?.index ?? this.rateIndex,
      mordIndex: mordIndex ?? mord?.index ?? this.mordIndex,
      srateIndex: srateIndex ?? srate?.index ?? this.srateIndex,
      pdtmIndex: pdtmIndex ?? pdtm?.index ?? this.pdtmIndex,
      rxoIndex: rxoIndex ?? rxo?.index ?? this.rxoIndex,
      rxptoIndex: rxptoIndex ?? rxpto?.index ?? this.rxptoIndex,
      mseIndex: mseIndex ?? mse?.index ?? this.mseIndex,
      fecsIndex: fecsIndex ?? fecs?.index ?? this.fecsIndex,
      fecieIndex: fecieIndex ?? fecie?.index ?? this.fecieIndex,
      sfd32Index: sfd32Index ?? sfd32?.index ?? this.sfd32Index,
      csfd1Index: csfd1Index ?? csfd1?.index ?? this.csfd1Index,
      csfd0Index: csfd0Index ?? csfd0?.index ?? this.csfd0Index,
      sfdIndex: sfdIndex ?? sfd?.index ?? this.sfdIndex,
      sfdt: sfdt ?? this.sfdt,
      dwIndex: dwIndex ?? dw?.index ?? this.dwIndex,
      freqInversion: freqInversion ?? this.freqInversion,
      preambleInversion: preambleInversion ?? this.preambleInversion,
      sftq: sftq ?? this.sftq,
      rawbit: rawbit ?? this.rawbit,
      pe: pe ?? this.pe,
      en: en ?? this.en,
      fskpe0: fskpe0 ?? this.fskpe0,
      fskpe1: fskpe1 ?? this.fskpe1,
      fskpe2: fskpe2 ?? this.fskpe2,
      preambleLength: preambleLength ?? this.preambleLength,
      pdt: pdt ?? this.pdt,
      sfd0: sfd0 ?? this.sfd0,
      sfd1: sfd1 ?? this.sfd1,
      module: module ?? this.module,
    );
  }

  RadioSettings fromRadioPreset(RadioPresetModel radioPreset) {
    final data = radioPreset.phyConfig.data;

    return copyWith(
      id: id,
      frequency: radioPreset.freq.toString(),
      txPower: radioPreset.txPower.toString(),
      channel: channel,
      btIndex: data.btIndex ?? btIndex,
      midxsIndex: data.midxsIndex ?? midxsIndex,
      midxsBitsIndex: data.midxsBitsIndex ?? midxsBitsIndex,
      channelSpacing: radioPreset.channelSpacing.toString(),
      optionIndex: data.optIndex ?? optionIndex,
      rateIndex: rateIndex,
      mordIndex: data.mordIndex ?? mordIndex,
      srateIndex: data.srateIndex ?? srateIndex,
      pdtmIndex: data.pdtmIndex ?? pdtmIndex,
      rxoIndex: data.rxoIndex ?? rxoIndex,
      rxptoIndex: data.rxptoIndex ?? rxptoIndex,
      mseIndex: data.mseIndex ?? mseIndex,
      fecsIndex: data.fecsIndex ?? fecsIndex,
      fecieIndex: fecieIndex,
      sfd32Index: data.sfd32Index ?? sfd32Index,
      csfd1Index: data.csfd1Index ?? csfd1Index,
      csfd0Index: data.csfd0Index ?? csfd0Index,
      sfdIndex: data.sfdIndex ?? sfdIndex,
      sfdt: data.sfdt ?? sfdt,
      dwIndex: data.dwIndex ?? dwIndex,
      freqInversion: data.freqInversion ?? freqInversion,
      preambleInversion: data.preambleInversion ?? preambleInversion,
      sftq: data.sftq ?? sftq,
      rawbit: data.rawbit ?? rawbit,
      pe: data.pe ?? pe,
      en: en,
      fskpe0: fskpe0,
      fskpe1: fskpe1,
      fskpe2: fskpe2,
      pdt: data.pdt ?? pdt,
      preambleLength: data.preambleLength ?? preambleLength,
      sfd0: data.sfd0 ?? sfd0,
      sfd1: data.sfd1 ?? sfd1,
      module: module,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'frequency': frequency,
      'txPower': txPower,
      'channel': channel,
      'channelSpacing': channelSpacing,
      'optionIndex': optionIndex,
      'rateIndex': rateIndex,
      'btIndex': btIndex,
      'midxsIndex': midxsIndex,
      'midxsBitsIndex': midxsBitsIndex,
      'mordIndex': mordIndex,
      'srateIndex': srateIndex,
      'pdtmIndex': pdtmIndex,
      'rxoIndex': rxoIndex,
      'rxptoIndex': rxptoIndex,
      'mseIndex': mseIndex,
      'fecsIndex': fecsIndex,
      'fecieIndex': fecieIndex,
      'sfd32Index': sfd32Index,
      'csfd1Index': csfd1Index,
      'csfd0Index': csfd0Index,
      'sfdIndex': sfdIndex,
      'sfdt': sfdt,
      'dwIndex': dwIndex,
      'freq_inversion': freqInversion,
      'preamble_inversion': preambleInversion,
      'sftq': sftq,
      'rawbit': rawbit,
      'pe': pe,
      'en': en,
      'fskpe0': fskpe0,
      'fskpe1': fskpe1,
      'fskpe2': fskpe2,
      'preambleLength': preambleLength,
      'pdt': pdt,
      'sfd0': sfd0,
      'sfd1': sfd1,
      'module': module,
    };
  }

  factory RadioSettings.fromJson(Map<String, dynamic> json) {
    return RadioSettings(
      id: json['id'] ?? 0,
      frequency:
          json['frequency'] ?? KaonicCommunicationService.defaultFrequency,
      txPower: json['txPower'] ?? KaonicCommunicationService.defaultTxPower,
      channel: json['channel'] ?? 11,
      channelSpacing: json['channelSpacing'] ??
          KaonicCommunicationService.defaultChannelSpacing,
      optionIndex: json['optionIndex'] ?? 0,
      rateIndex: json['rateIndex'] ?? 6,
      btIndex: json['btIndex'] ?? 0,
      midxsIndex: json['midxsIndex'] ?? 0,
      midxsBitsIndex: json['midxsBitsIndex'] ?? 0,
      mordIndex: json['mordIndex'] ?? 0,
      srateIndex: json['srateIndex'] ?? 0,
      pdtmIndex: json['pdtmIndex'] ?? 0,
      rxoIndex: json['rxoIndex'] ?? 0,
      rxptoIndex: json['rxptoIndex'] ?? 0,
      mseIndex: json['mseIndex'] ?? 0,
      fecsIndex: json['fecsIndex'] ?? 0,
      fecieIndex: json['fecieIndex'] ?? 0,
      sfd32Index: json['sfd32Index'] ?? 0,
      csfd1Index: json['csfd1Index'] ?? 0,
      csfd0Index: json['csfd0Index'] ?? 0,
      sfdIndex: json['sfdIndex'] ?? 0,
      sfdt: json['sfdt'] ?? 1,
      dwIndex: json['dwIndex'] ?? 0,
      freqInversion: json['freq_inversion'],
      preambleInversion: json['preamble_inversion'],
      sftq: json['sftq'],
      rawbit: json['rawbit'],
      pe: json['pe'],
      en: json['en'],
      fskpe0: json['fskpe0'],
      fskpe1: json['fskpe1'],
      fskpe2: json['fskpe2'],
      preambleLength: json['preambleLength'],
      pdt: json['pdt'],
      sfd0: json['sfd0'],
      sfd1: json['sfd1'],
      module: json['module'],
    );
  }

  String toJsonStringConfig(PhyConfigTypeEnum phyConfigType) {
    return jsonEncode({
      'freq': int.parse(frequency),
      'channel': channel,
      'channel_spacing': int.parse(channelSpacing),
      'tx_power': int.parse(txPower),
      'module': module,
      'phy_config': {
        'type': switch (phyConfigType) {
          PhyConfigTypeEnum.ofdm => 'Ofdm',
          PhyConfigTypeEnum.fsk => 'Fsk'
        },
        'data': switch (phyConfigType) {
          PhyConfigTypeEnum.ofdm => {
              'mcs': rateIndex,
              'opt': optionIndex,
            },
          PhyConfigTypeEnum.fsk => {
              'bt': bandwidthTime.value,
              'midxs': midxs.value,
              'midx': midxsBits.value,
              'mord': mord.value,
              'srate': srate.value,
              'pdtm': pdtm.value,
              'pdt': pdt,
              'rxo': rxo.value,
              'rxpto': rxpto.value,
              'mse': mse.value,
              'fecs': fecs.value,
              'fecie': fecie.value,
              'sfd32': sfd32.value,
              'csfd1': csfd1.value,
              'csfd0': csfd0.value,
              'sfd0': sfd0,
              'sfd1': sfd1,
              'sfd': sfd.value,
              'sfdt': sfdt,
              'dw': dw.value,
              'fskpe0': fskpe0,
              'fskpe1': fskpe1,
              'fskpe2': fskpe2,
              'preamble_length': preambleLength,
              'freq_inversion': freqInversion,
              'preamble_inversion': preambleInversion,
              'rawbit': rawbit,
              'pe': pe,
              'en': en,
              'sftq': sftq,
            }
        }
      },
    });
  }
}
