import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/danh_sach_dia_danh/cubit/dia_danh_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/sua_dia_danh/cubit/sua_dia_danh_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';

class SuaDiaDanhCubit extends Cubit<SuaDiaDanhState> {
  final bookingRepository = getIt<BookingRepository>();
  final TextEditingController nameController;

  SuaDiaDanhCubit({Place? place})
    : nameController = TextEditingController(text: place?.name ?? ''),
      super(SuaDiaDanhState(name: place!.name, province: place.province)) {
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

  Future<void> updatePlace(BuildContext context, int id) async {
    final trimmedName = (state.name ?? '').trim();
    if (trimmedName.isEmpty) {
      emit(state.copyWith(error: "Vui lòng nhập tên địa danh"));
      return;
    }

    //local
    final localUpdated = Place(id: id,name: trimmedName,province: state.province!,);
    Navigator.pop(context, localUpdated);
  }
}
