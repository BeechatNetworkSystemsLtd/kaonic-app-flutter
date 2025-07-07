import 'package:json_annotation/json_annotation.dart';
import 'package:kaonic/data/enums/phy_config_type_enum.dart';
import 'package:kaonic/data/models/preset_models/phy_config_data_model.dart';

part 'phy_config_model.g.dart';

@JsonSerializable()
class PhyConfig {
  final PhyConfigTypeEnum type;
  final PhyConfigData data;

  const PhyConfig({
    required this.type,
    required this.data,
  });

  factory PhyConfig.fromJson(Map<String, dynamic> json) =>
      _$PhyConfigFromJson(json);

  Map<String, dynamic> toJson() => _$PhyConfigToJson(this);
}
