import 'package:json_annotation/json_annotation.dart';

part 'create_day_activity_request.g.dart';

@JsonSerializable(createFactory: false)
class CreateDayActivityRequest {
  int activityId;
  int locationActivityId;
  String time;

  CreateDayActivityRequest({
    required this.activityId,
    required this.locationActivityId,
    required this.time,
  });

  Map<String, dynamic> toJson() => _$CreateDayActivityRequestToJson(this);
}
