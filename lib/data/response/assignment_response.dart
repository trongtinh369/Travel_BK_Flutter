import 'package:booking_tour_flutter/domain/assignment.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:json_annotation/json_annotation.dart';
part 'assignment_response.g.dart';

@JsonSerializable()
class AssignmentResponse {
  final int? id;
  final String? title;
  final List<String>? tourImages;
  final List<LocationResponse>? locations;
  final List<AssignmentPlaceResponse>? places;

  AssignmentResponse({
    this.id,
    this.title,
    this.tourImages,
    this.locations,
    this.places,
  });

  factory AssignmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AssignmentResponseFromJson(json);
}

// Thêm response cho Location và Place
@JsonSerializable()
class LocationResponse {
  final int id;
  final String name;

  LocationResponse({required this.id, required this.name});

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

@JsonSerializable()
class AssignmentPlaceResponse {
  final int id;
  final String name;
  final LocationResponse? location;

  AssignmentPlaceResponse({
    required this.id,
    required this.name,
    this.location,
  });

  factory AssignmentPlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$AssignmentPlaceResponseFromJson(json);
}

extension AssignmentResponseMapper on AssignmentResponse {
  Assignment map() {
    final firstImage =
        (tourImages != null && tourImages!.isNotEmpty) ? tourImages!.first : '';

    final firstLocation =
        (locations != null && locations!.isNotEmpty)
            ? locations!.first.name
            : '';

    final placesText =
        (places != null && places!.isNotEmpty)
            ? places!.map((p) => p.name).join(', ')
            : '';

    return Assignment(
      id: id ?? 0,
      title: title ?? "",
      placeNames: Place(
        id: 0,
        name: placesText,
        province: Province(id: 0, name: firstLocation),
      ),
      locations: Province(id: 0, name: firstLocation),
      tourImages: firstImage,
    );
  }
}
