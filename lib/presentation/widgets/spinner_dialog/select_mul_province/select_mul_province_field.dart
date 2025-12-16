import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_mul_province/select_mul_province_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_mul_province/select_mul_province_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/spinner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectMulProvinceField extends StatelessWidget {
  final void Function(List<Province> provinces) onChange;
  final _cubit = SelectMulProvinceCubit();
  final bool isDisable;
  final bool isShowError;
  final String? errorMessage;

  SelectMulProvinceField({
    super.key,
    required this.onChange,
    List<Province> provinces = const [],
    this.isDisable = false,
    this.isShowError = false,
    this.errorMessage,
  }) {
    _cubit.loadProvinces(provinces);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectMulProvinceCubit, SelectMulProvinceState>(
      bloc: _cubit,
      listener: (context, state) {
        onChange(state.provinces);
      },
      builder: (context, state) {
        return SpinnerDialog(
          title: "Tỉnh thành",
          hint: "Chọn tỉnh thành",
          onTap: () {
            _cubit.chooseProvinces();
          },
          content: state.provinces.map((i) => i.name).join(", "),
          isDisable: isDisable,
          isShowError: isShowError,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
