import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/history/data/data_source/history_data_source.dart';
import 'package:mesran_app/src/features/history/data/repository/history_repository_impl.dart';
import 'package:mesran_app/src/features/history/domain/use_case/get_event_history_use_case.dart';
import 'package:mesran_app/src/features/history/presentation/bloc/history_bloc.dart';

Future<void> historyInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => HistoryDataSource(getIt<DioClient>()));

  /// Repositories
  getIt.registerLazySingleton(() => HistoryRepositoryImpl(getIt<HistoryDataSource>()));

  /// Use Cases
  getIt.registerLazySingleton(() => GetEventHistoryUseCase(getIt<HistoryRepositoryImpl>()));

  /// Blocs
  getIt.registerFactory(() => HistoryBloc(getIt<GetEventHistoryUseCase>()));
}
