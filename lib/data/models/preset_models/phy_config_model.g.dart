// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phy_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhyConfig _$PhyConfigFromJson(Map<String, dynamic> json) => PhyConfig(
      type: $enumDecode(_$PhyConfigTypeEnumEnumMap, json['type']),
      data: PhyConfigData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhyConfigToJson(PhyConfig instance) => <String, dynamic>{
      'type': _$PhyConfigTypeEnumEnumMap[instance.type]!,
      'data': instance.data,
    };

const _$PhyConfigTypeEnumEnumMap = {
  PhyConfigTypeEnum.fsk: 'Fsk',
  PhyConfigTypeEnum.ofdm: 'Ofdm',
};
