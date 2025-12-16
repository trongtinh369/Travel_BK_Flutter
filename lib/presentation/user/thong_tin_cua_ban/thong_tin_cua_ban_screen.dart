import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/thong_tin_cua_ban/cubit/thong_tin_cua_ban_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/thong_tin_cua_ban/cubit/thong_tin_cua_ban_state.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_icon_toggle_input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/textfield_not_tilte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThongTinCuaBanScreen extends StatelessWidget {
  final _cubit = ThongTinCuaBanCubit();
  final TextEditingController controller = TextEditingController();
  ThongTinCuaBanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().state.id;
    _cubit.syncUser(userId);

    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông tin của bạn", style: AppFonts.textWhite),
        ),
        body: BlocConsumer<ThongTinCuaBanCubit, ThongTinCuaBanState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<ThongTinCuaBanCubit>();
            return Column(
              children: [
                SizedBox(height: 20),
                _buidInformation(state.user),

                SizedBox(height: 20),
                _buildTextFeild(cubit, state.user, context),

                SizedBox(height: 50),
                _buildButton(cubit, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDialog(
    ThongTinCuaBanCubit cubit,
    BuildContext context,
    String label,
    String value,
    TextEditingController controller,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cập nhật", style: AppFonts.text16),

          SizedBox(height: 10),
          notIconToggleInputField(controller, label, value, AppColors.gray),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Xác nhận
              DeleteButtonWidget(
                onDelete: () {
                  cubit.updateLocalFeild(label, controller.text);
                  Navigator.pop(context);
                },
                text: "Xác nhận",
                textColor: Colors.white,
                backgroundColor: AppColors.borderButton,
              ),
              SizedBox(width: 10),
              //huỷ
              DeleteButtonWidget(
                onDelete: () {
                  Navigator.pop(context);
                },
                text: "Huỷ",
                textColor: Colors.white,
                backgroundColor: AppColors.delete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buidInformation(User user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              user.avatarPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.black);
              },
            ),
          ),
        ),

        Text(user.name, style: AppFonts.text18),
        Text(user.email, style: AppFonts.text14),
      ],
    );
  }

  Widget _buildTextFeild(
    ThongTinCuaBanCubit cubit,
    User user,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextfieldNotTilte(
            label: "Tên",
            value: user.name,
            icon: Icons.edit,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final controller = TextEditingController(text: user.name);
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(20),
                    child: _buildDialog(
                      cubit,
                      context,
                      "Tên",
                      user.name,
                      controller,
                    ),
                  );
                },
              );
            },
          ),

          SizedBox(height: 10),
          TextfieldNotTilte(
            label: "SDT",
            value: user.phone,
            icon: Icons.edit,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final controller = TextEditingController(text: user.phone);
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(20),
                    child: _buildDialog(
                      cubit,
                      context,
                      "SDT",
                      user.phone,
                      controller,
                    ),
                  );
                },
              );
            },
          ),

          SizedBox(height: 10),
          TextfieldNotTilte(
            label: "Email",
            value: user.email,
            icon: Icons.edit,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final controller = TextEditingController(text: user.email);
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(20),
                    child: _buildDialog(
                      cubit,
                      context,
                      "Email",
                      user.email,
                      controller,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(ThongTinCuaBanCubit cubit, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DeleteButtonWidget(
          onDelete: () {
            Navigator.pushNamed(context, RouteName.update_password_user);
          },
          text: "Đổi mật khẩu",
          textColor: Colors.white,
          backgroundColor: AppColors.button,
        ),

        SizedBox(width: 10),
        DeleteButtonWidget(
          onDelete: () {
            cubit.saveChangeUpdate();

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Center(child: Text("Cập nhật thành công"))));
          },
          text: "Xác nhận",
          textColor: Colors.white,
          backgroundColor: AppColors.button,
        ),
      ],
    );
  }
}
