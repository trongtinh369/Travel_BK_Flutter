import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/response/actualcash_response.dart';
import 'package:booking_tour_flutter/data/response/booking_response.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_completed_schedule_response.g.dart';

@JsonSerializable()
class UserCompletedScheduleFixResponse {
  final int? countPeople;
  final BookingResponse? booking;

  UserCompletedScheduleFixResponse({
    this.countPeople,
    this.booking,
  });

  factory UserCompletedScheduleFixResponse.fromJson(Map<String, dynamic> json) =>
      _$UserCompletedScheduleFixResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserCompletedScheduleFixResponseToJson(this);
}

extension UserCompletedScheduleResponseMapper on UserCompletedScheduleFixResponse {
  UserCompletedSchedule map() {
    return UserCompletedSchedule(
      countPeople: countPeople ?? 0,
      booking: booking!.map(),
    );
  }
}
