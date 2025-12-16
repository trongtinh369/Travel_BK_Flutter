// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/response/day_activity_response.dart';
import 'package:booking_tour_flutter/domain/day_of_tour.dart';

part 'day_of_tour_response.g.dart';

@JsonSerializable()
class DayOfTourResponse {
  String? title;
  String? description;
  List<DayActivityResponse>? dayActivities;
  DayOfTourResponse({this.title, this.description, this.dayActivities});

  factory DayOfTourResponse.fromJson(Map<String, dynamic> json) =>
      _$DayOfTourResponseFromJson(json);
}

extension DayOfTourResponseMapper on DayOfTourResponse {
  DayOfTour map() {
    // if (title == null){
    //   throw Exception("DayOfTourResponse: title is null");
    // }
    // if (description == null){
    //   throw Exception("DayOfTourResponse: description is null");
    // }
    // if (this.dayActivities == null || this.dayActivities!.isEmpty){
    //   throw Exception("DayOfTourResponse: dayActivity is null");
    // }

    title ??= "";
    description ??= "";
    this.dayActivities ??= [];

    var dayActivities = this.dayActivities!.map((i) => i.map()).toList();

    return DayOfTour(
      title: title!,
      description: description!,
      dayActivities: dayActivities,
    );
  }
}
