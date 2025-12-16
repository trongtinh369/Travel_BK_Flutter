// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/schedule_user_completed.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ReviewScheduleState extends Equatable {
  final int stars;
  String review;
  final int userId;
  final ScheduleTourmanager? schedule;
  final bool isSentReview;
  final bool isLoading;
  final String? errorMessage;
  final bool isBack;

  ReviewScheduleState({
    required this.stars,
    required this.review,
    this.userId = 0,
    this.schedule,
    this.isSentReview = false,
    this.errorMessage,
    this.isLoading = false,
    this.isBack = false,
  });

  ReviewScheduleState copyWith({
    int? stars,
    String? review,
    int? userId,
    ScheduleTourmanager? schedule,
    bool? isSent,
    bool? isLoading,
    String? errorMessage,
    bool? isBack,
  }) {
    return ReviewScheduleState(
      stars: stars ?? this.stars,
      review: review ?? this.review,
      userId: userId ?? this.userId,
      schedule: schedule ?? this.schedule,
      isSentReview: isSent ?? this.isSentReview,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isBack: isBack ?? this.isBack,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    this.stars,
    this.userId,
    this.schedule,
    this.isSentReview,
    this.errorMessage,
    this.isLoading,
    this.isBack,
  ];
}
