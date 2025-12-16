import 'package:booking_tour_flutter/data/response/place_response.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_tourmanager_response.g.dart';

@JsonSerializable()
class ScheduleTourmanagerResponse {
  int? id;
  int? tourId;
  String? startDate;
  String? endDate;
  String? openDate;
  int? bookedSlot;
  int? maxSlot;
  int? finalPrice;
  String? gatheringTime;
  String? code;
  int? desposit;
  TripResponse? tour;
  int? processingBooking;
  int? depositBooking;
  int? paidBooking;

  ScheduleTourmanagerResponse({
    this.id,
    this.tourId,
    this.startDate,
    this.endDate,
    this.openDate,
    this.bookedSlot,
    this.maxSlot,
    this.finalPrice,
    this.gatheringTime,
    this.code,
    this.desposit,
    this.tour,
    this.processingBooking,
    this.depositBooking,
    this.paidBooking,
  });

  factory ScheduleTourmanagerResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTourmanagerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleTourmanagerResponseToJson(this);
}

@JsonSerializable()
class TripResponse {
  int? id;
  String? title;
  int? price;
  String? description;
  List<dynamic>? tourImages;
  List<ProvinceResponse>? locations;
  List<PlaceResponse>? places;

  TripResponse({
    this.id,
    this.title,
    this.price,
    this.description,
    this.tourImages,
    this.locations,
    this.places,
  });

  factory TripResponse.fromJson(Map<String, dynamic> json) =>
      _$TripResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TripResponseToJson(this);

  Trip map() {
    final images = tourImages?.map((e) => e.toString()).toList() ?? [];
    final provinceList = locations?.map((e) => e.map()).toList() ?? [];
    final placesList = places?.map((e) => e.map()).toList() ?? [];

    return Trip(
      id: id ?? 0,
      day: 0,
      title: title ?? '',
      price: price ?? 0,
      percentDeposit: 0,
      description: description ?? "",
      provinces: provinceList,
      tourImages: images,
      dayOfTours: [],
      totalReviews: 0,
      totalStars: 0,
      places: placesList,
    );
  }
}

@JsonSerializable()
class ProvinceResponse {
  int? id;
  String? name;

  ProvinceResponse({this.id, this.name});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      _$ProvinceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceResponseToJson(this);

  Province map() {
    return Province(id: id ?? 0, name: name ?? '');
  }
}

extension ScheduleTourmanagerResponseMapper on ScheduleTourmanagerResponse {
  ScheduleTourmanager map() {
    final start = _parseDate(startDate);
    final end = _parseDate(endDate);
    final open = _parseDate(openDate);

    return ScheduleTourmanager(
      id: id ?? 0,
      tourId: tourId ?? 0,
      startDate: start,
      endDate: end,
      openDate: open,
      bookedSlot: bookedSlot ?? 0,
      maxSlot: maxSlot ?? 0,
      finalPrice: finalPrice ?? 0,
      gatheringTime: gatheringTime ?? '',
      code: code ?? '',
      desposit: desposit ?? 0,
      tour:
          tour?.map() ??
          Trip(
            id: 0,
            day: 0,
            title: '',
            price: 0,
            percentDeposit: 0,
            description: '',
            provinces: [],
            tourImages: [],
            dayOfTours: [],
            totalReviews: 0,
            totalStars: 0,
            places: [],
          ),
      processingBooking: processingBooking ?? 0,
      depositBooking: depositBooking ?? 0,
      paidBooking: paidBooking ?? 0,
    );
  }

  DateTime _parseDate(String? dateStr) {
    try {
      return dateStr != null ? DateTime.parse(dateStr) : DateTime.now();
    } catch (_) {
      return DateTime.now();
    }
  }
}
