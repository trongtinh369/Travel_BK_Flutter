import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp_change_password/cubit/auth_otp_change_password_state.dart';
import 'package:booking_tour_flutter/presentation/auth/change_password/cubit/change_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/change_password/cubit/change_password_sate.dart';
import 'package:booking_tour_flutter/presentation/auth/name_of_screen.dart';
import 'package:booking_tour_flutter/presentation/widgets/toggle_Input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/wrapped_outside.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerFirstPassword =
      TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<ChangePasswordCubit>();

    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.scaffoldBackgroundColor),
        body: SingleChildScrollView(
          child: Center(child: wrappedOutside(context, columnOfWidget(_cubit))),
        ),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget(ChangePasswordCubit _cubit) {
    final context = AppNavigator.currentContext;

    return BlocListener<ChangePasswordCubit, ChangePasswordSate>(
      listener: (context, state) {
        if(state.changeDone){
          Navigator.pushNamed(context, RouteName.login);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NameOfScreen.changePassword,
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
              child: Column(
                children: [
                  ToggleInputField(
                    controller: _controllerFirstPassword,
                    title: "Mật khẩu mới",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "vui lòng điền mật khẩu mới vào ô này";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ToggleInputField(
                    controller: _controllerPassword,
                    title: "Mật khẩu",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return "vui lòng điền lại mật khẩu mới vào ô này";
                      }
                      else if(value != _controllerFirstPassword.text.trim()){
                        return "Mật khẩu không trùng";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
      
            const SizedBox(height: 50),
      
            customButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _cubit.changePassword(_controllerPassword.text.trim());
                }
              },
              text: "Xác nhận",
            ),
          ],
        ),
      ),
    );
  }
}
