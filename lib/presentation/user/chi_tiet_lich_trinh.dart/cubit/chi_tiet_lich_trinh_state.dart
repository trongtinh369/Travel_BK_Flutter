import 'package:booking_tour_flutter/domain/helpful.dart';
import 'package:booking_tour_flutter/domain/review.dart';

class ChiTietLichTrinhState {
  final bool isLoading;
  final List<Review> reviews;
  final List<Helpful> helpFul;
  final bool isFavorite;

  ChiTietLichTrinhState({
    this.isLoading = false,
    this.reviews = const [],
    this.helpFul = const [],
    this.isFavorite = false,
  });

  ChiTietLichTrinhState copyWith({
    bool? isLoading,
    List<Review>? reviews,
    List<Helpful>? helpFul,
    bool? isFavorite,
  }) {
    return ChiTietLichTrinhState(
      isLoading: isLoading ?? this.isLoading,
      reviews: reviews ?? this.reviews,
      helpFul: helpFul ?? this.helpFul,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
