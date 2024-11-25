import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/core/utils/options.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/auth_data_source.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/verification_data_source.dart';
import 'package:mesran_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/data/repository/verification_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/auth_use_case.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/verification_use_case.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_bloc.dart';
import 'package:mesran_app/src/features/users/data/data_source/user_data_source.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  /*******************************************************************/
  /*****************************  GLOBAL *****************************/
  /*******************************************************************/
  getIt.registerLazySingleton(() => DioClient(baseUrl: Options.baseUrl)); //==> Dio Client
  getIt.registerLazySingleton(() => FlutterSecureStorage()); //==> Secure Storage
  final sharedPreferences = await SharedPreferences.getInstance(); //==> Shared Preference
  getIt.registerLazySingleton(() => sharedPreferences);

  /****************************************************************************/
  /*****************************  AUTHENTICATIONS *****************************/
  /****************************************************************************/
  getIt.registerLazySingleton(() => AuthDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => AuthRepositoryImpl(getIt<AuthDataSource>()));
  getIt.registerLazySingleton(() =>AuthUseCase(getIt<AuthRepositoryImpl>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => AuthBloc(getIt<AuthUseCase>(), getIt<FlutterSecureStorage>()));

  // Authentication Verifications
  getIt.registerLazySingleton(() => VerificationDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => VerificationRepositoryImpl(getIt<VerificationDataSource>()));
  getIt.registerLazySingleton(() => VerificationUseCase(getIt<VerificationRepositoryImpl>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => OtpVerificationBloc(getIt<VerificationUseCase>()));

  /******************************************************************/
  /*****************************  USERS *****************************/
  /******************************************************************/
  getIt.registerLazySingleton(() => UserDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => UserRepositoryImpl(getIt<UserDataSource>()));

  //==> User Registration <==//
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<UserRepositoryImpl>()));
  getIt.registerLazySingleton(() => RegisterBloc(getIt<RegisterUseCase>(), getIt<AuthUseCase>()));
}