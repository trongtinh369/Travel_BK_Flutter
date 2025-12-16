import '../../../domain/schedule_tourguide.dart';

abstract class ScheduleTourguideState {}

class ScheduleTourguideInitial extends ScheduleTourguideState {}

class ScheduleTourguideLoading extends ScheduleTourguideState {}

class ScheduleTourguideLoaded extends ScheduleTourguideState {
  final List<ScheduleTourguide> schedules;
  ScheduleTourguideLoaded(this.schedules);
}

class ScheduleTourguideError extends ScheduleTourguideState {
  final String message;
  ScheduleTourguideError(this.message);
}
