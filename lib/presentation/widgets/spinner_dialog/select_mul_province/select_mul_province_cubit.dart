import 'package:booking_tour_flutter/app/booking_dialog.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_mul_province/select_mul_province_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectMulProvinceCubit extends Cubit<SelectMulProvinceState> {
  SelectMulProvinceCubit() : super(SelectMulProvinceState(provinces: []));

  Future<void> chooseProvinces() async {
    var newProvinces = await BookingDialog.selectMultiProvince(
      initProvinces: state.provinces,
    );
    if (newProvinces == null) return;

    emit(state.copyWith(provinces: newProvinces));
  }

  void loadProvinces(List<Province> provinces) {
    emit(state.copyWith(provinces: provinces));
  }
}
