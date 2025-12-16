import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'danh_sach_hoat_dong_state.dart';

class DanhSachHoatDongCubit extends Cubit<DanhSachHoatDongState> {
  DanhSachHoatDongCubit({int? placeId}) : super(const DanhSachHoatDongState()) {
    getDanhSachHoatDong(placeId: placeId);
  }
  final bookingRepository = GetIt.instance<BookingRepository>();

  Future<void> getDanhSachHoatDong({int? placeId}) async {
    final finalPlaceId = placeId ?? state.placeId;

    if (finalPlaceId == null) {
      emit(
        state.copyWith(
          status: DanhSachHoatDongStatus.failure,
          error: 'Place ID không được để trống',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: DanhSachHoatDongStatus.loading,
        placeId: finalPlaceId,
      ),
    );

    final result = await bookingRepository.getLocationActivities(
      placeId: finalPlaceId,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DanhSachHoatDongStatus.failure,
          error: failure.message,
        ),
      ),
      (locationActivities) => emit(
        state.copyWith(
          status: DanhSachHoatDongStatus.success,
          danhSachHoatDong: locationActivities,
          originalDanhSachHoatDong: locationActivities,
        ),
      ),
    );
  }

  Future<void> deleteLocationActivity(int id) async {
    final result = await bookingRepository.deleteLocatinActivities(id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: DanhSachHoatDongStatus.failure,
          error: failure.message,
        ),
      ),
      (response) {
        getDanhSachHoatDong();
      },
    );
  }

  void searchLocationActivities(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          danhSachHoatDong: state.originalDanhSachHoatDong,
        ),
      );
    } else {
      final filtered =
          state.originalDanhSachHoatDong
              .where(
                (activity) => activity.name.toLowerCase().contains(
                  query.trim().toLowerCase(),
                ),
              )
              .toList();
      emit(state.copyWith(searchQuery: query, danhSachHoatDong: filtered));
    }
  }

  void clearSearch() {
    getDanhSachHoatDong();
  }

  void setLocationActivity(LocationActivity locationActivity) {
    emit(state.copyWith(selectedLocationActivity: locationActivity));
  }
}
