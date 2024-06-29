import 'package:flutter/material.dart';
import 'package:flutter_todo/config/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  AppThemes._();

  static ThemeData theme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primary,
    focusColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.secondary,
    textTheme: GoogleFonts.latoTextTheme(),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
  );
}
