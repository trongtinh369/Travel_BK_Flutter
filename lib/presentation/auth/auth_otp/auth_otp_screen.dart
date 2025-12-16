import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/cubit/auth_otp_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/cubit/auth_otp_state.dart';
import 'package:booking_tour_flutter/presentation/auth/name_of_screen.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/otp_input.dart';
import 'package:booking_tour_flutter/presentation/widgets/wrapped_outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthOtpScreen extends StatelessWidget {
 
  final TextEditingController _controllerOTP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<AuthOtpCubit>();

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.scaffoldBackgroundColor),
        body: Center(child: wrappedOutside(context, columnOfWidget(_cubit))),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget(AuthOtpCubit _cubit) {
    return BlocListener<AuthOtpCubit, AuthOtpState>(
      listener: (BuildContext context, state) async {
        if (state.checkCreate) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteName.login,
            (route) => false,
          );
        } else if (state.verifyOtp) {
          await _cubit.createUser();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              NameOfScreen.otpAuthentication,
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
                    BlocBuilder<AuthOtpCubit, AuthOtpState>(
                      builder: (BuildContext context, state) {
                        return Text(
                          state.user.email,
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
}
