part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}
class UserLoaded extends UserState{
  final List<UserEntity> users;

  UserLoaded({this.users});
  @override
  // TODO: implement props
  List<Object> get props => [users];
}
class UserLoading extends UserState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
