// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phy_config_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhyConfigData _$PhyConfigDataFromJson(Map<String, dynamic> json) =>
    PhyConfigData(
      (json['bt'] as num?)?.toInt(),
      (json['midxs'] as num?)?.toInt(),
      (json['midx'] as num?)?.toInt(),
      (json['mord'] as num?)?.toInt(),
      (json['preamble_length'] as num?)?.toInt(),
      json['freq_inversion'] as bool?,
      (json['srate'] as num?)?.toInt(),
      (json['pdtm'] as num?)?.toInt(),
      (json['rxo'] as num?)?.toInt(),
      (json['rxpto'] as num?)?.toInt(),
      (json['mse'] as num?)?.toInt(),
      json['preamble_inversion'] as bool?,
      (json['fecs'] as num?)?.toInt(),
      json['fecie'] as bool?,
      (json['sfdt'] as num?)?.toInt(),
      (json['pdt'] as num?)?.toInt(),
      json['sftq'] as bool?,
      (json['sfd32'] as num?)?.toInt(),
      json['rawbit'] as bool?,
      (json['csfd1'] as num?)?.toInt(),
      (json['csfd0'] as num?)?.toInt(),
      (json['sfd0'] as num?)?.toInt(),
      (json['sfd1'] as num?)?.toInt(),
      (json['sfd'] as num?)?.toInt(),
      (json['dw'] as num?)?.toInt(),
      json['pe'] as bool?,
      mcsIndex: (json['mcs'] as num?)?.toInt(),
      optIndex: (json['opt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PhyConfigDataToJson(PhyConfigData instance) =>
    <String, dynamic>{
      'mcs': instance.mcsIndex,
      'opt': instance.optIndex,
      'bt': instance.btIndex,
      'midxs': instance.midxsIndex,
      'midx': instance.midxsBitsIndex,
      'mord': instance.mordIndex,
      'preamble_length': instance.preambleLength,
      'freq_inversion': instance.freqInversion,
      'srate': instance.srateIndex,
      'pdtm': instance.pdtmIndex,
      'rxo': instance.rxoIndex,
      'rxpto': instance.rxptoIndex,
      'mse': instance.mseIndex,
      'preamble_inversion': instance.preambleInversion,
      'fecs': instance.fecsIndex,
      'fecie': instance.fecie,
      'sfdt': instance.sfdt,
      'pdt': instance.pdt,
      'sftq': instance.sftq,
      'sfd32': instance.sfd32Index,
      'rawbit': instance.rawbit,
      'csfd1': instance.csfd1Index,
      'csfd0': instance.csfd0Index,
      'sfd0': instance.sfd0,
      'sfd1': instance.sfd1,
      'sfd': instance.sfdIndex,
      'dw': instance.dwIndex,
      'pe': instance.pe,
    };
