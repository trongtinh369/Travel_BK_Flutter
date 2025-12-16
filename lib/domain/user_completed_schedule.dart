import 'package:booking_tour_flutter/domain/actualcash.dart';
import 'package:booking_tour_flutter/domain/booking.dart';

class UserCompletedSchedule {
  int? countPeople;
  Booking? booking;

  UserCompletedSchedule({required this.countPeople,required this.booking}){
    this.countPeople = countPeople;
    this.booking = booking;
  }
  static UserCompletedSchedule empty() {
    return UserCompletedSchedule(
      countPeople: 0,
      booking: Booking.empty(),
    );
  }
}