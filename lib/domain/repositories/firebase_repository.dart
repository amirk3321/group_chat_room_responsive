

import 'package:group_chat_room_responsive/domain/entities/text_message_entity.dart';
import 'package:group_chat_room_responsive/domain/entities/user_entity.dart';

abstract class FireBaseRepository{
  Future<void> signUp(String email,String password);
  Future<void> signIn(String email,String password);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();
  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl);
  Future<void> sendTextMessage(TextMessageEntity textMessage);
  Stream<List<UserEntity>> getUsers();
  Stream<List<TextMessageEntity>> getMessages();
}