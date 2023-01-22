import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay_day/src/utils/color_const.dart';

ThemeData buildLightTheme(BuildContext context) {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: AppColors.primaryColor,
    unselectedWidgetColor: AppColors.black.withOpacity(0.2),
    focusColor: AppColors.primaryColor,
    errorColor: AppColors.complementaryColor,
    disabledColor: AppColors.black.withOpacity(0.3),
    shadowColor: AppColors.black.withOpacity(0.9),
    dividerColor: AppColors.black.withOpacity(0.5),

    appBarTheme: AppBarTheme(
      color: AppColors.white,
      foregroundColor: AppColors.black.withOpacity(0.2),
      shadowColor: AppColors.black.withOpacity(0.2),
      elevation: 1,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
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
        backgroundColor: AppColors.greenColor,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.black.withOpacity(0.5),
        side: BorderSide(color: AppColors.black.withOpacity(0.5), width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // <-- Radius
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      secondary: AppColors.black,
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
