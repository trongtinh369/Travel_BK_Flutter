import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';
import 'package:booking_tour_flutter/domain/trip.dart';

class ScheduleUserCompleted {
  final int id;
  final int finalPrice;
  final String code;
  final Trip tour;

  ScheduleUserCompleted({
    required this.id,
    required this.finalPrice,
    required this.code,
    required this.tour,
  });
}