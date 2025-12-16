// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';

part 'booking_status_response.g.dart';

@JsonSerializable()
class BookingStatusResponse {
  int? id;
  String? name;

  BookingStatusResponse({this.id, this.name});

  factory BookingStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingStatusResponseFromJson(json);
}

extension BookingStatusResponseMapper on BookingStatusResponse {
  BookingStatus map() {
    return BookingStatus(id: id ?? 0, name: name ?? "");
  }
}
