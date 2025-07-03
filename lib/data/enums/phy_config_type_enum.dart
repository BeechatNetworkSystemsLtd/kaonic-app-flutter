import 'package:json_annotation/json_annotation.dart';

enum PhyConfigTypeEnum {
  @JsonValue('Fsk')
  fsk,
  @JsonValue('Ofdm')
  ofdm,
}
