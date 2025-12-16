import 'package:booking_tour_flutter/domain/schedule_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_detail_response.g.dart';

@JsonSerializable()
class ScheduleDetailResponse {
  DateTime? startDate;
  DateTime? endDate;
  int? maxSlot;
  TourResponse? tour;

  ScheduleDetailResponse({
    required this.startDate,
    required this.endDate,
    required this.maxSlot,
    required this.tour,
  });

  factory ScheduleDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleDetailResponseFromJson(json);
}

extension ScheduleDetailResponseMapper on ScheduleDetailResponse {
  ScheduleDetail map() {
    return ScheduleDetail(
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      maxSlot: maxSlot ?? 0,
      tour: Tour(
        day: tour?.day ?? 0,
        title: tour?.title ?? "",
        dayOfTours:
            tour?.dayOfTours
                ?.map(
                  (e) => DayOfTour(
                    title: e.title ?? "",
                    description: e.description ?? "",
                    dayActivities:
                        e.dayActivities
                            ?.map(
                              (da) => DayActivitie(
                                activity: Activity(
                                  action: da.activity?.action ?? "",
                                ),
                                locationActivity: LocationActivity(
                                  name: da.locationActivity?.name ?? "",
                                ),
                                time: da.time ?? "",
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                )
                .toList() ??
            [],
      ),
    );
  }
}

@JsonSerializable()
class TourResponse {
  int? day;
  String? title;
  List<DayOfTourResponse>? dayOfTours;
  TourResponse({
    required this.day,
    required this.title,
    required this.dayOfTours,
  });
  factory TourResponse.fromJson(Map<String, dynamic> json) =>
      _$TourResponseFromJson(json);
}

@JsonSerializable()
class DayOfTourResponse {
  String? title;
  String? description;
  List<DayActivitieResponse>? dayActivities;
  DayOfTourResponse({
    required this.title,
    required this.description,
    required this.dayActivities,
  });
  factory DayOfTourResponse.fromJson(Map<String, dynamic> json) =>
      _$DayOfTourResponseFromJson(json);
}

@JsonSerializable()
class DayActivitieResponse {
  ActivityResponse? activity;
  LocationActivityResponse? locationActivity;
  String? time;
  DayActivitieResponse({
    required this.activity,
    required this.locationActivity,
    required this.time,
  });
  factory DayActivitieResponse.fromJson(Map<String, dynamic> json) =>
      _$DayActivitieResponseFromJson(json);
}

@JsonSerializable()
class ActivityResponse {
  String? action;
  ActivityResponse({required this.action});

  factory ActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityResponseFromJson(json);
}

@JsonSerializable()
class LocationActivityResponse {
  String? name;
  LocationActivityResponse({required this.name});

  factory LocationActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationActivityResponseFromJson(json);
}
