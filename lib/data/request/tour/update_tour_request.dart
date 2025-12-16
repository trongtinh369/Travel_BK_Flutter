// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/request/tour/create_day_of_tour_request.dart';

part 'update_tour_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateTourRequest {
  int id;
  int day;
  String title;
  int price;
  String description;
  int percentDeposit;
  List<CreateDayOfTourRequest> dayOfTours;
  List<String> tourImages;
  List<String> retainImages;

  UpdateTourRequest({
    required this.id,
    required this.day,
    required this.title,
    required this.price,
    required this.percentDeposit,
    required this.description,
    required this.dayOfTours,
    required this.tourImages,
    required this.retainImages,
  });

  Map<String, dynamic> toJson() => _$UpdateTourRequestToJson(this);
}
