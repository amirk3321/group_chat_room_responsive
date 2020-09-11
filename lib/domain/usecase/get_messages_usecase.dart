

import 'package:group_chat_room_responsive/domain/entities/text_message_entity.dart';
import 'package:group_chat_room_responsive/domain/repositories/firebase_repository.dart';

class GetMessagesUseCase {
  final FireBaseRepository repository;

  GetMessagesUseCase({this.repository});

  Stream<List<TextMessageEntity>> call() => repository.getMessages();

}