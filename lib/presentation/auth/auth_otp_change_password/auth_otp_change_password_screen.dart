import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/cubit/auth_otp_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp_change_password/cubit/auth_otp_change_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp_change_password/cubit/auth_otp_change_password_state.dart';
import 'package:booking_tour_flutter/presentation/auth/change_password/cubit/change_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/name_of_screen.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/otp_input.dart';
import 'package:booking_tour_flutter/presentation/widgets/wrapped_outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthOtpChangePasswordScreen extends StatelessWidget {
  final TextEditingController _controllerOTP = TextEditingController();

  AuthOtpChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<AuthOtpChangePasswordCubit>();

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.scaffoldBackgroundColor),
        body: Center(child: wrappedOutside(context, columnOfWidget(_cubit))),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget(AuthOtpChangePasswordCubit _cubit) {
    return BlocListener<AuthOtpChangePasswordCubit, AuthOtpChangePasswordState>(
      listener: (context, state) {
        if(state.verifyOtp){
          final cubitChange = context.read<ChangePasswordCubit>();

          cubitChange.setEmail(state.email);

          Navigator.pushNamed(context, RouteName.changePassword);
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
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
      
            const SizedBox(height: 40),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mã xác thực sẽ được gửi đến",
                      style: AppFonts.text14.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<
                      AuthOtpChangePasswordCubit,
                      AuthOtpChangePasswordState
                    >(
                      builder: (context, state) {
                        return Text(
                          maskEmail(state.email),
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
      
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mã OTP",
                  style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(""),
              ],
            ),
      
            const SizedBox(height: 5),
      
            OtpInputWidget(
              controller: _controllerOTP,
              onCompleted: (pin) {
                _cubit.verifyOTP(pin);
              },
            ),
      
            const SizedBox(height: 20),
      
            customButton(
              onPressed: () {
                _cubit.sendOTP();
              },
              text: "Gửi lại mã",
              colorText: AppColors.white,
              colorButton: AppColors.button,
            ),
          ],
        ),
      ),
    );
  }

  String maskEmail(String email) {
    if(email.isEmpty){
      return "";
    }
    int atIndex = email.indexOf('@');

    String firstChar = email.substring(0, 1);
    String domain = email.substring(atIndex);

    int length = email.substring(1, atIndex).length;

    String start = "";
    for (int i = 0; i < length; ++i) {
      start += "*";
    }

    return firstChar + start + domain;
  }
}
