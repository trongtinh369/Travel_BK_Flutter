import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget notToggleInputFieldNotIcon({
  required TextEditingController controller,
  required String title,
  required Color color,
  required String? Function(String? value)? validator,
  bool isDigitOnly = false,
  ValueChanged<String>? onChange,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

      const SizedBox(height: 8.0),

      TextFormField(
        validator: (value) => validator?.call(value?.trim()),
        controller: controller,
        onChanged: onChange,
        inputFormatters:
            isDigitOnly ? [FilteringTextInputFormatter.digitsOnly] : null,

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
        ),
      ),
    ],
  );
}
