import 'package:booking_tour_flutter/data/response/schedule_tourmanager_response.dart';
import 'package:booking_tour_flutter/domain/schedule_reception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_reception_response.g.dart';

@JsonSerializable()
class ScheduleReceptionResponse {
  int? id;
  String? code;
  TripResponse? tour;

  ScheduleReceptionResponse({required this.id, required this.code, required this.tour});

  factory ScheduleReceptionResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleReceptionResponseFromJson(json);

}

extension ScheduleReceptionResponseMapper on ScheduleReceptionResponse{
  ScheduleReception map(){
    return ScheduleReception(
      id: id ?? 0, 
      code: code ?? "", 
      tour: tour!.map());
  }
}