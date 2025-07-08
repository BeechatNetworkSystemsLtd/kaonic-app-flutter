import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaonic/data/models/kaonic_event.dart';
import 'package:kaonic/service/call_service.dart';
import 'package:kaonic/service/chat_service.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required ChatService chatService,
    required CallService callService,
    required String address,
  })  : _chatService = chatService,
        _address = address,
        _callService = callService,
        super(ChatState(
          address: address,
          callState: CallScreenStateInfo(callScreenState: CallScreenState.idle),
        )) {
    on<SendMessage>(_sendMessage);
    on<_UpdatedChats>(_updatedChats);
    on<_IntiChat>(_intiChat);
    on<InitiateCall>(_initiateCall);
    on<FilePicked>(_filePicked);
    on<_UpdateCallState>(_onUpdateCallState);
    on<EndCallAndPop>(_onEndCallAndPop);

    add(_IntiChat());
  }
  late final ChatService _chatService;
  late final CallService _callService;
  final String _address;
  StreamSubscription<List<KaonicEvent<KaonicEventData>>>? _chatSubscription;
  StreamSubscription<CallScreenStateInfo>? _callStateSubscription;

  @override
  Future<void> close() async {
    _chatSubscription?.cancel();
    _callStateSubscription?.cancel();
    _chatService.onChatIDUpdated = null;
    super.close();
  }

  FutureOr<void> _intiChat(_IntiChat event, Emitter<ChatState> emit) async {
    final chatId = await _chatService.createChat(_address);
    _chatService.onChatIDUpdated = _onChatIdChanged;
    final myAddress = await _chatService.myAddress();
    emit(state.copyWith(myAddress: myAddress));
    _chatSubscription = _chatService.getChatMessages(chatId).listen((messages) {
      add(_UpdatedChats(messages: messages));
    });
    _callStateSubscription = _callService.callState.listen((callState) {
      add(_UpdateCallState(callState: callState));
    });
  }

  FutureOr<void> _sendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    try {
      _chatService.sendTextMessage(event.message, _address);
    } catch (e) {
      if (kDebugMode) {
        print('\u001b[31mERROR: $e\u001b[0m');
      }
      return;
    }
    emit(state.copyWith(flagScrollToDown: true));
  }

  FutureOr<void> _updatedChats(_UpdatedChats event, Emitter<ChatState> emit) {
    // _communicationService.markMessageRead(state.address);
    _chatService.markMessagesAsRead(state.address);
    emit(state.copyWith(
      messages: event.messages,
      flagScrollToDown: true,
    ));
  }

  FutureOr<void> _initiateCall(
      InitiateCall event, Emitter<ChatState> emit) async {
    _callService.createCall(_address);

    emit(NavigateToCall(
      address: state.address,
      messages: state.messages,
      myAddress: state.myAddress,
      flagScrollToDown: state.flagScrollToDown,
      callState: state.callState,
    ));
  }

  void _filePicked(FilePicked event, Emitter<ChatState> emit) {
    if (event.file.files.isEmpty && event.file.files.first.path != null) return;
    final f = File(event.file.files.first.path!);
    _chatService.sendFileMessage(f.path, _address);
  }

  void _onChatIdChanged(String address, String chatId) {
    if (address != _address) return;
    _chatSubscription?.cancel();
    _chatSubscription = _chatService.getChatMessages(chatId).listen((messages) {
      add(_UpdatedChats(messages: messages));
    });
  }

  void _onUpdateCallState(_UpdateCallState event, Emitter<ChatState> emit) {
    emit(state.copyWith(callState: event.callState));
  }

  void _onEndCallAndPop(_, Emitter<ChatState> emit) {
    _callService.rejectCall();
    emit(state.copyWith(isCallEndedOnPop: true));
  }
}
