import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';

class XacNhanSoNguoiThamGiaState {
  final Booking booking;
  bool? isState;

  XacNhanSoNguoiThamGiaState({required this.booking,this.isState});

  XacNhanSoNguoiThamGiaState copyWith({Booking? booking, bool? isState}){
    return XacNhanSoNguoiThamGiaState(booking: booking ?? this.booking, isState: isState ?? this.isState);
  }
}