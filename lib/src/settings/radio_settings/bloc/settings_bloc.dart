import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/enums/radio_settings_type_enum.dart';
import 'package:kaonic/data/models/radio_settings.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required KaonicCommunicationService communicationService,
  })  : _communicationService = communicationService,
        super(SettingsState()) {
    on<UpdateFrequency>((event, emit) => emit((state.copyWith(
        radioSettings:
            state.radioSettings.copyWith(frequency: event.frequency)))));
    on<UpdateChannelSpacing>((event, emit) => emit((state.copyWith(
        radioSettings:
            state.radioSettings.copyWith(channelSpacing: event.spacing)))));
    on<UpdateChannel>((event, emit) => emit((state.copyWith(
        radioSettings: state.radioSettings.copyWith(channel: event.channel)))));
    on<UpdateOption>((event, emit) => emit((state.copyWith(
        radioSettings: state.radioSettings.copyWith(option: event.option)))));
    on<UpdateRate>((event, emit) => emit((state.copyWith(
        radioSettings: state.radioSettings.copyWith(rate: event.rate)))));
    on<UpdateTxPower>(
      (event, emit) => emit(state.copyWith(
          radioSettings: state.radioSettings.copyWith(txPower: event.txPower))),
    );
    on<SaveSettings>(_saveSettings);
    on<UpdateRadioType>(_onUpdateRadioType);
  }
  final KaonicCommunicationService _communicationService;

  Future<void> _saveSettings(
      SaveSettings event, Emitter<SettingsState> emit) async {
    _communicationService.sendConfig(
      mcs: state.radioSettings.rate.index,
      optionNumber: state.radioSettings.option.index,
      module: 0,
      frequency: int.parse(state.radioSettings.frequency),
      channel: state.radioSettings.channel,
      channelSpacing: int.parse(state.radioSettings.channelSpacing),
      txPower: 10,
    );
  }

  void _onUpdateRadioType(UpdateRadioType event, Emitter<SettingsState> emit) {
    emit(state.copyWith(radioSettingsType: event.radioSettingsType));
  }
}
