// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/day_activity.dart';
import 'package:flutter/material.dart';

import 'package:booking_tour_flutter/data/request/tour/create_day_activity_request.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/domain/place.dart';

class CTDayActivity {
  TimeOfDay? time;
  Place? place;
  LocationActivity? locationActivity;
  Activity? activity;

  CTDayActivity({this.time, this.place, this.locationActivity, this.activity});
}

extension CTDayActivityMapper on CTDayActivity {
  CreateDayActivityRequest mapToRequest() {
    if (locationActivity == null || activity == null || time == null) {
      throw Exception("can't create create_day_activity_request");
    }

    return CreateDayActivityRequest(
      activityId: activity!.id,
      locationActivityId: locationActivity!.id,
      time: "${time!.hour}:${time!.minute}",
    );
  }
}

extension DayActivityMapToCTDayActivity on DayActivity {
  CTDayActivity mapToCTDayActivity() {
    var time = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
    return CTDayActivity(
      time: time,
      place: locationActivity.place,
      locationActivity: locationActivity,
      activity: activity,
    );
  }
}
