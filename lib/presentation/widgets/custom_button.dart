import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';

import 'package:flutter/material.dart';

Widget customButton({
  required void Function() onPressed,
  required String text,
  Color colorButton = AppColors.button,
  Color colorText = Colors.white,
  double widthButton = double.infinity,
  double heightButton = 45.0,
  double radius = 30,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorButton,
      minimumSize: Size(widthButton, heightButton),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    ),

    onPressed: onPressed,

    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: AppFonts.fontFamily,
        fontWeight: AppFonts.fontWeight700,
        color: colorText,
      ),
    ),
  );
}
