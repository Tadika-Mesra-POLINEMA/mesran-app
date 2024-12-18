import 'package:get_it/get_it.dart';
import 'package:mesran_app/src/config/injectors/auth.injector.dart';
import 'package:mesran_app/src/config/injectors/event.injector.dart';
import 'package:mesran_app/src/config/injectors/history.injector.dart';
import 'package:mesran_app/src/config/injectors/home.injector.dart';
import 'package:mesran_app/src/config/injectors/main.injector.dart';
import 'package:mesran_app/src/config/injectors/notification.injector.dart';
import 'package:mesran_app/src/config/injectors/profile.injector.dart';
import 'package:mesran_app/src/config/injectors/user.injector.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  await mainInjectorInit(getIt);
  await authInjectorInit(getIt);
  await userInjectorInit(getIt);
  await eventInjectorInit(getIt);
  await homeInjectorInit(getIt);
  await historyInjectorInit(getIt);
  await notificationInjectorInit(getIt);
  await profileInjectorInit(getIt);
}
