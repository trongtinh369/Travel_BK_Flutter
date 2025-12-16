// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/domain/tour_assignment.dart';

part 'tour_assignment_response.g.dart';

@JsonSerializable()
class TourAssignmentResponse {
  String? title;
  int? price;
  List<LocationResponse>? locations;
  List<String>? tourImages;


  TourAssignmentResponse({
    this.title,
    this.price,
    this.locations,
    this.tourImages,
  });

  factory TourAssignmentResponse.fromJson(Map<String, dynamic> json) =>
      _$TourAssignmentResponseFromJson(json);
}

extension TourAssignmentResponseMapper on TourAssignmentResponse{
  TourAssignment map(){
    return TourAssignment(
      titleTour: title ?? "", 
      price: price ?? 0, 
      locations: (locations ?? [LocationResponse()]).map((e) => e.map()).toList(), 
      tourImages: tourImages ?? []
    );
  }
}

@JsonSerializable()
class LocationResponse {
  String? name;

  LocationResponse({
    this.name,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);

}

extension locationResponseMapper on LocationResponse{
  Location map(){
    return Location(
      name: name!,
    );
  }
}
