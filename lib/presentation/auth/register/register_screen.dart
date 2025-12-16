import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/app/validate_helper.dart';
import 'package:booking_tour_flutter/data/request/create_user_request.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/auth_otp_screen.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_otp/cubit/auth_otp_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/name_of_screen.dart';
import 'package:booking_tour_flutter/presentation/auth/register/cubit/register_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/register/cubit/register_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_toggle_input_field_ic.dart';
import 'package:booking_tour_flutter/presentation/widgets/toggle_Input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/wrapped_outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class RegisterScreen extends StatelessWidget {
  final _cubit = RegisterCubit();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController controllerTenNguoiDung = TextEditingController();
  final TextEditingController controllerSoDienThoai = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerNhapLai = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(backgroundColor: AppColors.scaffoldBackgroundColor),
        body: SingleChildScrollView(
          child: Center(
            child: wrappedOutside(
              context,
              SingleChildScrollView(child: columnOfWidget()),
            ),
          ),
        ),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget() {
    final context = AppNavigator.currentContext;

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state.isEmailExist) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email đã có người sử dụng')),
          );
        } else if (state.checkSendOtp) {
          // tạo user đẩy sang màn tiếp theo
          var user = CreateUserRequest(
            roleId: 3,
            password: controllerPassword.text.trim(),
            money: 0,
            bankNumber: "",
            bank: "",
            name: controllerTenNguoiDung.text.trim(),
            email: controllerEmail.text.trim(),
            phone: controllerSoDienThoai.text.trim(),
            avatarPath: "",
            bankBranch: "",
            token: ""
          );

          final cubitOtp = context.read<AuthOtpCubit>();
          cubitOtp.setUser(user);

          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AuthOtpScreen()),
          );
        } else if (!state.isEmailExist) {
          // gửi mã otp
          var email = controllerEmail.text.trim();
          await _cubit.sendOTP(email);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NameOfScreen.register,
              style: TextStyle(
                fontSize: AppFonts.fontSize32,
                fontFamily: AppFonts.fontFamily,
                fontWeight: AppFonts.fontWeight500,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  notToggleInputFieldNotIcon(
                    controller: controllerTenNguoiDung,
                    title: "Tên người dùng",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên của bạn vào ô này';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  notToggleInputFieldNotIcon(
                    controller: controllerSoDienThoai,
                    title: "Số điện thoại",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'vui lòng nhập số điện thoại vào ô này';
                      } else if (!ValidateHelper.kiemTraSoDienThoai(value)) {
                        return "số điện thoại này chưa đúng định dạng";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  notToggleInputFieldNotIcon(
                    controller: controllerEmail,
                    title: "Email",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'vui lòng nhập email vào ô này';
                      } else if (!ValidateHelper.isEmailValid(value)) {
                        return "Email này chưa đúng định dạng";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  ToggleInputField(
                    controller: controllerPassword,
                    title: "Mật khẩu",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'vui lòng điền mật khẩu vào ô này';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  ToggleInputField(
                    controller: controllerNhapLai,
                    title: "Nhập lại mật khẩu",
                    color: Colors.grey.shade100,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'vui lòng điền lại mật khẩu vào ô này';
                      } else if (value != controllerPassword.text.trim()) {
                        return "Mật khẩu không khớp";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            const SizedBox(height: 30),

            customButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var result = await _cubit.checkEmailAccount(
                    controllerEmail.text.trim(),
                  );
                }
              },
              text: "Tiếp theo",
            ),

            const SizedBox(height: 20),

            textDangNhap(),
          ],
        ),
      ),
    );
  }

  Widget textDangNhap() {
    final context = AppNavigator.currentContext;

    return Column(
      children: [
        Text("Đã có tài khoản? "),
        GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteName.login,
              (route) => false,
            );
          },
          child: const Padding(
            // Nên dùng Padding để tạo khoảng đệm cho vùng click
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Đăng nhập ngay",
              style: TextStyle(
                color: Color(0xFF0822AB),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
