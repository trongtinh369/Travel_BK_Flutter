import 'package:booking_tour_flutter/domain/day_activity.dart';

class DayOfTour {
  String title;
  String description;
  List<DayActivity> dayActivities;

  DayOfTour({
    required this.title,
    required this.description,
    required this.dayActivities,
  });
}
