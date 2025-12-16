// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/trip.dart';

class ScheduleTourmanager {
  final int id;
  final int tourId;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime openDate;
  final int bookedSlot;
  final int maxSlot;
  final int finalPrice;
  final String gatheringTime;
  final String code;
  final int desposit;
  final Trip tour;
  final int processingBooking;
  final int depositBooking;
  final int paidBooking;

  ScheduleTourmanager({
    required this.id,
    required this.tourId,
    required this.startDate,
    required this.endDate,
    required this.openDate,
    required this.bookedSlot,
    required this.maxSlot,
    required this.finalPrice,
    required this.gatheringTime,
    required this.code,
    required this.desposit,
    required this.tour,
    required this.processingBooking,
    required this.depositBooking,
    required this.paidBooking,
  });

  factory ScheduleTourmanager.empty() {
    return ScheduleTourmanager(
      id: 0,
      tourId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      openDate: DateTime.now(),
      bookedSlot: 0,
      maxSlot: 0,
      finalPrice: 0,
      gatheringTime: "00:00",
      code: "",
      desposit: 0,
      tour: Trip.empty(),
      processingBooking: 0,
      depositBooking: 0,
      paidBooking: 0,
    );
  }
}
