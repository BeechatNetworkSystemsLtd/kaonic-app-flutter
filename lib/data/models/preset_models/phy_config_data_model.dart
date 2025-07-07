import 'package:json_annotation/json_annotation.dart';

part 'phy_config_data_model.g.dart';

@JsonSerializable()
class PhyConfigData {
  @JsonKey(name: 'mcs')
  final int? mcsIndex;
  @JsonKey(name: 'opt')
  final int? optIndex;
  @JsonKey(name: 'bt')
  final int? btIndex;
  @JsonKey(name: 'midxs')
  final int? midxsIndex;
  @JsonKey(name: 'midx')
  final int? midxsBitsIndex;
  @JsonKey(name: 'mord')
  final int? mordIndex;
  @JsonKey(name: 'preamble_length')
  final int? preambleLength;
  @JsonKey(name: 'freq_inversion')
  final bool? freqInversion;
  @JsonKey(name: 'srate')
  final int? srateIndex;
  @JsonKey(name: 'pdtm')
  final int? pdtmIndex;
  @JsonKey(name: 'rxo')
  final int? rxoIndex;
  @JsonKey(name: 'rxpto')
  final int? rxptoIndex;
  @JsonKey(name: 'mse')
  final int? mseIndex;
  @JsonKey(name: 'preamble_inversion')
  final bool? preambleInversion;
  @JsonKey(name: 'fecs')
  final int? fecsIndex;
  @JsonKey(name: 'fecie')
  final bool? fecie;
  @JsonKey(name: 'sfdt')
  final int? sfdt;
  @JsonKey(name: 'pdt')
  final int? pdt;
  @JsonKey(name: 'sftq')
  final bool? sftq;
  @JsonKey(name: 'sfd32')
  final int? sfd32Index;
  @JsonKey(name: 'rawbit')
  final bool? rawbit;
  @JsonKey(name: 'csfd1')
  final int? csfd1Index;
  @JsonKey(name: 'csfd0')
  final int? csfd0Index;
  @JsonKey(name: 'sfd0')
  final int? sfd0;
  @JsonKey(name: 'sfd1')
  final int? sfd1;
  @JsonKey(name: 'sfd')
  final int? sfdIndex;
  @JsonKey(name: 'dw')
  final int? dwIndex;
  @JsonKey(name: 'pe')
  final bool? pe;

  const PhyConfigData(
    this.btIndex,
    this.midxsIndex,
    this.midxsBitsIndex,
    this.mordIndex,
    this.preambleLength,
    this.freqInversion,
    this.srateIndex,
    this.pdtmIndex,
    this.rxoIndex,
    this.rxptoIndex,
    this.mseIndex,
    this.preambleInversion,
    this.fecsIndex,
    this.fecie,
    this.sfdt,
    this.pdt,
    this.sftq,
    this.sfd32Index,
    this.rawbit,
    this.csfd1Index,
    this.csfd0Index,
    this.sfd0,
    this.sfd1,
    this.sfdIndex,
    this.dwIndex,
    this.pe, {
    this.mcsIndex,
    this.optIndex,
  });

  factory PhyConfigData.fromJson(Map<String, dynamic> json) =>
      _$PhyConfigDataFromJson(json);

  Map<String, dynamic> toJson() => _$PhyConfigDataToJson(this);
}
