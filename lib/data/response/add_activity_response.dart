import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_activity_response.g.dart';

@JsonSerializable()
class AddActivityResponse {
  AddActivityResponseData? data;

  AddActivityResponse({this.data});

  factory AddActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$AddActivityResponseFromJson(json);
}

@JsonSerializable()
class AddActivityResponseData {
  int? id;
  String? action;
  AddActivityResponseData({this.id, this.action});
  factory AddActivityResponseData.fromJson(Map<String, dynamic> json) =>
      _$AddActivityResponseDataFromJson(json);
}

extension AddActivityResponseMap on AddActivityResponse {
  List<Activity> map() {
    if (data != null) {
      return [data!.map()];
    }
    return [];
  }
}

extension AddActivityResponseDataMap on AddActivityResponseData {
  Activity map() {
    return Activity(id: id ?? 0, action: action ?? "");
  }
}
