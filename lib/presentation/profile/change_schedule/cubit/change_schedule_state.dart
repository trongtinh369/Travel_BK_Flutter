// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';

abstract class ChangeScheduleState {}

class ChangeScheduleLoadSuccess extends ChangeScheduleState {
  final List<ScheduleTourmanager> schedules;
  final int bookingId;
  ChangeScheduleLoadSuccess({
    required this.schedules,
    required this.bookingId,
  });

  ChangeScheduleLoadSuccess copyWith({
    List<ScheduleTourmanager>? schedules,
    int? bookingId,
    String? errorMessage,
    String? message
  }) {
    return ChangeScheduleLoadSuccess(
      schedules: schedules ?? this.schedules,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}

class ChangeScheduleLoadFail extends ChangeScheduleState {
  final String message;

  ChangeScheduleLoadFail({required this.message});
}

class ChangeScheduleLoading extends ChangeScheduleState {}

class ChangedSchedule extends ChangeScheduleState {
  final Booking booking; 

  ChangedSchedule({
    required this.booking,
  });
}
