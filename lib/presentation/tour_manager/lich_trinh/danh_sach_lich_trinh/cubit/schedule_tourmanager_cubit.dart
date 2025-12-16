import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:dartz/dartz.dart';
import 'package:booking_tour_flutter/data/network/dio/failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'schedule_tourmanager_state.dart';

@injectable
class ScheduleTourmanagerCubit extends Cubit<ScheduleTourmanagerState> {
  final BookingRepository _repository;

  ScheduleTourmanagerCubit(this._repository)
      : super(ScheduleTourmanagerInitial());

  Future<void> loadSchedules() async {
    emit(ScheduleTourmanagerLoading());
    final result = await _repository.getAllSchedule();
    result.fold(
      (failure) => emit(ScheduleTourmanagerError(failure.message)),
      (schedules) => emit(ScheduleTourmanagerLoaded(schedules)),
    );
  }

Future<void> deleteSchedule(ScheduleTourmanager schedule) async {
  if (state is ScheduleTourmanagerLoaded) {
    final currentSchedules = (state as ScheduleTourmanagerLoaded).schedules;
    emit(ScheduleTourmanagerLoading());

    final result = await _repository.deleteScheduleById(id: schedule.id);
    result.fold(
      (failure) {
        emit(ScheduleTourmanagerError("Bạn không thể xóa lịch trình này !"));

        emit(ScheduleTourmanagerLoaded(currentSchedules));
      },
      (_) {
        final updatedSchedules =
            currentSchedules.where((t) => t.id != schedule.id).toList();
        emit(ScheduleTourmanagerLoaded(updatedSchedules));
      },
    );
  }
}

  Future<Either<Failure, List<Trip>>> getTours() async {
    return await _repository.getTrips();
  }
}
