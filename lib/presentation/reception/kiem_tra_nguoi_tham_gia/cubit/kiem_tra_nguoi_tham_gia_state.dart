import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';

class KiemTraNguoiThamGiaState {
  final List<UserCompletedSchedule> userCompletedSchedule;
  final List<Booking> booking; 
  bool? isLoading = true;

  KiemTraNguoiThamGiaState({required this.userCompletedSchedule, required this.booking, this.isLoading});

  KiemTraNguoiThamGiaState copyWith({
    List<UserCompletedSchedule>? userCompletedSchedule,
    List<Booking>? booking,
    bool? isLoading
  }) {
    return KiemTraNguoiThamGiaState(
      userCompletedSchedule: userCompletedSchedule ?? this.userCompletedSchedule,
      booking: booking ?? this.booking,
      isLoading: isLoading ?? this.isLoading
    );
  }
}
