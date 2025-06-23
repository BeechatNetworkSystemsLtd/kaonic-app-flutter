
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/models/settings.dart';
import 'package:kaonic/service/kaonic_communication_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required KaonicCommunicationService communicationService,
  })  : _communicationService = communicationService,
        super(SettingsState()) {
    on<UpdateFrequency>(
        (event, emit) => emit((state.copyWith(frequency: event.frequency))));
    on<UpdateChannelSpacing>(
        (event, emit) => emit((state.copyWith(channelSpacing: event.spacing))));
    on<UpdateChannel>(
        (event, emit) => emit((state.copyWith(channel: event.channel))));
    on<UpdateOption>(
        (event, emit) => emit((state.copyWith(option: event.option))));
    on<UpdateRate>((event, emit) => emit((state.copyWith(rate: event.rate))));
    on<UpdateTxPower>(
      (event, emit) => emit(state.copyWith(txPower: event.txPower)),
    );
    on<SaveSettings>(_saveSettings);
  }
  final KaonicCommunicationService _communicationService;

  Future<void> _saveSettings(
      SaveSettings event, Emitter<SettingsState> emit) async {
    _communicationService.sendConfig(
      mcs: state.rate.index,
      optionNumber: state.option.index,
      module: 0,
      frequency: int.parse(state.frequency),
      channel: state.channel,
      channelSpacing: int.parse(state.channelSpacing),
      txPower: 10,
    );
  }
}
