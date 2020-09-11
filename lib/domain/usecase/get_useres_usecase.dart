

import 'package:group_chat_room_responsive/domain/entities/user_entity.dart';
import 'package:group_chat_room_responsive/domain/repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FireBaseRepository repository;

  GetUsersUseCase({this.repository});

  Stream<List<UserEntity>> call() => repository.getUsers();


}