import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_current_uid.dart';
import 'package:group_chat_room_responsive/domain/usecase/is_signin_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUid getCurrentUidUseCase;
  AuthCubit({this.isSignInUseCase,this.getCurrentUidUseCase}) : super(AuthInitial());


  Future<void> appStarted()async{

    try{
      final isSignIn=await isSignInUseCase.call();
      print("Sign $isSignIn");
      if (isSignIn==true){
        final currentUid=await getCurrentUidUseCase.call();
        emit(Authenticated(uid: currentUid));
      }else{
        emit(UnAuthenticated());
      }
    }catch(_){
      print("heelo appStarted catch");
      emit(UnAuthenticated());
    }
  }
  Future<void> loggedIn() async{
    final currentUid=await getCurrentUidUseCase.call();
    emit(Authenticated(uid: currentUid));
  }
  Future<void> loggedOut() async {
    emit(UnAuthenticated());
  }
}
