import 'package:booking_tour_flutter/data/response/schedule_assignment_tourguide_response.dart';
import 'package:booking_tour_flutter/domain/guide_reviews.dart';
import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guide_reviews_response.g.dart';

@JsonSerializable()
class GuideReviewsResponse {
  final String? nameStaff;
  final ScheduleAssignmentTourguideResponse? schedule;

  GuideReviewsResponse({required this.nameStaff, required this.schedule});

  factory GuideReviewsResponse.fromJson(Map<String, dynamic> json) =>
      _$GuideReviewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GuideReviewsResponseToJson(this);
}

extension GuideReviewsResponseMapper on GuideReviewsResponse {
  GuideReviews map() {
    return GuideReviews(
      nameStaff: nameStaff ?? "",
      scheduleAssignmentTourguide: schedule?.map() ?? ScheduleAssignmentTourguide.empty(),
    );
  }
}
