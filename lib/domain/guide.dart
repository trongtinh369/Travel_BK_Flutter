import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';

class Guide {
  final int staffId;
  final int scheduleId;
  final Tour tour;

  Guide({required this.staffId, required this.scheduleId, required this.tour});

  static Guide empty() {
    return Guide(staffId: 0, scheduleId: 0, tour: Tour.empty());
  }
}
