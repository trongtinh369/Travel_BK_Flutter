import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_font.dart';

class AppThemes {
  AppThemes._();

  // Theme đơn giản chỉ với color và font
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    // Colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundAppBarTheme,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppFonts.text32,
      displayMedium: AppFonts.text28,
      displaySmall: AppFonts.text24,
      headlineLarge: AppFonts.text20.copyWith(fontWeight: FontWeight.bold),
      headlineMedium: AppFonts.text18.copyWith(fontWeight: FontWeight.bold),
      headlineSmall: AppFonts.text16.copyWith(fontWeight: FontWeight.bold),
      titleLarge: AppFonts.text16,
      titleMedium: AppFonts.text14,
      titleSmall: AppFonts.text12,
      bodyLarge: AppFonts.text16,
      bodyMedium: AppFonts.text14,
      bodySmall: AppFonts.text12,
      labelLarge: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
      labelMedium: AppFonts.text12.copyWith(fontWeight: FontWeight.bold),
      labelSmall: AppFonts.text12.copyWith(fontWeight: FontWeight.bold),
    ),

    // Button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: AppFonts.text16.copyWith(color: AppColors.white),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.borderTextInputColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.borderTextInputColor),
      ),
      hintStyle: TextStyle(color: AppColors.lightGrey),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppFonts.text16,
      ),
    ),

    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColors.backgroundAppBarTheme,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.black,
      unselectedLabelColor: AppColors.black,
      labelStyle: AppFonts.text16.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: AppFonts.text16.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
