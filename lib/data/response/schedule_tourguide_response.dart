import 'package:booking_tour_flutter/domain/schedule_tourguide.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_tourguide_response.g.dart';

@JsonSerializable()
class ScheduleTourguideResponse {
  ScheduleTourGuideResponse? schedule;
  TourResponse? tour;

  ScheduleTourguideResponse({
    this.schedule,
    this.tour,
  });

  factory ScheduleTourguideResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTourguideResponseFromJson(json);
}

@JsonSerializable()
class ScheduleTourGuideResponse {
  int? id;
  String? startDate;
  String? endDate;
  int? maxSlot;
  String? code;
  TourResponse? tour;

  ScheduleTourGuideResponse({
    this.id,
    this.startDate,
    this.endDate,
    this.maxSlot,
    this.code,
    this.tour,
  });

  factory ScheduleTourGuideResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTourGuideResponseFromJson(json);
}

@JsonSerializable()
class TourResponse {
  String? title;
  List<dynamic>? tourImages;

  TourResponse({
    this.title,
    this.tourImages,
  });

  factory TourResponse.fromJson(Map<String, dynamic> json) =>
      _$TourResponseFromJson(json);
}

extension ScheduleTourguideResponseMapper on ScheduleTourguideResponse {
  ScheduleTourguide map() {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    try {
      if (schedule?.startDate != null) {
        startDate = DateTime.parse(schedule!.startDate!);
      }
      if (schedule?.endDate != null) {
        endDate = DateTime.parse(schedule!.endDate!);
      }
    } catch (e) {
      // Error parsing dates
    }

    String tourTitle = tour?.title ?? schedule?.tour?.title ?? "";

    final tourImagesList = tour?.tourImages ?? schedule?.tour?.tourImages;
    final firstImage = (tourImagesList != null && tourImagesList.isNotEmpty)
        ? tourImagesList.first
        : '';

    String idSchedule = schedule?.code ?? "N/A";
    int quantity = schedule?.maxSlot ?? 0;
    int id = schedule?.id ?? 0;
    return ScheduleTourguide(
      id: id ,
      startDate: startDate,
      endDate: endDate,
      idSchedule: idSchedule,
      location: tourTitle,
      quantity: quantity,
      tourImages: firstImage,
    );
  }
}

