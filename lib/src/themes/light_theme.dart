import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay_day/src/utils/color_const.dart';

ThemeData buildLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColors.primaryColor,
    unselectedWidgetColor: AppColors.black.withOpacity(0.4),
    focusColor: AppColors.primaryColor,
    errorColor: AppColors.complementaryColor,
    disabledColor: AppColors.black.withOpacity(0.3),
    shadowColor: AppColors.black.withOpacity(0.9),
    dividerColor: AppColors.white,
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      foregroundColor: AppColors.black.withOpacity(0.2),
      shadowColor: AppColors.black.withOpacity(0.2),
      elevation: 1,
    ),
    // buttonTheme: ButtonThemeData(
    //   buttonColor: Colors.yellow,
    //   textTheme: ButtonTextTheme.primary, //  <-- dark text for light background
    // ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.black.withOpacity(0.2),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.black.withOpacity(0.2),
      ),
    ),
    colorScheme: const ColorScheme.light(
      // secondary: AppColors.secondaryColor,
      onSecondary: Colors.white,
      // onTertiary: Colors.black,
      tertiary: AppColors.complementaryColor,
      onTertiaryContainer: AppColors.greenColor,
      // outline: AppColors.complementaryColor,
    ),
    textTheme: _buildLightTextTheme(base.textTheme),
    scaffoldBackgroundColor: AppColors.white,
  );
}

TextTheme _buildLightTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 44,
      color: AppColors.black.withOpacity(0.5),
    ),
    headline2: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 32,
      color: AppColors.black.withOpacity(0.5),
    ),
    headline4: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 24,
      color: AppColors.black.withOpacity(0.5),
    ),
    headline5: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 22,
      color: AppColors.black.withOpacity(0.5),
    ),
    headline6: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 20,
      color: AppColors.black.withOpacity(0.5),
    ),
    bodyText1: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: AppColors.black.withOpacity(0.5),
    ),
    bodyText2: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: AppColors.black.withOpacity(0.5),
    ),
    subtitle2: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 12,
      color: AppColors.black.withOpacity(0.5),
    ),
    caption: GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: AppColors.black.withOpacity(0.5),
    ),
  );
}
