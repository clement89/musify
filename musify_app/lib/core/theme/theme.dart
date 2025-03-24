import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musify_app/core/theme/colors.dart';
import 'package:musify_app/core/theme/custom_theme.dart';

class AppTheme {
  AppTheme._();

  static final light = ThemeData.light().copyWith(
    extensions: const [CustomTheme.light],
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      labelLarge: GoogleFonts.poppins(
        color: Colors.black, // Assuming button background is light
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
    scaffoldBackgroundColor: LightColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: LightColors.iconColor,
      ),
      color: Colors.transparent,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.poppins(
        color: Colors.grey[600], // Adjust the color as needed
      ),
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    extensions: const [CustomTheme.dark],
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      labelLarge: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    ),
    scaffoldBackgroundColor: DarkColors.scaffoldBackground,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: DarkColors.iconColor,
      ),
      color: Colors.transparent,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: GoogleFonts.poppins(
        color: Colors.grey[400], // Adjust the color for dark mode
      ),
    ),
  );

  static const double footerHeight = 0.155;
}
