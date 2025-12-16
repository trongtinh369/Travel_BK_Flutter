// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/response/activity_response.dart';
import 'package:booking_tour_flutter/data/response/location_activity_response.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/day_activity.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';

part 'day_activity_response.g.dart';

@JsonSerializable()
class DayActivityResponse {
  ActivityResponseData? activity;
  LocationActivityResponse? locationActivity;
  String? time;
  DayActivityResponse({
    this.activity,
    this.locationActivity,
    this.time,
  });

  factory DayActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$DayActivityResponseFromJson(json);
}

extension DayActivityResponseMapper on DayActivityResponse {
  DayActivity map() {
    // if (this.activity == null) {
    //   throw Exception("DayActivityResponse: Activity from response is null");
    // }

    // if (this.locationActivity == null) {
    //   {
    //     throw Exception(
    //       "DayActivityResponse: Location Activity from response is null",
    //     );
    //   }
    // }

    this.activity ??= ActivityResponseData(id: 0, action: "");
    this.locationActivity ??= LocationActivityResponse(id: 0, name: "");

    var timeStr = this.time ?? "00:00:00";
    var strNumbers = timeStr.split(":");
    if (strNumbers.any((strNumber) => int.tryParse(strNumber) == null) ||
        strNumbers.length < 2) {
      throw Exception("DayActivityResponse: Time from response not valid");
    }
    var hms = strNumbers.map((strNumber) => int.parse(strNumber)).toList();

    DateTime time = DateTime(1, 1, 1, hms[0], hms[1]);
    LocationActivity locationActivity = this.locationActivity!.map();
    Activity activity = this.activity!.map();

    return DayActivity(
      dateTime: time,
      locationActivity: locationActivity,
      activity: activity,
    );
  }
}
