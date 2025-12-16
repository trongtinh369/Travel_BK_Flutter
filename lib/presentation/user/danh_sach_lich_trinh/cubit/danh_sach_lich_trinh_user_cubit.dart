import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'danh_sach_lich_trinh_user_state.dart';

class DanhSachLichTrinhUserCubit extends Cubit<DanhSachLichTrinhUserState> {
  static final bookingRepository = getIt<BookingRepository>();

  DanhSachLichTrinhUserCubit() : super(DanhSachLichTrinhUserState());

  Future<void> loadSchedules(int tourId) async {
    emit(state.copyWith(isLoading: true));

    final result = await bookingRepository.getSchedulesByTourId(tourId);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (schedules) {
        emit(state.copyWith(schedules: schedules, isLoading: false));
      },
    );
  }
}
