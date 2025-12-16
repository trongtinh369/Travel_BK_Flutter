import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/data/response/activity_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'put_activity_response.g.dart';

@JsonSerializable()
class PutActivityResponse {
  final ActivityResponseData? data;

  PutActivityResponse({this.data});

  factory PutActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$PutActivityResponseFromJson(json);
}

extension PutActivityResponseMap on PutActivityResponse {
  Activity? map() => data?.map();
}
