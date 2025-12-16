import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/schedule_reception.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';

class LichTrinhChuaHoanThanhState {
  final List<ScheduleReception> scheduleReception;
  final Map<int, List<Booking>> booking;
  bool? isLoading = true;

  LichTrinhChuaHoanThanhState({required this.scheduleReception, required this.booking, this.isLoading});

  LichTrinhChuaHoanThanhState copyWith({List<ScheduleReception>? scheduleReception, Map<int, List<Booking>>? booking, bool? isLoading}) {
    return LichTrinhChuaHoanThanhState(
      scheduleReception: scheduleReception ?? this.scheduleReception,
      booking: booking ?? this.booking,
      isLoading: isLoading ?? this.isLoading
    );
  }
}
