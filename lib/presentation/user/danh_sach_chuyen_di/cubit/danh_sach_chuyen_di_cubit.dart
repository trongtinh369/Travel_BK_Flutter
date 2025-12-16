import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'danh_sach_chuyen_di_state.dart';

class DanhSachChuyenDiCubit extends Cubit<DanhSachChuyenDiState> {
  static final bookingRepository = getIt<BookingRepository>();

  DanhSachChuyenDiCubit() : super(DanhSachChuyenDiState()) {
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([loadMostFavoriteTour(), loadMostRecent()]);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> loadMostFavoriteTour() async {
    final result = await bookingRepository.getMostFavoriteTour();
    result.fold((failure) {}, (trips) {
      emit(state.copyWith(mostFavoriteTrips: trips));
    });
  }

  Future<void> loadMostRecent() async {
    final result = await bookingRepository.getMostRecent();
    result.fold((failure) {}, (trips) {
      emit(state.copyWith(mostRecent: trips));
    });
  }
}
