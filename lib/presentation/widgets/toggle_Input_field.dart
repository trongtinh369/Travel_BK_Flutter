import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class ToggleInputField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Color color;
  final String? Function(String? value)? validator;

  const ToggleInputField({
    super.key,
    required this.controller,
    required this.title,
    required this.color,
    required this.validator,
  });

  @override
  State<ToggleInputField> createState() => _ToggleInputFieldState();
}

class _ToggleInputFieldState extends State<ToggleInputField> {
  // Trạng thái để kiểm soát việc ẩn/hiện mật khẩu
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 8.0),

        TextFormField(
          validator: widget.validator,
          controller: widget.controller,

          // Điều khiển ẩn/hiện mật khẩu
          obscureText: _obscureText,

          decoration: InputDecoration(
            filled: true,
            fillColor: widget.color,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.borderTextInputColor,
              ),
            ),

            hintText: widget.title,

            // Biểu tượng con mắt có chức năng
            suffixIcon: IconButton(
              icon: Icon(
                // Thay đổi icon dựa trên trạng thái _obscureText
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),

              onPressed: () {
                // Đảo ngược trạng thái khi click
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
