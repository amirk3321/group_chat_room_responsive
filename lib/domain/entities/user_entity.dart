
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String name;
  final String email;
  final String uid;
  final String profileUrl;

  UserEntity(this.name, this.email, this.uid, this.profileUrl);

  @override
  // TODO: implement props
  List<Object> get props => [name,email,uid,profileUrl];
}