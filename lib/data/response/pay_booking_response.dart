// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/pay_booking.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_booking_response.g.dart';

@JsonSerializable()
class PayBookingResponse {
  int? id;
  int? numPeople;
  String? email;
  String? phone;
  int? totalPrice;
  bool? payType;
  String? code;

  PayBookingResponse({
    this.id,
    this.numPeople,
    this.email,
    this.phone,
    this.totalPrice,
    this.payType,
    this.code,
  });

  factory PayBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$PayBookingResponseFromJson(json);
}

extension PayBookingResponseMapper on PayBookingResponse {
  PayBooking map() {
    return PayBooking(
      id: id ?? 0,
      numPeople: numPeople ?? 0,
      email: email ?? "",
      phone: phone ?? "",
      totalPrice: totalPrice ?? 0,
      payType: payType ?? false,
      code: code ?? "",
    );
  }
}
