// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/domain/schedule.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/user.dart';

class Booking {
  int id;
  int numPeople;
  String code;
  String email;
  String phone;
  int totalPrice;
  int countChangeLeft;
  DateTime createdAt;
  bool payType;
  BookingStatus status;
  ScheduleTourmanager schedule;
  User user;
  DateTime expiredAt;
  String qr;

  Booking({
    required this.id,
    required this.numPeople,
    required this.code,
    required this.email,
    required this.phone,
    required this.totalPrice,
    required this.countChangeLeft,
    required this.createdAt,
    required this.payType,
    required this.status,
    required this.schedule,
    required this.user,
    required this.expiredAt,
    required this.qr,
  });

  factory Booking.empty() {
    return Booking(
      id: 0,
      numPeople: 0,
      code: "",
      email: "",
      phone: "",
      totalPrice: 0,
      countChangeLeft: 0,
      createdAt: DateTime.now(),
      payType: false,
      status: BookingStatus.empty(),
      schedule: ScheduleTourmanager.empty(),
      user: User.empty(),
      expiredAt: DateTime.now(),
      qr: "",
    );
  }

  Booking copyWith({
    int? id,
    int? numPeople,
    String? code,
    String? email,
    String? phone,
    int? totalPrice,
    int? countChangeLeft,
    DateTime? createdAt,
    bool? payType,
    BookingStatus? status,
    ScheduleTourmanager? schedule,
    User? user,
    DateTime? expiredAt,
    String? qr,
  }) {
    return Booking(
      id: id ?? this.id,
      numPeople: numPeople ?? this.numPeople,
      code: code ?? this.code,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      totalPrice: totalPrice ?? this.totalPrice,
      countChangeLeft: countChangeLeft ?? this.countChangeLeft,
      createdAt: createdAt ?? this.createdAt,
      payType: payType ?? this.payType,
      status: status ?? this.status,
      schedule: schedule ?? this.schedule,
      user: user ?? this.user,
      expiredAt: expiredAt ?? this.expiredAt,
      qr: qr ?? this.qr,
    );
  }
}
