import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/gen/colors.gen.dart';
import '../../common/locator.dart';
import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController();

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadSettings() async {
    _themeMode = await getIt<SettingsService>().themeMode();
    print('loadSettings - $_themeMode');
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: ColorName.white,
      backgroundColor: ColorName.black,
      shadowColor: ColorName.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: ColorName.white,
          onPrimary: ColorName.black,
          shadowColor: ColorName.white,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(color: ColorName.gray03),
        labelStyle: TextStyle(color: ColorName.white),
        errorStyle: TextStyle(
          color: Color(0xffEB5757),
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.visible,
        ),
        fillColor: ColorName.gray01,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorName.gray02),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorName.gray01),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorName.gray04),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorName.gray04),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEB5757)),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEB5757)),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      fontFamily: 'Inter',
      textTheme: TextTheme(
        headline1: GoogleFonts.inter(color: ColorName.black),
        headline2: GoogleFonts.inter(color: ColorName.black),
        bodyText1: GoogleFonts.inter(color: ColorName.black),
        bodyText2: GoogleFonts.inter(color: ColorName.black),
        button: GoogleFonts.inter(color: ColorName.black),
        caption: GoogleFonts.inter(color: ColorName.gray03),
        subtitle1: GoogleFonts.inter(color: ColorName.black),
        subtitle2: GoogleFonts.inter(color: ColorName.gray04),
      ),
      buttonTheme: ButtonThemeData(
        splashColor: ColorName.primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: ColorName.primary,
        colorScheme: ColorScheme.dark(
          onSurface: const Color(0xff4C5155),
          surface: const Color(0xff818C99).withOpacity(.12),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        scaffoldBackgroundColor: ColorName.black,
        backgroundColor: ColorName.white,
        shadowColor: ColorName.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: ColorName.white,
            onPrimary: ColorName.black,
            shadowColor: ColorName.white,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          hintStyle: TextStyle(color: ColorName.gray03),
          labelStyle: TextStyle(color: ColorName.white),
          errorStyle: TextStyle(
            color: Color(0xffEB5757),
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.visible,
          ),
          fillColor: ColorName.secondaryBlack,
          enabledBorder: OutlineInputBorder(
            gapPadding: 12.0,
            borderSide: BorderSide(color: ColorName.gray04),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          border: OutlineInputBorder(
            gapPadding: 12.0,
            borderSide: BorderSide(color: ColorName.gray04),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          disabledBorder: OutlineInputBorder(
            gapPadding: 12.0,
            borderSide: BorderSide(color: ColorName.gray04),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 12.0,
            borderSide: BorderSide(color: ColorName.gray02),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            gapPadding: 12.0,
            borderSide: BorderSide(color: Color(0xffEB5757)),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          filled: true,
          errorBorder: OutlineInputBorder(
            gapPadding: 12.0,
            borderSide: BorderSide(color: Color(0xffEB5757)),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        fontFamily: 'Inter',
        textTheme: TextTheme(
          headline1: GoogleFonts.inter(color: ColorName.white),
          headline2: GoogleFonts.inter(color: ColorName.white),
          bodyText1: GoogleFonts.inter(color: ColorName.white),
          bodyText2: GoogleFonts.inter(color: ColorName.white),
          button: GoogleFonts.inter(color: ColorName.white),
          caption: GoogleFonts.inter(color: ColorName.gray01),
          subtitle1: GoogleFonts.inter(color: ColorName.white),
          subtitle2: GoogleFonts.inter(color: ColorName.gray02),
        ),
        buttonTheme: ButtonThemeData(
          splashColor: ColorName.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: ColorName.primary,
          colorScheme: ColorScheme.dark(
            onSurface: const Color(0xff4C5155),
            surface: const Color(0xff818C99).withOpacity(.12),
          ),
        ),
        radioTheme: RadioThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fillColor:
              MaterialStateColor.resolveWith((states) => ColorName.primary),
          overlayColor: MaterialStateColor.resolveWith(
              (states) => ColorName.primary.withOpacity(.3)),
        ));
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    await getIt<SettingsService>().updateThemeMode(newThemeMode);
    notifyListeners();
  }
}
