import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';

class GuideReviews {
  final String nameStaff;
  final ScheduleAssignmentTourguide scheduleAssignmentTourguide;

  GuideReviews({
    required this.nameStaff,
    required this.scheduleAssignmentTourguide,
  });

  static GuideReviews empty() {
    return GuideReviews(
      nameStaff: '',
      scheduleAssignmentTourguide: ScheduleAssignmentTourguide.empty(),
    );
  }
}
