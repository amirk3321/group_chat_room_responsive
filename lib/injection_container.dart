import 'package:get_it/get_it.dart';
import 'package:group_chat_room_responsive/data/datasource/firebase_remote_datasource.dart';
import 'package:group_chat_room_responsive/data/repositories/firebasee_repository_impl.dart';
import 'package:group_chat_room_responsive/domain/repositories/firebase_repository.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_create_current_user.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_current_uid.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_messages_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/get_useres_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/is_signin_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/send_text_message_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/sign_out_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/sign_out_usecase.dart';
import 'package:group_chat_room_responsive/domain/usecase/signin_usecase.dart';
import 'package:group_chat_room_responsive/presentation/bloc/auth/auth_cubit.dart';
import 'package:group_chat_room_responsive/presentation/bloc/communication/communication_cubit.dart';
import 'package:group_chat_room_responsive/presentation/bloc/login/login_cubit.dart';

import 'domain/usecase/signup_usecase.dart';
import 'presentation/bloc/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Features bloc,
  sl.registerFactory<AuthCubit>(() =>
      AuthCubit(isSignInUseCase: sl.call(), getCurrentUidUseCase: sl.call()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
      getCreateCurrentUser: sl.call(),
      signOutUseCase: sl.call(),
  ));
  sl.registerFactory<UserCubit>(() => UserCubit(usersUseCase: sl.call()));
  sl.registerFactory<CommunicationCubit>(() => CommunicationCubit(
      getMessagesUseCase: sl.call(), sendTextMessageUseCase: sl.call()));
  //!useCase
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(sl.call()));
  sl.registerLazySingleton<GetCurrentUid>(
      () => GetCurrentUid(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUser>(
      () => GetCreateCurrentUser(fireBaseRepository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUsersUseCase>(
      () => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
          () => SignOutUseCase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FireBaseRepository>(
      () => FireBaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));
  //dataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl());
  //external
  //e.g final sharedPreference=await SharedPreferences.getInstance();
}
