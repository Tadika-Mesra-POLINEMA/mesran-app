import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/home/data/data_source/home_data_source.dart';
import 'package:mesran_app/src/features/home/data/repository/home_repository_impl.dart';
import 'package:mesran_app/src/features/home/domain/use_case/get_home_events_use_case.dart';
import 'package:mesran_app/src/features/home/domain/use_case/get_user_profile_use_case.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_bloc.dart';

Future<void> homeInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => HomeDataSource(getIt<DioClient>()));

  /// Repositories
  getIt.registerLazySingleton(() => HomeRepositoryImpl(getIt<HomeDataSource>()));

  /// Use Cases
  getIt.registerLazySingleton(() => GetHomeEventsUseCase(getIt<HomeRepositoryImpl>()));
  getIt.registerLazySingleton(() => GetUserProfileUseCase(getIt<HomeRepositoryImpl>()));
  
  /// Blocs
  getIt.registerLazySingleton(() => HomePageBloc(getIt<GetHomeEventsUseCase>(), getIt<GetUserProfileUseCase>()));
}
