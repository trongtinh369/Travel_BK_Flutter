import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/sua_dia_danh/cubit/sua_dia_danh_state.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/them_dia_danh/cubit/them_dia_danh_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_icon_toggle_input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/generic_selected_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemDiaDanhScreen extends StatelessWidget {
  const ThemDiaDanhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemDiaDanhCubit(),
      child: BlocConsumer<ThemDiaDanhCubit, SuaDiaDanhState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<ThemDiaDanhCubit>();

          return Scaffold(
            appBar: AppBar(
              title: Text(style: AppFonts.textWhite, "Thêm Địa Danh"),
            ),
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.gray),
                  ),
                  child: Column(
                    children: [
                      _buildTinhThanh(
                        context,
                        cubit,
                        state.provinces,
                        state.province,
                      ),
                      _buildTenDiaDanh(cubit, cubit.nameController),
                    ],
                  ),
                ),

                const Spacer(),

                DeleteButtonWidget(
                  onDelete: () async {
                    cubit.setName(cubit.nameController.text);
                    await cubit.createPlace(context);
                  },
                  text: "Lưu",
                  textColor: Colors.white,
                  backgroundColor: AppColors.button,
                ),
                SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTinhThanh(
    BuildContext context,
    ThemDiaDanhCubit cubit,
    List<Province> provinces,
    Province? selectedProvince,
  ) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () async {
          final Province? result = await showDialog<Province>(
            context: context,
            builder:
                (_) => SelectionDialog<Province>(
                  title: "Chọn Tỉnh",
                  items: provinces,
                  display: (p) => p.name,
                  isMultiSelect: false,
                  preSelectedItems:
                      selectedProvince != null ? [selectedProvince] : [],
                ),
          );

          if (result != null) {
            cubit.setProvince(result); // cập nhật state cubit
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.secondary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedProvince?.name ?? "Chọn tỉnh",
                style: AppFonts.text16,
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenDiaDanh(ThemDiaDanhCubit cubit, TextEditingController name) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: notIconToggleInputField(
        name,
        onChanged: cubit.setName,
        "Tên địa danh",
        "Tên địa danh",
        AppColors.gray,
      ),
    );
  }
}
