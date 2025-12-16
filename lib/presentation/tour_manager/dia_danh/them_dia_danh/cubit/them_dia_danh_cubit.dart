import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/danh_sach_dia_danh/cubit/dia_danh_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/sua_dia_danh/cubit/sua_dia_danh_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';

class ThemDiaDanhCubit extends Cubit<SuaDiaDanhState> {
  final bookingRepository = getIt<BookingRepository>();
  final TextEditingController nameController = TextEditingController();
  

  ThemDiaDanhCubit({Place? place})
    : super(SuaDiaDanhState(name: "", province: null, provinces: [])) {
    loadProvinces();
  }

  // load danh sach tinh
  Future<void> loadProvinces() async {
    final result = await bookingRepository.getProvinces();
    result.fold(
      (failure) {
        emit(state.copyWith(error: failure.message));
      },
      (provinces) {
        emit(state.copyWith(provinces: provinces));
      },
    );
  }

  void setName(String name) {
    emit(state.copyWith(name: name));
  }
  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }

  void setProvince(Province province) {
    emit(state.copyWith(province: province));
  }

  Future<void> createPlace(BuildContext context) async {
    final trimmedName = (state.name ?? '').trim();
    if (trimmedName.isEmpty) {
      emit(state.copyWith(error: "Vui lòng nhập tên địa danh"));
      return;
    }

    if (state.province == null) {
      emit(state.copyWith(error: "Vui lòng chọn tỉnh thành"));
      return;
    }

    final tmp = Place(id: -DateTime.now().millisecondsSinceEpoch, name: trimmedName, province: state.province!);  
    Navigator.pop(context, tmp);
  }
}
