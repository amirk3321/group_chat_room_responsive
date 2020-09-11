import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:group_chat_room_responsive/domain/entities/text_message_entity.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_messages_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/send_text_message_usecase.dart';

part 'communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  final GetMessagesUseCase getMessagesUseCase;
  final SendTextMessageUseCase sendTextMessageUseCase;
  CommunicationCubit({this.getMessagesUseCase,this.sendTextMessageUseCase}) : super(CommunicationInitial());

  Future<void> sendTextMsg({String name,String uid,String message})async{
    try{
      await sendTextMessageUseCase.call(TextMessageEntity("", uid, name, "TEXT", Timestamp.now(), message, ""));
    }on SocketException catch(_){}
  }
  Future<void> getTextMessages()async{
    try{
      final messages=getMessagesUseCase.call();
      messages.listen((msg) {
        emit(CommunicationLoaded(messages: msg));
      });
    }on SocketException catch(_){}
  }
}
