import 'package:get_it/get_it.dart';

import '../features/settings/settings.dart';

final getIt = GetIt.instance;

Future<void> setupSingletons() async {
  print('Register singletons...');
  getIt.registerSingleton<SettingsService>(SettingsService());
}
