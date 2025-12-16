import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';
import 'package:booking_tour_flutter/presentation/reception/kiem_tra_nguoi_tham_gia/cubit/kiem_tra_nguoi_tham_gia_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KiemTraNguoiThamGiaCubit extends Cubit<KiemTraNguoiThamGiaState> {
  final bookingRepository = getIt<BookingRepository>();

  KiemTraNguoiThamGiaCubit()
    : super(KiemTraNguoiThamGiaState(userCompletedSchedule: [], booking: []));

  Future<void> syncBooking(int scheduleId) async {
    emit(state.copyWith(isLoading: true));

    var result1 = await bookingRepository.getUserCompletedScheduleByScheduleId(
      scheduleId: scheduleId,
    );
    var result2 = await bookingRepository.getBookingsByScheduleId(scheduleId);

    result1.fold((fail) {}, (userCompletedSchedule) {
      result2.fold((e) {}, (booking) {
        emit(
          state.copyWith(
            userCompletedSchedule: userCompletedSchedule,
            booking: booking,
            isLoading: false,
          ),
        );
      });
    });
  }

  bool isUserParticipated(int bookingId) {
    final userCompleted = getUserCompletedScheduleByBookingId(bookingId);
    return userCompleted != null && (userCompleted.countPeople ?? 0) > 0;
  }

  UserCompletedSchedule? getUserCompletedScheduleByBookingId(int bookingId) {
    try {
      return state.userCompletedSchedule.firstWhere(
        (item) => item.booking?.id == bookingId,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteUserCompletedSchedule(int id) async {
    var result = await bookingRepository.deleteUserCompletedSchedule(id: id);

    result.fold((e) {}, (ok) {
      //emit(state);
    });
  }
}
