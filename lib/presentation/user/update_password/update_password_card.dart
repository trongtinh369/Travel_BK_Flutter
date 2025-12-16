import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/domain/update_password_user.dart';
import 'package:flutter/material.dart';

class UpdatePasswordCard extends StatefulWidget {
  final Function(UpdatePasswordUser) onSubmit;
  const UpdatePasswordCard({super.key, required this.onSubmit});

  @override
  State<UpdatePasswordCard> createState() => _UpdatePasswordCardState();
}

class _UpdatePasswordCardState extends State<UpdatePasswordCard> {
  final oldCtrl = TextEditingController();
  final newCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  bool oldObscure = true;
  bool newObscure = true;
  bool confirmObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mật khẩu cũ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _input(
          oldCtrl,
          oldObscure,
          () => setState(() => oldObscure = !oldObscure),
          "Điền mật khẩu cũ của bạn",
        ),
        const SizedBox(height: 16),

        const Text(
          "Mật khẩu mới",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _input(
          newCtrl,
          newObscure,
          () => setState(() => newObscure = !newObscure),
          "Nhập mật khẩu mới",
        ),
        const SizedBox(height: 16),

        const Text(
          "Nhập lại mật khẩu mới",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _input(
          confirmCtrl,
          confirmObscure,
          () => setState(() => confirmObscure = !confirmObscure),
          "Nhập lại mật khẩu mới",
        ),

        const SizedBox(height: 32),
        Center(
          child: ElevatedButton(
            onPressed: () {
              if (newCtrl.text.trim() != confirmCtrl.text.trim()) {
                DialogHelper.showInformDialog(
                  const Text("Mật khẩu xác nhận không khớp"),
                );
                return;
              }

              widget.onSubmit(
                UpdatePasswordUser(
                  oldPassword: oldCtrl.text.trim(),
                  newPassword: newCtrl.text.trim(),
                ),
              );
            },
            child: const Text("Xác nhận"),
          ),
        ),
      ],
    );
  }

  Widget _input(
    TextEditingController controller,
    bool obscure,
    VoidCallback toggle,
    String hint,
  ) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
