import 'package:booking_tour_flutter/presentation/admin/schedulereviewdetail/cubit/schedule_review_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/schedule_staff.dart';

class ReviewDetailCubit extends Cubit<ReviewDetailState> {
  final BookingRepository _bookingRepository;

  ReviewDetailCubit(this._bookingRepository) : super(ReviewDetailInitial());

  Future<void> loadReviews(ScheduleStaff schedule) async {
    emit(ReviewDetailLoading());

    try {
      final result = await _bookingRepository.getReviewsByScheduleId(
        scheduleId: schedule.id,
      );

      result.fold(
        (failure) {
          emit(ReviewDetailError(failure.message));
        },
        (reviews) {
          // Tính toán averageRating và totalReviews
          final totalReviews = reviews.length;
          final totalStars = reviews.fold<int>(0, (sum, review) => sum + review.rating);
          final averageRating = totalReviews > 0 ? totalStars / totalReviews : 0.0;

          emit(ReviewDetailLoaded(
            cityName: schedule.tour.title,
            startDate: schedule.startDate,
            endDate: schedule.endDate,
            averageRating: averageRating,
            totalReviews: totalReviews,
            allReviews: reviews,  // ✅ Fixed: Removed List<reviews>
            filteredReviews: reviews,
            selectedStarFilter: 0,
          ));
        },
      );
    } catch (e) {
      emit(ReviewDetailError('Có lỗi xảy ra: ${e.toString()}'));
    }
  }

  void filterByStar(int stars) {
    if (state is ReviewDetailLoaded) {
      final currentState = state as ReviewDetailLoaded;
      
      if (currentState.selectedStarFilter == stars) {
        // Bỏ filter
        emit(currentState.copyWith(
          selectedStarFilter: 0,
          filteredReviews: currentState.allReviews,
        ));
      } else {
        // Apply filter
        final filtered = currentState.allReviews
            .where((review) => review.rating == stars)
            .toList();
        
        emit(currentState.copyWith(
          selectedStarFilter: stars,
          filteredReviews: filtered,
        ));
      }
    }
  }
}