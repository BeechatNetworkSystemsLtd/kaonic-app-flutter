import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/repository/passcode_repository.dart';
import 'package:kaonic/src/passcode/passcode_screen.dart';
import 'package:meta/meta.dart';

part 'passcode_event.dart';
part 'passcode_state.dart';

class PasscodeBloc extends Bloc<PasscodeEvent, PasscodeState> {
  PasscodeBloc({
    required PasscodeMode mode,
    required PasscodeRepository passcodeRepository,
    String? username,
  })  : _mode = mode,
        super(switch (mode) {
          PasscodeMode.create => const PasscodeCreate(code: ''),
          PasscodeMode.enter => const PasscodeEnter(code: '')
        }) {
    on<PasscodeChanged>(_handlePasscodeChange);
  }

  final PasscodeMode _mode;
  String _code = '';

  Future<void> _handlePasscodeChange(
      PasscodeChanged event, Emitter<PasscodeState> emit) async {
    //do not update _code after the PasscodeCreate step
    if (state is! PasscodeRepeat) {
      _code = event.code;
    }
    emit(state.copyWith(code: event.code));
    if (event.code.length == 4) {
      switch (_mode) {
        case PasscodeMode.enter:
          emit(PasscodeEnterSuccess(code: _code));
        // if (_passcodeRepository.checkPasscodeForUser(_username!, _code)) {

        // } else {
        //   emit(PasscodeEnterFailure(code: _code));
        // }
        case PasscodeMode.create:
          if (state is PasscodeCreate) {
            emit(const PasscodeRepeat(code: ''));
            return;
          }
          if (state is PasscodeRepeat) {
            if (event.code == _code) {
              emit(PasscodeCreatedSuccess(code: _code));
            } else {
              emit(PasscodeRepeatNotMatch(code: _code));
              emit(PasscodeRepeat(code: _code));
            }
          }
      }
    }
  }
}
