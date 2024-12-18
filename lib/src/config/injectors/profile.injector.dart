import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/features/profiles/data/data_source/account_data_source.dart';
import 'package:mesran_app/src/features/profiles/data/data_source/invitation_data_source.dart';
import 'package:mesran_app/src/features/profiles/data/data_source/private_data_source.dart';
import 'package:mesran_app/src/features/profiles/data/data_source/profile_data_source.dart';
import 'package:mesran_app/src/features/profiles/data/repository/account_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/data/repository/invitation_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/data/repository/private_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/data/repository/profile_repository_impl.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/get_invitation_use_case.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/get_invitations_use_case.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/get_profile_use_case.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/update_account_use_case.dart';
import 'package:mesran_app/src/features/profiles/domain/use_case/update_private_use_case.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/account_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/invitation_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/private_bloc.dart';
import 'package:mesran_app/src/features/profiles/presentation/bloc/profile_bloc.dart';

Future<void> profileInjectorInit(GetIt getIt) async {
  /// Data Sources
  getIt.registerLazySingleton(() => ProfileDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => InvitationDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => AccountDataSource(getIt<DioClient>()));
  getIt.registerLazySingleton(() => PrivateDataSource(getIt<DioClient>()));

  /// Repositories
  getIt.registerLazySingleton(() => ProfileRepositoryImpl(getIt<ProfileDataSource>()));
  getIt.registerLazySingleton(() => InvitationRepositoryImpl(getIt<InvitationDataSource>()));
  getIt.registerLazySingleton(() => AccountRepositoryImpl(getIt<AccountDataSource>()));
  getIt.registerLazySingleton(() => PrivateRepositoryImpl(getIt<PrivateDataSource>()));

  /// Use Cases
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt<ProfileRepositoryImpl>()));
  getIt.registerLazySingleton(() => GetInvitationUseCase(getIt<InvitationRepositoryImpl>()));
  getIt.registerLazySingleton(() => GetInvitationsUseCase(getIt<InvitationRepositoryImpl>()));
  getIt.registerLazySingleton(() => UpdateAccountUseCase(getIt<AccountRepositoryImpl>()));
  getIt.registerLazySingleton(() => UpdatePrivateUseCase(getIt<PrivateRepositoryImpl>()));

  /// Blocs
  getIt.registerFactory(() => ProfileBloc(getIt<GetProfileUseCase>()));
  getIt.registerFactory(() => InvitationBloc(getIt<GetInvitationUseCase>(),getIt<GetInvitationsUseCase>()));
  getIt.registerFactory(() => AccountBloc(getIt<UpdateAccountUseCase>()));
  getIt.registerFactory(() => PrivateBloc(getIt<UpdatePrivateUseCase>()));
}