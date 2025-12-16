import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onCompleted;
  final int length;

  const OtpInputWidget({
    super.key,
    required this.controller,
    required this.onCompleted,
    this.length = 6,
  });

  @override
  Widget build(BuildContext context) {
    // Theme lúc bình thường
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray),
      ),
    );

    return Pinput(
      controller: controller,
      length: length,
      defaultPinTheme: defaultPinTheme,
      // theme khi focus coppy lại nhưng sửa decoration
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.button, width: 2),
        ),
      ),
      // theme sau khi nhập xong
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFF229784)),
          color: Colors.grey.shade50,
        ),
      ),
      onCompleted: onCompleted,
      enableInteractiveSelection: true,
      separatorBuilder: (index) => const SizedBox(width: 8),
    );
  }
}
