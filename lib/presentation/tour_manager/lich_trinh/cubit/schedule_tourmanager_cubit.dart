import 'package:booking_tour_flutter/data/request/shedule_tourmanager_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../data/booking_repository.dart';
import '../../../../domain/schedule_tourmanager.dart';
import 'schedule_tourmanager_state.dart';

@injectable
class ScheduleTourmanagerCubit extends Cubit<ScheduleTourmanagerState> {
  final BookingRepository _repository;

  ScheduleTourmanagerCubit(this._repository) : super(ScheduleTourmanagerInitial());

  Future<void> loadSchedules() async {
    emit(ScheduleTourmanagerLoading());
    final result = await _repository.getAllSchedule();
    result.fold(
      (failure) => emit(ScheduleTourmanagerError(failure.message)),
      (schedules) => emit(ScheduleTourmanagerLoaded(schedules)),
    );
  }

  Future<void> deleteSchedule(ScheduleTourmanager schedule) async {
   if (state is ScheduleTourmanagerLoaded)
   {
    final currentSchedule = (state as ScheduleTourmanagerLoaded).schedules;
    emit(ScheduleTourmanagerLoading());
    final result = await _repository.deleteScheduleById(id: schedule.id);
    result.fold(
       (failure) => emit(ScheduleTourmanagerError(failure.message)),
        (_) {
          final updatedSchedules =
              currentSchedule.where((t) => t.id != schedule.id).toList();
          emit(ScheduleTourmanagerLoaded(updatedSchedules));
        },);
   }
  }
}

