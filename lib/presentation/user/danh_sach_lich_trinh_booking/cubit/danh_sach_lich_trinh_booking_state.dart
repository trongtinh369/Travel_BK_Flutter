import 'package:booking_tour_flutter/domain/booking.dart';

class DanhSachLichTrinhBookingState {
  List<Booking> booking;

  DanhSachLichTrinhBookingState({required this.booking});

  DanhSachLichTrinhBookingState copyWith({List<Booking>? booking}){
    return DanhSachLichTrinhBookingState(booking: booking ?? this.booking);
  }
}