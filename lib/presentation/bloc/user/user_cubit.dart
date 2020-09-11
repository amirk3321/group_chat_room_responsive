import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:group_chat_room_responsive/domain/entities/user_entity.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_useres_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUseCase usersUseCase;
  UserCubit({this.usersUseCase}) : super(UserInitial());

  Future<void> getUsers()async{
    try{
      final user=usersUseCase.call();
      user.listen((users) {
        emit(UserLoaded(users: users));
      });
    }on SocketException catch(_){}
  }
}
