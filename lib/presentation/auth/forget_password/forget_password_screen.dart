import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/app/validate_helper.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp_change_password/cubit/auth_otp_change_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/forget_password/cubit/forget_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/forget_password/cubit/forget_state.dart';
import 'package:booking_tour_flutter/presentation/auth/name_of_screen.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_toggle_input_field_ic.dart';
import 'package:booking_tour_flutter/presentation/widgets/wrapped_outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _cubit = ForgetCubit();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.scaffoldBackgroundColor),
        body: SingleChildScrollView(
          child: Center(child: wrappedOutside(context, columnOfWidget())),
        ),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget() {
    final context = AppNavigator.currentContext;

    return BlocListener<ForgetCubit, ForgetState>(
      listener: (context, state) {
        if (state.existedEmail) {
          final cubitOtp = context.read<AuthOtpChangePasswordCubit>();

          cubitOtp.setEmail(state.email);

          _cubit.sendOTP();

          Navigator.pushNamed(context, RouteName.authOtpChangePassword);
        } else if (!state.existedEmail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('Email này không tồn tại')),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              NameOfScreen.forgetPassword,
              style: TextStyle(
                fontSize: AppFonts.fontSize32,
                fontFamily: AppFonts.fontFamily,
                fontWeight: AppFonts.fontWeight500,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 50),

            Form(
              key: _formKey,
              child: notToggleInputFieldNotIcon(
                controller: _controllerEmail,
                title: "Email",
                color: Colors.grey.shade100,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'vui lòng điền email vao ô này';
                  }
                  else if(!ValidateHelper.isEmailValid(value)){
                    return "Email này chưa đúng định dạng";
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 30),

            customButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _cubit.checkEmail(_controllerEmail.text.trim());
                }
              },
              text: "Tiếp tục",
            ),
          ],
        ),
      ),
    );
  }
}
