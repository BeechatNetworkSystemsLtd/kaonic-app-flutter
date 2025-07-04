// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radio_preset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadioPresetModel _$RadioPresetModelFromJson(Map<String, dynamic> json) =>
    RadioPresetModel(
      name: json['name'] as String,
      freq: (json['freq'] as num).toInt(),
      channelSpacing: (json['channel_spacing'] as num).toInt(),
      txPower: (json['tx_power'] as num).toInt(),
      phyConfig: PhyConfig.fromJson(json['phy_config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RadioPresetModelToJson(RadioPresetModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'freq': instance.freq,
      'channel_spacing': instance.channelSpacing,
      'tx_power': instance.txPower,
      'phy_config': instance.phyConfig,
    };
