import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/favorite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  static final BookingRepository bookingRepository = getIt<BookingRepository>();

  FavoriteCubit() : super(FavoriteInitial());

  Future<void> loadFavorites({required int userId}) async {
    emit(FavoriteLoading());

    final result = await bookingRepository.getTourFavoriteByUserId(userId: userId);

    result.fold(
      (failure) => emit(FavoriteError(failure.message)),
      (favorites) => emit(FavoriteLoaded(favorites)),
    );
  }

  Future<void> removeFavorite({required int tourId, required int userId}) async {
    if (state is FavoriteLoaded) {
      final current = (state as FavoriteLoaded).favorites;
      final updated = current.where((f) => f.tourId != tourId).toList();
      
      emit(FavoriteLoaded(updated));

      final result = await bookingRepository.removeFavorite(tourId: tourId, userId: userId);

      result.fold(
        (failure) {
          emit(FavoriteError(failure.message));
          loadFavorites(userId: userId);
        },
        (success) {
          if (!success) {
            emit(FavoriteError('Xóa yêu thích không thành công'));
            loadFavorites(userId: userId);
          }
        },
      );
    }
  }
}

