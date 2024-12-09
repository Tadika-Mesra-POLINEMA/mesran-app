import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/routes/routes.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/core/api/ml_client.dart';
import 'package:mesran_app/src/core/utils/options.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/auth_data_source.dart';
import 'package:mesran_app/src/features/authentication/data/data_source/verification_data_source.dart';
import 'package:mesran_app/src/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/data/repository/verification_repository_impl.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/auth_use_case.dart';
import 'package:mesran_app/src/features/authentication/domain/use_case/verification_use_case.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/auth_bloc.dart';
import 'package:mesran_app/src/features/authentication/presentation/blocs/verification_bloc.dart';
import 'package:mesran_app/src/features/events/data/data_source/event_data_source.dart';
import 'package:mesran_app/src/features/events/data/data_source/verify_face_data_source.dart';
import 'package:mesran_app/src/features/events/data/repository/event_repository_impl.dart';
import 'package:mesran_app/src/features/events/data/repository/verify_face_repository_impl.dart';
import 'package:mesran_app/src/features/events/domain/use_case/create_event_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/get_event_by_id_use_case.dart';
import 'package:mesran_app/src/features/events/domain/use_case/verify_face_use_case.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/create_event_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_detail_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/event_dresscode_bloc.dart';
import 'package:mesran_app/src/features/events/presentation/bloc/verify_face_bloc.dart';
import 'package:mesran_app/src/features/home/data/data_source/home_data_source.dart';
import 'package:mesran_app/src/features/home/data/repository/home_repository_impl.dart';
import 'package:mesran_app/src/features/home/domain/use_case/get_home_events_use_case.dart';
import 'package:mesran_app/src/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:mesran_app/src/features/users/data/data_source/user_data_source.dart';
import 'package:mesran_app/src/features/users/data/repository/user_repository_impl.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_face_use_case.dart';
import 'package:mesran_app/src/features/users/domain/usecases/register_use_case.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_bloc.dart';
import 'package:mesran_app/src/features/users/presentation/blocs/register_face_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  /*******************************************************************/
  /*****************************  GLOBAL *****************************/
  /*******************************************************************/
  getIt.registerLazySingleton(() => ML(baseUrl: Options.mlBaseUrl)); //==> ML Client
  getIt.registerLazySingleton(() => GoRouter(routes: Routes().getRoutes()));
  getIt.registerLazySingleton(() => FlutterSecureStorage()); //==> Secure Storage
  final sharedPreferences = await SharedPreferences.getInstance(); //==> Shared Preference
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => DioClient(getIt<FlutterSecureStorage>(), getIt<GoRouter>(), baseUrl: Options.baseUrl)); //==> Dio Client

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
  getIt.registerLazySingleton(() => RegisterUseCase(getIt<UserRepositoryImpl>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => RegisterBloc(getIt<RegisterUseCase>(), getIt<AuthUseCase>(), getIt<SharedPreferences>()));

  //==> Register Face <==//
  getIt.registerLazySingleton(() => RegisterFaceUseCase(getIt<UserRepositoryImpl>()));
  getIt.registerLazySingleton(() => RegisterFaceBloc(getIt<ML>(), getIt<RegisterFaceUseCase>()));

  /*******************************************************************/
  /*****************************  EVENTS *****************************/
  /*******************************************************************/
  getIt.registerLazySingleton(() => EventDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => EventRepositoryImpl(getIt<EventDataSource>()));
  getIt.registerLazySingleton(() => CreateEventUseCase(getIt<EventRepositoryImpl>(), getIt<SharedPreferences>()));
  

  //==> Create Event <==//
  getIt.registerLazySingleton(() => CreateEventBloc(getIt<SharedPreferences>(), getIt<CreateEventUseCase>()));

  //==> Create Dresscode <==//
  getIt.registerLazySingleton(() => EventDresscodeBloc(getIt<SharedPreferences>()));

  //==> Event Detail <==//
  getIt.registerLazySingleton(() => GetEventByIdUseCase(getIt<EventRepositoryImpl>()));
  getIt.registerFactory(() => EventDetailBloc(getIt<GetEventByIdUseCase>()));

  //==> Event Verify Face <==//
  getIt.registerLazySingleton(() => VerifyFaceDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => VerifyFaceRepositoryImpl(getIt<VerifyFaceDataSource>()));
  getIt.registerLazySingleton(() => VerifyFaceUseCase(getIt<VerifyFaceRepositoryImpl>()));
  getIt.registerFactory(() => VerifyFaceBloc(getIt<VerifyFaceUseCase>()));

  /*****************************************************************/
  /*****************************  HOME *****************************/
  /*****************************************************************/
  getIt.registerLazySingleton(() => HomeDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => HomeRepositoryImpl(getIt<HomeDataSource>()));
  getIt.registerLazySingleton(() => GetHomeEventsUseCase(getIt<HomeRepositoryImpl>()));
  getIt.registerLazySingleton(() => HomePageBloc(getIt<GetHomeEventsUseCase>()));
}
