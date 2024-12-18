import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/events/data/data_source/activity_data_source.dart';
import 'package:mesran_app/src/features/events/data/data_source/event_data_source.dart';
import 'package:mesran_app/src/features/events/data/data_source/participant_data_source.dart';
import 'package:mesran_app/src/features/events/data/data_source/verify_face_data_source.dart';
import 'package:mesran_app/src/features/events/data/repository/activity_repository_impl.dart';
import 'package:mesran_app/src/features/events/data/repository/event_repository_impl.dart';
import 'package:mesran_app/src/features/events/data/repository/participant_repository_impl.dart';
import 'package:mesran_app/src/features/events/data/repository/verify_face_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/use_case/accept_attendance_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/cancel_event_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/create_activity_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/create_event_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_activities_by_event_id_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_event_by_id_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_participants_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/remove_activity_by_id_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/verify_face_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/activity_detail_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/add_activity_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_activity_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_participant_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> eventInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => EventDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => VerifyFaceDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => ActivityDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => ParticipantDataSource(getIt<DioClient>()));

  /// Repositories
  getIt.registerLazySingleton(() => EventRepositoryImpl(getIt<EventDataSource>()));
  getIt.registerLazySingleton(() => VerifyFaceRepositoryImpl(getIt<VerifyFaceDataSource>()));
  getIt.registerLazySingleton(() => ActivityRepositoryImpl(getIt<ActivityDataSource>()));
  getIt.registerLazySingleton(() => ParticipantRepositoryImpl(getIt<ParticipantDataSource>()));

  /// Use Cases
  getIt.registerLazySingleton(() => CreateEventUseCase(getIt<EventRepositoryImpl>(), getIt<SharedPreferences>()));
  getIt.registerLazySingleton(() => GetEventByIdUseCase(getIt<EventRepositoryImpl>()));
  getIt.registerLazySingleton(() => CancelEventUseCase(getIt<EventRepositoryImpl>()));
  getIt.registerLazySingleton(() => VerifyFaceUseCase(getIt<VerifyFaceRepositoryImpl>()));
  getIt.registerLazySingleton(() => GetActivitiesByEventIdUseCase(getIt<ActivityRepositoryImpl>()));
  getIt.registerLazySingleton(() => CreateActivityUseCase(getIt<ActivityRepositoryImpl>()));
  getIt.registerLazySingleton(() => RemoveActivityByIdUseCase(getIt<ActivityRepositoryImpl>()));
  getIt.registerLazySingleton(() => GetParticipantsUseCase(getIt<ParticipantRepositoryImpl>()));
  getIt.registerLazySingleton(() => AcceptAttendanceUseCase(getIt<ParticipantRepositoryImpl>()));

  /// Blocs
  getIt.registerFactory(() => CreateEventBloc(getIt<SharedPreferences>(), getIt<CreateEventUseCase>()));
  getIt.registerFactory(() => CreateEventActivityBloc(getIt<SharedPreferences>()));
  getIt.registerFactory(() => EventDresscodeBloc(getIt<SharedPreferences>()));
  getIt.registerFactory(() => EventDetailBloc(getIt<GetEventByIdUseCase>(), getIt<CancelEventUseCase>()));
  getIt.registerFactory(() => VerifyFaceBloc(getIt<VerifyFaceUseCase>()));
  getIt.registerFactory(() => ActivityDetailBloc(getIt<GetActivitiesByEventIdUseCase>(), getIt<RemoveActivityByIdUseCase>()));
  getIt.registerFactory(() => AddActivityBloc(getIt<GetEventByIdUseCase>(), getIt<CreateActivityUseCase>()));
  getIt.registerFactory(() => EventParticipantBloc(getIt<GetParticipantsUseCase>(), getIt<AcceptAttendanceUseCase>()));
}
