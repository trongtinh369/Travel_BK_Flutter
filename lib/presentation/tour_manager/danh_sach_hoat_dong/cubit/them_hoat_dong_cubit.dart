import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/requests/add_location_activity_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'them_hoat_dong_state.dart';

class ThemHoatDongCubit extends Cubit<ThemHoatDongState> {
  ThemHoatDongCubit() : super(const ThemHoatDongState());
  final bookingRepository = GetIt.instance<BookingRepository>();

  Future<void> loadActivities() async {
    if (isClosed) return;
    emit(state.copyWith(status: ThemHoatDongStatus.loading));
    final result = await bookingRepository.getActivities();

    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ThemHoatDongStatus.failure,
          error: failure.message,
        ),
      ),
      (activities) => emit(
        state.copyWith(
          status: ThemHoatDongStatus.initial,
          activities: activities,
          filteredActivities: activities,
        ),
      ),
    );
  }

  Future<void> themHoatDong(
    String tenDiaDiem,
    int placeId,
    List<Activity> selectedActivities,
  ) async {
    if (isClosed) return;
    emit(state.copyWith(status: ThemHoatDongStatus.loadingAdd));
    final activityIds =
        selectedActivities.map((activity) => activity.id).toList();

    final result = await bookingRepository.addLocationActivities(
      AddLocationActivityRequest(
        placeId: placeId,
        name: tenDiaDiem.trim(),
        activityIds: activityIds,
      ),
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ThemHoatDongStatus.failure,
          error: failure.message,
        ),
      ),
      (locationActivity) =>
          emit(state.copyWith(status: ThemHoatDongStatus.success)),
    );
  }

  void searchActivities(String query) {
    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: query,
          filteredActivities: state.activities,
        ),
      );
    } else {
      final filtered =
          state.activities
              .where(
                (activity) => activity.action.toLowerCase().contains(
                  query.trim().toLowerCase(),
                ),
              )
              .toList();

      emit(state.copyWith(searchQuery: query, filteredActivities: filtered));
    }
  }

  void clearSearch() {
    emit(state.copyWith(searchQuery: '', filteredActivities: state.activities));
  }
}
