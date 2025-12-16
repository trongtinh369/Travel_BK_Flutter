import '../../../../domain/schedule_tourmanager.dart';

abstract class ScheduleTourmanagerState {}

class ScheduleTourmanagerInitial extends ScheduleTourmanagerState {}

class ScheduleTourmanagerLoading extends ScheduleTourmanagerState {}

class ScheduleTourmanagerLoaded extends ScheduleTourmanagerState {
  final List<ScheduleTourmanager> schedules;
  ScheduleTourmanagerLoaded(this.schedules);
}

class ScheduleTourmanagerError extends ScheduleTourmanagerState {
  final String message;
  ScheduleTourmanagerError(this.message);
}

