import 'package:booking_tour_flutter/domain/schedule_assignment.dart';
import 'package:booking_tour_flutter/domain/tour_assignment.dart';

class ScheduleAssignmentState {
  final int tourId;
  final TourAssignment tour;
  final List<ScheduleAssignment> schedules;
  

  ScheduleAssignmentState({required this.tour, required this.tourId, required this.schedules});

  ScheduleAssignmentState copyWith({TourAssignment? tour, int? tourId, List<ScheduleAssignment>? schedules}) {
    return ScheduleAssignmentState(
      tour: tour ?? this.tour,
      tourId: tourId ?? this.tourId,
      schedules: schedules ?? this.schedules,
    );
  }
}