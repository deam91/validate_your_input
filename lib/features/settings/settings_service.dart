import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SharedPreferences? _sharedPreferences;

  SettingsService() {
    _init();
  }

  _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<ThemeMode> themeMode() async {
    final theme = _sharedPreferences?.getString('theme');
    return theme == ThemeMode.dark.name.toString()
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    await _sharedPreferences?.setString('theme', theme.name);
  }
}
