import 'package:booking_tour_flutter/domain/trip.dart';

class DanhSachChuyenDiState {
  final List<Trip> mostFavoriteTrips;
  final List<Trip> mostRecent;
  final bool isLoading;

  DanhSachChuyenDiState({
    this.mostFavoriteTrips = const [],
    this.mostRecent = const [],
    this.isLoading = true,
  });

  DanhSachChuyenDiState copyWith({
    List<Trip>? mostFavoriteTrips,
    List<Trip>? mostRecent,
    bool? isLoading,
  }) {
    return DanhSachChuyenDiState(
      mostFavoriteTrips: mostFavoriteTrips ?? this.mostFavoriteTrips,
      mostRecent: mostRecent ?? this.mostRecent,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
