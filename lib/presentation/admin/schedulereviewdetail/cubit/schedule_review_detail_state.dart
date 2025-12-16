import 'package:equatable/equatable.dart';
import 'package:booking_tour_flutter/domain/schedule_review.dart';

abstract class ReviewDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReviewDetailInitial extends ReviewDetailState {}

class ReviewDetailLoading extends ReviewDetailState {}

class ReviewDetailLoaded extends ReviewDetailState {
  final String cityName;
  final DateTime startDate;
  final DateTime endDate;
  final double averageRating;
  final int totalReviews;
  final List<ScheduleReview> allReviews;
  final List<ScheduleReview> filteredReviews;
  final int selectedStarFilter;

  ReviewDetailLoaded({
    required this.cityName,
    required this.startDate,
    required this.endDate,
    required this.averageRating,
    required this.totalReviews,
    required this.allReviews,
    required this.filteredReviews,
    this.selectedStarFilter = 0,
  });

  ReviewDetailLoaded copyWith({
    String? cityName,
    DateTime? startDate,
    DateTime? endDate,
    double? averageRating,
    int? totalReviews,
    List<ScheduleReview>? allReviews,
    List<ScheduleReview>? filteredReviews,
    int? selectedStarFilter,
  }) {
    return ReviewDetailLoaded(
      cityName: cityName ?? this.cityName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      allReviews: allReviews ?? this.allReviews,
      filteredReviews: filteredReviews ?? this.filteredReviews,
      selectedStarFilter: selectedStarFilter ?? this.selectedStarFilter,
    );
  }

  @override
  List<Object?> get props => [
        cityName,
        startDate,
        endDate,
        averageRating,
        totalReviews,
        allReviews,
        filteredReviews,
        selectedStarFilter,
      ];
}

class ReviewDetailError extends ReviewDetailState {
  final String message;

  ReviewDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
