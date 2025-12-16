import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/update_password/cubit/update_password_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/update_password/cubit/update_password_state.dart';
import 'package:booking_tour_flutter/presentation/user/update_password/update_password_card.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/dialog_noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart'; // Thêm dòng này để dùng getIt

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userId = context.read<AuthCubit>().state.id;

    return BlocProvider(
      create:
          (_) => UpdatePasswordCubit(getIt<BookingRepository>()), // Sửa tại đây
      child: Scaffold(
        appBar: AppBar(title: const Text("Đổi mật khẩu")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
            listener: (context, state) {
              if (state is UpdatePasswordSuccess) {
                DialogNoti.confirm(
                  context: context,
                  title: "Thành công",
                  message: "Đổi mật khẩu thành công",
                ).then((_) => Navigator.pop(context));
              }
              if (state is UpdatePasswordError) {
                DialogHelper.showInformDialog(Text(state.message));
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  UpdatePasswordCard(
                    onSubmit:
                        (data) => context
                            .read<UpdatePasswordCubit>()
                            .updatePassword(userId, data),
                  ),
                  if (state is UpdatePasswordLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
