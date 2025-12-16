import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/user/get_helpfull_request.dart';
import 'package:booking_tour_flutter/data/request/user/get_reviews_request.dart';
import 'package:booking_tour_flutter/presentation/user/chi_tiet_lich_trinh.dart/cubit/chi_tiet_lich_trinh_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChiTietLichTrinhCubit extends Cubit<ChiTietLichTrinhState> {
  static final bookingRepository = getIt<BookingRepository>();

  ChiTietLichTrinhCubit() : super(ChiTietLichTrinhState());

  Future<void> loadRviews(int tourId, int userId) async {
    emit(state.copyWith(isLoading: true));

    final result = await bookingRepository.getReview(
      userId: userId,
      tourId: tourId,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (reviews) {
        emit(state.copyWith(reviews: reviews, isLoading: false));
      },
    );
  }

  Future<void> loadFavoriteStatus(int userId, int tourId) async {
    final result = await bookingRepository.getTourFavoriteByUserId(
      userId: userId,
    );

    result.fold(
      (failure) {
        // Handle error if needed
      },
      (favorites) {
        // Check if current tour is in the favorite list
        final isFavorite = favorites.any(
          (favorite) => favorite.tourId == tourId,
        );
        emit(state.copyWith(isFavorite: isFavorite));
      },
    );
  }

  Future<void> postHelpFul(int userId, int reviewId) async {
    GetHelpFullRequest request = GetHelpFullRequest(
      userId: userId,
      reviewId: reviewId,
    );
    final helpFul = await bookingRepository.getHelpFul(request);
    helpFul.fold(
      (failure) {
        emit(state.copyWith(isLoading: false));
      },
      (helpFul) {
        emit(state.copyWith(helpFul: helpFul, isLoading: false));
      },
    );
  }

  Future<void> toggleFavorite(int userId, int tourId) async {
    if (state.isFavorite) {
      // If already favorite, remove it
      final result = await bookingRepository.removeFavorite(
        tourId: tourId,
        userId: userId,
      );
      result.fold(
        (failure) {
          // Handle error if needed
        },
        (success) {
          emit(state.copyWith(isFavorite: false));
        },
      );
    } else {
      // If not favorite, add it
      GetReviewsRequest request = GetReviewsRequest(
        userId: userId,
        tourId: tourId,
      );
      final result = await bookingRepository.postFavorite(request);
      result.fold(
        (failure) {
          // Handle error if needed
        },
        (success) {
          emit(state.copyWith(isFavorite: true));
        },
      );
    }
  }
}
