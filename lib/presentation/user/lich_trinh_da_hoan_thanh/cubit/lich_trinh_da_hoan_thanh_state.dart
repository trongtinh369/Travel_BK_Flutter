import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/schedule_user_completed.dart';
import 'package:booking_tour_flutter/domain/trip.dart';

class LichTrinhDaHoanThanhState {
  final List<Trip> tour;
  final List<ScheduleTourmanager> schedule;

  LichTrinhDaHoanThanhState({
    required this.tour,
    required this.schedule,
  });

  LichTrinhDaHoanThanhState copyWith({
    List<Trip>? tour,
    List<ScheduleTourmanager>? schedule,
  }) {
    return LichTrinhDaHoanThanhState(
      tour: tour ?? this.tour,
      schedule: schedule ?? this.schedule,
    );
  }
}
