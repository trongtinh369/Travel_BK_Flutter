import 'package:flutter/material.dart';

Widget wrappedOutside(BuildContext context, Widget column) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return Container(
    height: screenHeight * 0.80,
    width: screenWidth * 0.90, // Chiều rộng 90% màn hình

    margin: const EdgeInsets.all(16.0),
    padding: const EdgeInsets.all(20.0),

    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),

      boxShadow: [
        BoxShadow(
          color: Colors.grey.withAlpha(150),
          spreadRadius: 5,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),

    child: column,
  );
}
