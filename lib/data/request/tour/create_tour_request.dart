import 'package:booking_tour_flutter/data/request/tour/create_day_of_tour_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_tour_request.g.dart';

@JsonSerializable(createFactory: false)
class CreateTourRequest {
  int day;
  String title;
  int price;
  String description;
  int percentDeposit;
  List<CreateDayOfTourRequest> dayOfTours;
  List<String> tourImages;

  CreateTourRequest({
    required this.day,
    required this.title,
    required this.price,
    required this.percentDeposit,
    required this.description,
    required this.dayOfTours,
    this.tourImages = const [],
  });

  Map<String, dynamic> toJson() => _$CreateTourRequestToJson(this);
}
