import 'package:flutter/material.dart';

import 'common/locator.dart';
import 'features/app.dart';
import 'features/settings/settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSingletons();
  final settingsController = SettingsController();
  await settingsController.loadSettings();
  runApp(MyChallengeApp(settingsController: settingsController));
}
