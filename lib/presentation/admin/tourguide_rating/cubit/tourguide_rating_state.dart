
import 'package:booking_tour_flutter/domain/schedule_staff.dart';
import 'package:booking_tour_flutter/domain/staff.dart';

abstract class TourguideRatingState {}

class TourguideRatingInitial extends TourguideRatingState {}

class TourguideRatingLoading extends TourguideRatingState {}

class TourguideRatingLoaded extends TourguideRatingState {
  final List<ScheduleStaff> schedules;
  final String? filterText;
  final int? provinceId;
  final String? provinceName;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? stars;
  final Staff? staff;

  TourguideRatingLoaded({
    required this.schedules,
    this.filterText,
    this.provinceId,
    this.provinceName,
    this.startDate,
    this.endDate,
    this.stars,
    this.staff,
  });

 TourguideRatingLoaded copyWith({
  List<ScheduleStaff>? schedules,
  String? filterText,
  int? provinceId,
  String? provinceName,
  DateTime? startDate,
  DateTime? endDate,
  int? stars,
  Staff? staff, 
}) {
  return TourguideRatingLoaded(
    schedules: schedules ?? this.schedules,
    filterText: filterText ?? this.filterText,
    provinceId: provinceId ?? this.provinceId,
    provinceName: provinceName ?? this.provinceName,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    stars: stars ?? this.stars,
    staff: staff,
  );
}

}

class TourguideRatingError extends TourguideRatingState {
  final String message;
  TourguideRatingError(this.message);
}