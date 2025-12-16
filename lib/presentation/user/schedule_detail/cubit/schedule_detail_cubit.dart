import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/schedule_detail.dart';
import 'package:booking_tour_flutter/presentation/user/schedule_detail/cubit/schedule_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDetailCubit extends Cubit<ScheduleDetailState> {
  static final scheduleDetailRepository = getIt<BookingRepository>();

  ScheduleDetailCubit() : super(ScheduleDetailState(daySelected: 1, scheduleDetail: ScheduleDetail.empty(),idSchedule: 0, isLoading: true));

  Future<void> loadData() async {

    var schedule = await scheduleDetailRepository.getScheduleById(state.idSchedule);

    schedule.fold((failure){
      emit(state.copyWith(isLoading: true));
    }, (schedule){
      emit(state.copyWith(scheduleDetail: schedule, daySelected: 1, isLoading: false));
    });
  }

  void setIdSchedule(int idSchedule){
    emit(state.copyWith(idSchedule: idSchedule));
  }

  void updateDay(int day){
    emit(state.copyWith(daySelected: day));
  }

  int getDay(){
    return state.daySelected;
  }
}