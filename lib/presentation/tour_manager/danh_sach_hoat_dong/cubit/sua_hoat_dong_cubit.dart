import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/requests/update_location_activities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'sua_hoat_dong_state.dart';

class SuaHoatDongCubit extends Cubit<SuaHoatDongState> {
  SuaHoatDongCubit() : super(const SuaHoatDongState());
  final bookingRepository = GetIt.instance<BookingRepository>();

  Future<void> loadActivities() async {
    if (isClosed) return;
    try {
      final result = await bookingRepository.getActivities();

      if (isClosed) return;
      result.fold(
        (failure) => emit(state.copyWith(error: failure.message)),
        (activities) => emit(
          state.copyWith(
            activities: activities,
            filteredActivities: activities,
          ),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(error: e.toString()));
    }
  }

  void setSelectedActivities(List<Activity> activities) {
    emit(state.copyWith(selectedActivities: activities));
  }

  Future<void> suaHoatDong(
    int locationActivityId,
    String name,
    int placeId,
    List<Activity> selectedActivities,
  ) async {
    if (isClosed) return;
    final activityIds =
        selectedActivities.map((activity) => activity.id).toList();

    final request = UpdateLocationActivities(
      id: locationActivityId,
      placeId: placeId,
      name: name.trim(),
      activityIds: activityIds,
    );

    final result = await bookingRepository.updateLocationActivities(request);

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(state.copyWith(error: failure.message));
      },
      (response) {
        emit(state.copyWith(status: true));
      },
    );
  }

  void searchActivities(String query) {
    final allActivities = state.activities;

    if (query.isEmpty) {
      emit(
        state.copyWith(searchQuery: query, filteredActivities: allActivities),
      );
    } else {
      final filtered =
          allActivities
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
