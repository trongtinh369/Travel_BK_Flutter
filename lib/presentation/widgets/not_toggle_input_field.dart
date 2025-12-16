import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

Widget notToggleInputField(
  TextEditingController controller,
  String title,
  Color color,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

      const SizedBox(height: 8.0),

      TextField(
        controller: controller,

        decoration: InputDecoration(
          filled: true,
          fillColor: color,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.borderTextInputColor),
          ),

          hintText: title,

          //  Biểu tượng người dùng
          suffixIcon: const Icon(Icons.person_outline, color: Colors.grey),
        ),
      ),
    ],
  );
}
