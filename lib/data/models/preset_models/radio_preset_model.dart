import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/models/preset_models/phy_config_model.dart';

part 'radio_preset_model.g.dart';

@JsonSerializable()
class RadioPresetModel {
  final String name;
  final int freq;
  @JsonKey(name: 'channel_spacing')
  final int channelSpacing;
  @JsonKey(name: 'tx_power')
  final int txPower;
  @JsonKey(name: 'phy_config')
  final PhyConfig phyConfig;

  const RadioPresetModel({
    required this.name,
    required this.freq,
    required this.channelSpacing,
    required this.txPower,
    required this.phyConfig,
  });

  factory RadioPresetModel.fromJson(Map<String, dynamic> json) =>
      _$RadioPresetModelFromJson(json);

  Map<String, dynamic> toJson() => _$RadioPresetModelToJson(this);
}
