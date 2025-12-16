import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/login/cubit/login_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/login/cubit/login_state.dart';
import 'package:booking_tour_flutter/presentation/auth/name_of_screen.dart';
import 'package:booking_tour_flutter/presentation/auth/widgets/DimmableImageButton.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_toggle_input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/toggle_Input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/wrapped_outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _cubit = LoginCubit();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(child: wrappedOutside(context, columnOfWidget())),
          ),
        ),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget() {
    final context = AppNavigator.currentContext;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.login) {
          // đẩy dữ liệu user vào auth
          context.read<AuthCubit>().setUser(state.user);

          switch (state.user.roleId) {
            case 1:
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.mainAdminScreen,
                (route) => false,
              );
              return;
            case 2:
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.scheduleTourguide,
                (route) => false,
              );
              return;
            case 6:
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.tripList,
                (route) => false,
              );
              return;
            case 3:
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.main_user,
                (route) => false,
              );
              return;
            case 4:
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.accountant_home,
                (route) => false,
              );
              return;
            case 5:
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteName.lichTrinhChuaHoanThanh,
                (route) => false,
              );
              return;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('Email hoặc mật khẩu đã sai')),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              NameOfScreen.login,
              style: TextStyle(
                fontSize: AppFonts.fontSize32,
                fontFamily: AppFonts.fontFamily,
                fontWeight: AppFonts.fontWeight500,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 50),

            notToggleInputField(
              _controllerEmail,
              "Email",
              Colors.grey.shade100,
            ),

            const SizedBox(height: 12),

            ToggleInputField(
              controller: _controllerPassword,
              title: "Mật khẩu",
              color: Colors.grey.shade100,
              validator: (value) {},
            ),

            const SizedBox(height: 20),

            customButton(
              onPressed: () {
                if (_controllerEmail.text.trim().isNotEmpty &&
                    _controllerPassword.text.trim().isNotEmpty) {
                  _cubit.login(
                    _controllerEmail.text.trim(),
                    _controllerPassword.text.trim(),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text('Vui lòng nhập đầy đủ thông tin'),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              text: "Đăng nhập",
            ),

            const SizedBox(height: 10),

            iconLogin(),

            textDangKiQuenMatKhau(context),
          ],
        ),
      ),
    );
  }

  Widget textDangKiQuenMatKhau(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chưa có tài khoản? ",
              style: TextStyle(fontWeight: AppFonts.fontWeight700),
            ),
            InkWell(
              // qua màn Đăng ký
              onTap: () {
                Navigator.pushNamed(context, RouteName.register);
              },
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Đăng ký ngay",
                  style: TextStyle(
                    color: Color(0xFF0822AB),
                    fontWeight: AppFonts.fontWeight700,
                  ),
                ),
              ),
            ),
          ],
        ),

        InkWell(
          // qua màn quên mật khẩu
          onTap: () {
            Navigator.pushNamed(context, RouteName.forgetPassword);
          },
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              "Quên mật khẩu",
              style: TextStyle(
                color: Color(0xFF0822AB),
                fontWeight: AppFonts.fontWeight700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: DimmableImageButton(
            onTap: () {
              _cubit.loginWithGoogle();
            },

            imagePath: 'assets/images/logo_gg.png',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: DimmableImageButton(
            onTap: () {
              _cubit.loginWithFacebook();
            },
            imagePath: 'assets/images/logo_fb.png',
          ),
        ),
      ],
    );
  }
}
