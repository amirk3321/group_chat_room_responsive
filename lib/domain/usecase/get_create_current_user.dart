

import 'package:group_chat_room_responsive/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUser{
  final FireBaseRepository fireBaseRepository;

  GetCreateCurrentUser({this.fireBaseRepository});

  Future<void> call(String email,String name,String profileUrl)async{
    fireBaseRepository.getCreateCurrentUser(email, name, profileUrl);
  }

}