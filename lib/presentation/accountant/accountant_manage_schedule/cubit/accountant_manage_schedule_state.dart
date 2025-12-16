import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';

class AccountantManageScheduleState {
  final BookingStatus status;
  final ScheduleTourmanager scheduleTourmanager;
  final List<Booking> bookingProcessing;
  final List<Booking> bookingDeposit;
  final List<Booking> bookingPay;

  AccountantManageScheduleState({
    required this.status,
    required this.scheduleTourmanager,
    required this.bookingProcessing,
    required this.bookingDeposit,
    required this.bookingPay,
  });

  AccountantManageScheduleState copyWith({
    int? bookingId,
    BookingStatus? status,
    ScheduleTourmanager? scheduleTourmanager,
    List<Booking>? bookingProcessing,
    List<Booking>? bookingDeposit,
    List<Booking>? bookingPay,
  }) {
    return AccountantManageScheduleState(
      status: status ?? this.status,
      scheduleTourmanager: scheduleTourmanager ?? this.scheduleTourmanager,
      bookingProcessing: bookingProcessing ?? this.bookingProcessing,
      bookingDeposit: bookingDeposit ?? this.bookingDeposit,
      bookingPay: bookingPay ?? this.bookingPay,
    );
  }
}
