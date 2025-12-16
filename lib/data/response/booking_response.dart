// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/response/booking_status_response.dart';
import 'package:booking_tour_flutter/data/response/schedule_tourmanager_response.dart';
import 'package:booking_tour_flutter/data/response/user_response.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse {
  int? id;
  int? numPeople;
  String? code;
  String? email;
  String? phone;
  int? totalPrice;
  int? countChangeLeft;
  DateTime? createdAt;
  bool? payType;
  BookingStatusResponse? status;
  ScheduleTourmanagerResponse? schedule;
  UserResponse? user;
  DateTime? expiredAt;
  String? qr;

  BookingResponse({
    this.numPeople,
    this.code,
    this.email,
    this.phone,
    this.totalPrice,
    this.countChangeLeft,
    this.createdAt,
    this.status,
    this.schedule,
    this.user,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}

extension BookingResponseMapper on BookingResponse {
  Booking map() {
    var bookingStatus = status?.map() ?? BookingStatus.empty();
    var convertedSchedule = schedule?.map() ?? ScheduleTourmanager.empty();
    var convertedUser = user?.map() ?? User.empty();

    return Booking(
      id: id ?? 6,
      numPeople: numPeople ?? 0,
      code: code ?? "",
      email: email ?? "",
      phone: phone ?? "",
      totalPrice: totalPrice ?? 0,
      countChangeLeft: countChangeLeft ?? 0,
      createdAt: createdAt ?? DateTime.now(),
      payType: payType ?? false,
      status: bookingStatus,
      schedule: convertedSchedule,
      user: convertedUser,
      expiredAt: expiredAt ?? DateTime.now(),
      qr: qr ?? "",
    );
  }
}
