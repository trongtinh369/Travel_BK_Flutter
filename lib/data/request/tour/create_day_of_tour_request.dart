import 'package:booking_tour_flutter/data/request/tour/create_day_activity_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_day_of_tour_request.g.dart';

@JsonSerializable(createFactory: false)
class CreateDayOfTourRequest {
  String title;
  String description;
  List<CreateDayActivityRequest> dayActivities;

  CreateDayOfTourRequest({
    required this.title,
    required this.description,
    required this.dayActivities,
  });

  Map<String, dynamic> toJson() => _$CreateDayOfTourRequestToJson(this);
}
