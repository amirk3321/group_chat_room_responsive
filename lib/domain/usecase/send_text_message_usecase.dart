

import 'package:group_chat_room_responsive/domain/entities/text_message_entity.dart';
import 'package:group_chat_room_responsive/domain/repositories/firebase_repository.dart';

class SendTextMessageUseCase{
  final FireBaseRepository repository;

  SendTextMessageUseCase({this.repository});

  Future<void> call(TextMessageEntity textMessage){
    return repository.sendTextMessage(textMessage);
  }

}