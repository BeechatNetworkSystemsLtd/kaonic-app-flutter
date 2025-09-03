part of 'ota_bloc.dart';

@immutable
sealed class OtaEvent {}

class DownloadFirmware extends OtaEvent {}

class CheckKaonicFirmware extends OtaEvent {}

class UploadFirmware extends OtaEvent {}
