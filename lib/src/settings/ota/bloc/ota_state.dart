// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ota_bloc.dart';

@immutable
class OtaState {
  final String tagNameLocal;
  final String tagNameRemote;
  final String kaonicFwVersion;
  final OtaProcessingState remoteFirmwareState;
  final OtaProcessingState kaonicFirmwareState;
  final OtaProcessingState kaonicUploadFirmwareState;
  const OtaState({
    required this.tagNameLocal,
    required this.tagNameRemote,
    this.kaonicFwVersion = "",
    this.remoteFirmwareState = OtaProcessingState.idle,
    this.kaonicFirmwareState = OtaProcessingState.idle,
    this.kaonicUploadFirmwareState = OtaProcessingState.idle,
  });

  OtaState copyWith({
    String? tagNameLocal,
    String? tagNameRemote,
    String? kaonicFwVersion,
    OtaProcessingState? remoteFirmwareState,
    OtaProcessingState? kaonicFirmwareState,
    OtaProcessingState? kaonicUploadFirmwareState,
  }) {
    return OtaState(
      tagNameLocal: tagNameLocal ?? this.tagNameLocal,
      tagNameRemote: tagNameRemote ?? this.tagNameRemote,
      kaonicFwVersion: kaonicFwVersion ?? this.kaonicFwVersion,
      remoteFirmwareState: remoteFirmwareState ?? this.remoteFirmwareState,
      kaonicFirmwareState: kaonicFirmwareState ?? this.kaonicFirmwareState,
      kaonicUploadFirmwareState:
          kaonicUploadFirmwareState ?? this.kaonicUploadFirmwareState,
    );
  }
}
