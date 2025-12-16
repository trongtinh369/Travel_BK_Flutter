// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';

class DayActivity {
  DateTime dateTime;
  LocationActivity locationActivity;
  Activity activity;

  DayActivity({
    required this.dateTime,
    required this.locationActivity,
    required this.activity,
  });
}
