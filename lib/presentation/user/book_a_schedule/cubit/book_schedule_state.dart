// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/schedule_book.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/widgets/payment_option.dart';

class BookScheduleState {
  final ScheduleTourmanager schedule;
  final int idSchedule;
  final int idBooking;
  final HinhThuc hinhThuc;
  final int tienThanhToanHet;
  final int tienThanhToanCoc;
  final int totalPrice;

  final bool isBooking;
  BookScheduleState({
    required this.schedule,
    required this.idSchedule,
    required this.idBooking,
    required this.hinhThuc,
    required this.tienThanhToanHet,
    required this.tienThanhToanCoc,
    required this.isBooking,
    required this.totalPrice,
  });

  BookScheduleState copyWith({
    ScheduleTourmanager? schedule,
    int? idSchedule,
    int? idBooking,
    HinhThuc? hinhThuc,
    int? tienThanhToanHet,
    int? tienThanhToanCoc,
    bool? isBooking,
    int? totalPrice,
  }) {
    return BookScheduleState(
      schedule: schedule ?? this.schedule,
      idSchedule: idSchedule ?? this.idSchedule,
      idBooking: idBooking ?? this.idBooking,
      hinhThuc: hinhThuc ?? this.hinhThuc,
      tienThanhToanHet: tienThanhToanHet ?? this.tienThanhToanHet,
      tienThanhToanCoc: tienThanhToanCoc ?? this.tienThanhToanCoc,
      isBooking: isBooking ?? this.isBooking,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
