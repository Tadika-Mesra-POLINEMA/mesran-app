import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/users/data/data_source/user_data_source.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';
import 'package:mesran_app/src/features/users/domain/usecases/get_user_use_case.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_face_use_case.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> userInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => UserDataSource(getIt<DioClient>()));

  /// Repositories
  getIt.registerLazySingleton(() => UserRepositoryImpl(getIt<UserDataSource>()));

  /// Use Cases
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<UserRepositoryImpl>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => RegisterFaceUseCase(getIt<UserRepositoryImpl>()));
  getIt.registerFactory(() => GetUserUseCase(getIt<UserRepositoryImpl>()));

  /// Blocs
  getIt.registerFactory(() => RegisterBloc(getIt<RegisterUseCase>(), getIt<SharedPreferences>()));
}
