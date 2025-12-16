import 'package:booking_tour_flutter/domain/schedule_assignment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule_assignment_response.g.dart';

@JsonSerializable()
class ScheduleAssignmentResponse {
  int? id;
  String? code;
  DateTime? startDate;
  DateTime? endDate;
  bool? isAssignment;


  ScheduleAssignmentResponse({
    this.id,
    this.code,
    this.startDate,
    this.endDate,
    this.isAssignment,
  });

  factory ScheduleAssignmentResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleAssignmentResponseFromJson(json);

}

extension ScheduleAssignmentResponseMapper
    on ScheduleAssignmentResponse {
  ScheduleAssignment map() {
    return ScheduleAssignment(
      id: id ?? 0,
      code: code ?? '',
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
      isAssignment: isAssignment ?? false,
    );
  }
}
