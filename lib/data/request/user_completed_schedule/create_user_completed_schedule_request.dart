import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/response/actualcash_response.dart';
import 'package:booking_tour_flutter/data/response/booking_response.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_completed_schedule_request.g.dart';

@JsonSerializable()
class CreateUserCompletedScheduleFixRequest{
  final int? bookingId;
  final int? countPeople;

  CreateUserCompletedScheduleFixRequest({
    this.bookingId,
    this.countPeople,
  });

  Map<String, dynamic> toJson() => _$CreateUserCompletedScheduleFixRequestToJson(this);
}
