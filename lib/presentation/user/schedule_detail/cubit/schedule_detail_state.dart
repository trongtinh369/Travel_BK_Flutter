// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/schedule_detail.dart';

class ScheduleDetailState {
  int daySelected;
  ScheduleDetail scheduleDetail;
  int idSchedule;
  bool isLoading;

  ScheduleDetailState({
    required this.daySelected,
    required this.scheduleDetail,
    required this.idSchedule,
    required this.isLoading
  });

  copyWith({
    int? daySelected,
    ScheduleDetail? scheduleDetail,
    int? idSchedule,
    bool? isLoading
  }) {
    return ScheduleDetailState(
      daySelected: daySelected ?? this.daySelected,
      scheduleDetail: scheduleDetail ?? this.scheduleDetail,
      idSchedule: idSchedule ?? this.idSchedule,
      isLoading: isLoading ?? this.isLoading
    );
  }
}
