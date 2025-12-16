import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/bank.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/vi/cubit/vi_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/vi/cubit/vi_state.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_icon_toggle_input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/textfield_not_tilte.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/generic_selected_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViScreen extends StatelessWidget {
  ViScreen({super.key});
  final _cubit = ViCubit();

  final TextEditingController branchController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().state.id;
    _cubit.syncUser(userId);
    _cubit.syncBank();

    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text("Ví", style: AppFonts.textWhite)),

        body: BlocBuilder<ViCubit, ViState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 20),
                _buidInformation(state.user),

                SizedBox(height: 15),
                // Padding(
                //   padding: EdgeInsets.only(left: 15, right: 15),
                //   child: Text(
                //     "Lưu ý: số tiền này của bạn sẽ được trừ vào lần sau nếu như bạn đặt và sẽ được giảm giá 5% số tiền của chuyến đi đó",
                //     style: TextStyle(color: Colors.blue),
                //   ),
                // ),

                _buildTextFeild(state, state.user, context, controller),

                SizedBox(height: 15),
                _buildButton(
                  branchController,
                  accountController,
                  state.user,
                  context,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNganHang(
    ViState state,
    ViCubit cubit,
    BuildContext context,
    Bank? selectedBank,
    ValueChanged<Bank?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<Bank>(
        decoration: InputDecoration(
          hintText: "Chọn ngân hàng",
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        value: selectedBank,
        items:
            state.bank.map((bank) {
              return DropdownMenuItem<Bank>(
                value: bank,
                child: Text(bank.name),
              );
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            cubit.selectBank(value);
          }
        },
      ),
    );
  }

  Widget _buildDialog(
    ViState state,
    ViCubit cubit,
    TextEditingController branchController,
    TextEditingController accountController,
    BuildContext context,
    List<Bank> danhSachNganHang,
    Bank? selectedBank,
    ValueChanged<Bank?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Điền thông tin tài khoản", style: AppFonts.text20),
          SizedBox(height: 10),
          _buildNganHang(state, cubit, context, selectedBank, onChanged),

          SizedBox(height: 10),
          notIconToggleInputField(
            branchController,
            "Chi nhánh ngân hàng",
            "Điền chi nhánh ngân hàng",
            AppColors.gray,
          ),
          SizedBox(height: 10),
          notIconToggleInputField(
            accountController,
            "Số tài khoản ngân hàng",
            "Điền số tài khoản ngân hàng",
            AppColors.gray,
          ),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Xác nhận
              DeleteButtonWidget(
                onDelete: () {
                  final currentBank = state.user.bank;
                  final bankName = selectedBank?.name ?? currentBank;

                  if (bankName.isNotEmpty &&
                      branchController.text.isNotEmpty &&
                      accountController.text.isNotEmpty) {
                    cubit.updateLocalField(
                      bankName: bankName,
                      bankBranch: branchController.text,
                      bankNumber: accountController.text,
                    );

                    // luu database
                    cubit.saveChangeUpdate();
                    Navigator.pop(context);
                  } else {
                    // Thông báo thiếu thông tin
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Vui lòng điền đủ thông tin ngân hàng"),
                      ),
                    );
                  }
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

  Widget _buildTextFeild(
    ViState state,
    User user,
    BuildContext context,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsetsGeometry.all(15),
      child: Column(
        children: [
          TextfieldNotTilte(
            label: "Số tiền còn dư",
            value: user.money.toString(),
          ),
          const SizedBox(height: 10),

          if (state.showBankFields == true) ...[
            TextfieldNotTilte(label: "Tên ngân hàng", value: user.bank),
            const SizedBox(height: 10),
            TextfieldNotTilte(
              label: "Chi nhánh ngân hàng",
              value: user.bankBranch,
            ),
            const SizedBox(height: 10),
            TextfieldNotTilte(
              label: "Số tài khoản ngân hàng",
              value: user.bankNumber,
            ),
          ],
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

  Widget _buildButton(
    TextEditingController branchController,
    TextEditingController accountController,
    User user,
    BuildContext context,
  ) {
    return DeleteButtonWidget(
      onDelete: () {
        if (user.money > 50000) {
          final cubit = context.read<ViCubit>();
          showDialog(
            context: context,
            builder: (dialogContext) {
              return BlocProvider.value(
                value: cubit,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  insetPadding: const EdgeInsets.all(20),
                  child: BlocBuilder<ViCubit, ViState>(
                    builder: (context, state) {
                      return _buildDialog(
                        cubit.state,
                        cubit,
                        branchController,
                        accountController,
                        dialogContext,
                        cubit.state.bank,
                        cubit.state.selectedBank,
                        (bank) => cubit.selectBank(bank!),
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Số tiền phải trên 50.000 VND")),
          );
        }
      },
      text: "Yêu cầu nhận lại tiền",
      textColor: Colors.white,
      backgroundColor: AppColors.button,
    );
  }
}
