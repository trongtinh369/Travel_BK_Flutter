import 'package:booking_tour_flutter/domain/schedule_book.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_book_response.g.dart';

@JsonSerializable()
class ScheduleBookResponse {
  int? id;
  DateTime? startDate;
  DateTime? endDate;
  int? maxSlot;
  int? finalPrice;
  TourResponse? tour;
  ScheduleBookResponse({
    this.id,
    this.startDate,
    this.endDate,
    this.maxSlot,
    this.finalPrice,
    this.tour,
  });

  factory ScheduleBookResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleBookResponseFromJson(json);
}

extension ScheduleBookResponseMapper on ScheduleBookResponse {
  ScheduleBook map() {
    return ScheduleBook(
      id: id ?? 0,
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      maxSlot: maxSlot ?? 0,
      finalPrice: finalPrice ?? 0,
      tour: tour?.map() ?? Tour(title: " ", percentDeposit: 0, locations: []),
    );
  }
}

@JsonSerializable()
class TourResponse {
  String? title;
  int? percentDeposit;
  List<LocationResponse>? locations;
  TourResponse({
    required this.title,
    required this.percentDeposit,
    required this.locations,
  });

  factory TourResponse.fromJson(Map<String, dynamic> json) =>
      _$TourResponseFromJson(json);
}

extension TourResponseMapper on TourResponse {
  Tour map() {
    return Tour(
      title: title ?? "",
      percentDeposit: percentDeposit ?? 0,
      locations: locations?.map((l) => l.map()).toList() ?? [],
    );
  }
}

@JsonSerializable()
class LocationResponse {
  String? name;
  LocationResponse({required this.name});

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

extension LocationResponseMapper on LocationResponse {
  Location map() {
    return Location(name: name ?? "");
  }
}
