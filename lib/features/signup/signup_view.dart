import 'package:flutter/material.dart';
import 'package:validate_your_input/features/signup/custom_form.dart';

import '../settings/settings_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key, required this.controller}) : super(key: key);
  final SettingsController controller;

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 15,
            onPressed: () {
              final theme = controller.themeMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              controller.updateThemeMode(theme);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 650),
              child: controller.themeMode == ThemeMode.dark
                  ? Icon(
                      key: ValueKey('darkKey'),
                      Icons.wb_sunny_rounded,
                      size: 25,
                      color: Colors.white,
                    )
                  : Icon(
                      key: ValueKey('lightKey'),
                      Icons.brightness_3,
                      size: 25,
                      color: Colors.black,
                    ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  child: CustomForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
