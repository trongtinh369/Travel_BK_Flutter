// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';

abstract class AccountantStartingScheduleState {}

class AccountantStartingScheduleInit extends AccountantStartingScheduleState {}

class AccountantStartingScheduleLoading extends AccountantStartingScheduleState {} 

class AccountantStartingScheduleLoaded extends AccountantStartingScheduleState {
  final List<ScheduleTourmanager> schedules; 

  AccountantStartingScheduleLoaded({
    required this.schedules,
  });
}

class AccountantStartingScheduleError extends AccountantStartingScheduleState {
  final String errorMessage; 

  AccountantStartingScheduleError({
    required this.errorMessage,
  });
}
