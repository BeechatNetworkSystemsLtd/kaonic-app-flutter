import 'package:json_annotation/json_annotation.dart';

enum PhyConfigTypeEnum {
  @JsonValue('Ofdm')
  ofdm,
  @JsonValue('Fsk')
  fsk,
}
