import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart'
    as schedule;
import 'package:json_annotation/json_annotation.dart';

part 'schedule_assignment_tourguide_response.g.dart';

@JsonSerializable()
class ScheduleAssignmentTourguideResponse {
  int? id;
  int? tourId;
  DateTime? startDate;
  DateTime? endDate;
  int? maxSlot;
  String? code;

  TourResponse? tour;

  ScheduleAssignmentTourguideResponse({
    this.id,
    this.tourId,
    this.startDate,
    this.endDate,
    this.code,
    this.maxSlot,
    this.tour,
  });

  factory ScheduleAssignmentTourguideResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ScheduleAssignmentTourguideResponseFromJson(json);
}

extension ScheduleAssignmentTourguideResponseMapper
    on ScheduleAssignmentTourguideResponse {
  schedule.ScheduleAssignmentTourguide map() {
    return schedule.ScheduleAssignmentTourguide(
      id: id ?? 0,
      tourId: tourId ?? 0,
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      code: code ?? '',
      maxSlot: maxSlot ?? 0,
      tour:
          tour?.map() ??
          schedule.Tour(title: '', locations: [], description: ''),
    );
  }
}

@JsonSerializable()
class TourResponse {
  final String? title;
  final String? description;
  final List<LocationResponse>? locations;

  TourResponse({this.title, this.locations, this.description});

  factory TourResponse.fromJson(Map<String, dynamic> json) =>
      _$TourResponseFromJson(json);
}

extension TourResponseMapper on TourResponse {
  schedule.Tour map() {
    return schedule.Tour(
      title: title ?? '',
      description: '',
      locations:
          locations
              ?.map((locationResponse) => locationResponse.map())
              .toList() ??
          [],
    );
  }
}

@JsonSerializable()
class LocationResponse {
  final String? name;

  LocationResponse({this.name});

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

extension LocationResponseMapper on LocationResponse {
  schedule.Location map() {
    return schedule.Location(name: name ?? '');
  }
}
