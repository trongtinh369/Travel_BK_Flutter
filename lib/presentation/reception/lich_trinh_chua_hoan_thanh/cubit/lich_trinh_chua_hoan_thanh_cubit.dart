import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/schedule_detail.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';
import 'package:booking_tour_flutter/presentation/reception/lich_trinh_chua_hoan_thanh/cubit/lich_trinh_chua_hoan_thanh_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LichTrinhChuaHoanThanhCubit extends Cubit<LichTrinhChuaHoanThanhState> {
  final bookingRepository = getIt<BookingRepository>();
  LichTrinhChuaHoanThanhCubit()
    : super(
        LichTrinhChuaHoanThanhState(scheduleReception: [],booking: {}),
      );

  Future<void> syncScheduleReception() async {
    var result = await bookingRepository.getScheduleReception();

    result.fold((fail){},
    (schedule){
      emit(state.copyWith(scheduleReception: schedule, isLoading: false));
    });
  }

  Future<void> syncUserCompletedScheduleBySchedule(List<int> scheduleIds) async {
    Map<int, List<Booking>> result = {};
    
    for (int scheduleId in scheduleIds) {
      var apiResult = await bookingRepository
        .getBookingsByScheduleId(scheduleId);

      apiResult.fold((e) {
      }, (userComp) {
        result[scheduleId] = userComp;
      });
    }
    
    emit(state.copyWith(booking: result));
  }
}
