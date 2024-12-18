import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/notification/data/data_source/invitation_data_source.dart';
import 'package:mesran_app/src/features/notification/data/data_source/notification_data_source.dart';
import 'package:mesran_app/src/features/notification/data/repository/invitation_repository_impl.dart';
import 'package:mesran_app/src/features/notification/data/repository/notification_repository_impl.dart';
import 'package:mesran_app/src/features/notification/domain/use_case/get_notification_use_case.dart';
import 'package:mesran_app/src/features/notification/domain/use_case/accept_invitation_use_case.dart';
import 'package:mesran_app/src/features/notification/domain/use_case/decline_invitation_use_case.dart';
import 'package:mesran_app/src/features/notification/presentation/bloc/notification_bloc.dart';

Future<void> notificationInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => NotificationDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => InvitationDataSource(getIt<DioClient>()));

  /// Repositories
  getIt.registerLazySingleton(() => NotificationRepositoryImpl(getIt<NotificationDataSource>()));
  getIt.registerLazySingleton(() => InvitationRepositoryImpl(getIt<InvitationDataSource>()));

  /// Use Cases
  getIt.registerLazySingleton(() => GetNotificationUseCase(getIt<NotificationRepositoryImpl>()));
  getIt.registerLazySingleton(() => AcceptInvitationUseCase(getIt<InvitationRepositoryImpl>()));
  getIt.registerLazySingleton(() => DeclineInvitationUseCase(getIt<InvitationRepositoryImpl>()));

  /// Blocs
  getIt.registerFactory(() => NotificationBloc(
    getIt<GetNotificationUseCase>(),
    getIt<AcceptInvitationUseCase>(),
    getIt<DeclineInvitationUseCase>(),
  ));
}
