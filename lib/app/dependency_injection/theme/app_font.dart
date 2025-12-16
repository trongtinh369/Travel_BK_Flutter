import 'package:flutter/cupertino.dart';
import 'app_color.dart';

class AppFonts {
  AppFonts._();
  
  static String fontFamily = "Roboto";
  
  // Font sizes phù hợp với mobile
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  
  // Font weights
  static const FontWeight fontWeight400 = FontWeight.w400;
  static const FontWeight fontWeight500 = FontWeight.w500;
  static const FontWeight fontWeight600 = FontWeight.w600;
  static const FontWeight fontWeight700 = FontWeight.w700;
  
  // Text styles cơ bản
  static TextStyle text12 = TextStyle(
    fontSize: fontSize12,
    fontFamily: fontFamily,
    fontWeight: fontWeight400,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text14 = TextStyle(
    fontSize: fontSize14,
    fontFamily: fontFamily,
    fontWeight: fontWeight400,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text16 = TextStyle(
    fontSize: fontSize16,
    fontFamily: fontFamily,
    fontWeight: fontWeight400,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text18 = TextStyle(
    fontSize: fontSize18,
    fontFamily: fontFamily,
    fontWeight: fontWeight500,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text20 = TextStyle(
    fontSize: fontSize20,
    fontFamily: fontFamily,
    fontWeight: fontWeight600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text24 = TextStyle(
    fontSize: fontSize24,
    fontFamily: fontFamily,
    fontWeight: fontWeight600,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text28 = TextStyle(
    fontSize: fontSize28,
    fontFamily: fontFamily,
    fontWeight: fontWeight700,
    color: AppColors.textPrimary,
  );
  
  static TextStyle text32 = TextStyle(
    fontSize: fontSize32,
    fontFamily: fontFamily,
    fontWeight: fontWeight700,
    color: AppColors.textPrimary,
  );

  static TextStyle textWhite = TextStyle(
    fontSize: fontSize24,
    fontFamily: fontFamily,
    fontWeight: fontWeight600,
    color: AppColors.white,
  );
  
}
