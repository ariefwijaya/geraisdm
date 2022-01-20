import 'package:geraisdm/config/routes/routes_config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../routes/routes.gr.dart';

import 'injectable_core.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future configureDependencies() async {
  await $initGetIt(getIt);
  getIt.registerSingleton<AppRouter>(
      AppRouter(authGuard: getIt.get<AuthGuard>()));
}
