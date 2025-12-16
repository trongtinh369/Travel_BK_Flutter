// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/booking.dart';

class DetailPaidScheduleState {
  final Booking booking;
  final String? errorMessage;
  final String? message;

  DetailPaidScheduleState({
    required this.booking,
    this.errorMessage,
    this.message,
  });

  DetailPaidScheduleState copyWith({
    Booking? booking,
    String? errorMessage,
    String? message,
  }) {
    return DetailPaidScheduleState(
      booking: booking ?? this.booking,
      errorMessage: errorMessage,
      message: message,
    );
  }
}
