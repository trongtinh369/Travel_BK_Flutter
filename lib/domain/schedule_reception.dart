import 'package:booking_tour_flutter/domain/trip.dart';

class ScheduleReception {
  final int id;
  final String code;
  final Trip tour;
  ScheduleReception({required this.id, required this.code, required this.tour});

  static ScheduleReception empty(){
    return ScheduleReception(id: 0, code: "", tour: Trip.empty());
  }
}