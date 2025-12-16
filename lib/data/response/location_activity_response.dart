import 'package:booking_tour_flutter/data/response/activity_response.dart';
import 'package:booking_tour_flutter/data/response/place_response.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:json_annotation/json_annotation.dart';
part 'location_activity_response.g.dart';

@JsonSerializable()
class LocationActivityResponse {
  int? id;
  String? name;
  PlaceResponse? place;
  List<ActivityResponseData>? activities;
  LocationActivityResponse({this.id, this.name, this.place, this.activities});

  factory LocationActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationActivityResponseFromJson(json);
}

@JsonSerializable()
class LocationResponse {
  int? id;
  String? name;

  LocationResponse({this.id, this.name});

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

extension LocationActivityResponseMapper on LocationActivityResponse {
  LocationActivity map() {
    return LocationActivity(
      id: id ?? 0,
      name: name ?? "",
      place:
          place?.map() ??
          Place(id: 0, name: "", province: Province(id: 0, name: "")),
      activities: activities?.map((i) => i.map()).toList() ?? [],
    );
  }
}
