import 'package:booking_tour_flutter/domain/schedule_user_completed.dart';
import 'package:booking_tour_flutter/data/response/trip_manager_response.dart';
import 'package:booking_tour_flutter/domain/schedule_user_completed.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_user_completed_response.g.dart';

@JsonSerializable()
class ScheduleUserCompletedResponse {
  int? id;
  int? finalPrice;
  String? code;
  TripManagerResponse? tour;

  ScheduleUserCompletedResponse({
    this.id,
    this.finalPrice,
    this.code,
    this.tour,
  });

  factory ScheduleUserCompletedResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleUserCompletedResponseFromJson(json);
}

extension ScheduleUserCompletedResponseMapper on ScheduleUserCompletedResponse {
  ScheduleUserCompleted map() {
    return ScheduleUserCompleted(
      id: id ?? 0,
      finalPrice: finalPrice ?? 0,
      code: code ?? "",
      tour:
          tour?.map() ??
          Trip(
            id: 0,
            day: 0,
            title: '',
            price: 0,
            percentDeposit: 0,
            description: '',
            provinces: [],
            tourImages: [],
            dayOfTours: [],
            totalReviews: 0,
            totalStars: 0,
            places: [],
          ),
    );
  }
}
