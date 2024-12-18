import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/auth_data_source.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/verification_data_source.dart';
import 'package:mesran_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/data/repository/verification_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/auth_use_case.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/verification_use_case.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_bloc.dart';

Future<void> authInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => AuthDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => VerificationDataSource(getIt<DioClient>()));
  
  /// Repositories
  getIt.registerLazySingleton(() => AuthRepositoryImpl(getIt<AuthDataSource>()));
  getIt.registerLazySingleton(() => VerificationRepositoryImpl(getIt<VerificationDataSource>()));
  
  /// Use Cases
  getIt.registerLazySingleton(() => AuthUseCase(getIt<AuthRepositoryImpl>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => VerificationUseCase(getIt<VerificationRepositoryImpl>(), getIt<FlutterSecureStorage>()));

  /// Blocs
  getIt.registerFactory(() => AuthBloc(getIt<AuthUseCase>(), getIt<FlutterSecureStorage>()));
  getIt.registerFactory(() => OtpVerificationBloc(getIt<VerificationUseCase>()));
}
