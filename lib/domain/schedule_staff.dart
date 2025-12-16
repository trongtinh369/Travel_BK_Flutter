import 'package:booking_tour_flutter/domain/trip.dart';
class ScheduleStaff {
  final int totalReviews;
  final int totalStars;
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

  ScheduleStaff({
    required this.totalReviews,
    required this.totalStars,
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
  });

  double get averageRating {
    if (totalReviews == 0) return 0.0;
    return totalStars / totalReviews;
  }
}