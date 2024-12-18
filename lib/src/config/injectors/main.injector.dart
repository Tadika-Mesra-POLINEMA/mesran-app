import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mesran_app/src/config/routes/routes.dart';
import 'package:mesran_app/src/core/api/dio_client.dart';
import 'package:mesran_app/src/core/api/ml_client.dart';
import 'package:mesran_app/src/core/utils/options.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Main injector initialization
Future<void> mainInjectorInit(GetIt getIt) async {
  /// Register main dependencies here

  /// Shared preference instance
  final sharedPreference = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreference);

  /// Machine learning client
  getIt.registerLazySingleton(() => ML(baseUrl: Options.mlBaseUrl));

  /// Go router instance
  getIt.registerLazySingleton(() => GoRouter(routes: Routes().getRoutes()));

  /// Flutter secure storage instance
  getIt.registerLazySingleton(() => FlutterSecureStorage());

  /// Dio client instance
  getIt.registerLazySingleton(() => DioClient(
      getIt<FlutterSecureStorage>(), getIt<GoRouter>(),
      baseUrl: Options.baseUrl));
}
