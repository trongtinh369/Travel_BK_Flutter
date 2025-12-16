import 'package:booking_tour_flutter/data/response/trip_manager_response.dart';
import 'package:booking_tour_flutter/domain/schedule_staff.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_staff_response.g.dart';

@JsonSerializable()
class ScheduleStaffResponse {
  final int totalReviews;
  final int totalStars;
  final int id;
  final int tourId;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime openDate;
  final int bookedSlot;
  final int maxSlot;
  final int finalPrice;
  final String gatheringTime;
  final String code;
  final int desposit;
  final TripManagerResponse tour;

  ScheduleStaffResponse({
    required this.totalReviews,
    required this.totalStars,
    required this.id,
    required this.tourId,
    required this.startDate,
    required this.endDate,
    required this.openDate,
    required this.bookedSlot,
    required this.maxSlot,
    required this.finalPrice,
    required this.gatheringTime,
    required this.code,
    required this.desposit,
    required this.tour,
  });

  factory ScheduleStaffResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleStaffResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleStaffResponseToJson(this);

  ScheduleStaff map() {
    return ScheduleStaff(
      totalReviews: totalReviews,
      totalStars: totalStars,
      id: id,
      tourId: tourId,
      startDate: startDate,
      endDate: endDate,
      openDate: openDate,
      bookedSlot: bookedSlot,
      maxSlot: maxSlot,
      finalPrice: finalPrice,
      gatheringTime: gatheringTime,
      code: code,
      desposit: desposit,
      tour: tour.map(),
    );
  }
}
