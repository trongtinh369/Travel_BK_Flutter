// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/pay_booking.dart';
import 'package:booking_tour_flutter/domain/schedule_book.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';

class PayScheduleState {
  final Booking paySchedule;
  final ScheduleTourmanager schedule;
  final String linkQR;
  final int idSchedule;
  final int idBooking;
  PayScheduleState({
    required this.paySchedule,
    required this.schedule,
    required this.linkQR,
    required this.idSchedule,
    required this.idBooking,
  });

  PayScheduleState copyWith({
    Booking? paySchedule,
    ScheduleTourmanager? schedule,
    String? linkQR,
    int? idSchedule,
    int? idBooking,
  }) {
    return PayScheduleState(
      paySchedule: paySchedule ?? this.paySchedule,
      schedule: schedule ?? this.schedule,
      linkQR: linkQR ?? this.linkQR,
      idSchedule: idSchedule ?? this.idSchedule,
      idBooking: idBooking ?? this.idBooking,
    );
  }
}
