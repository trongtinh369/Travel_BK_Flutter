import "package:json_annotation/json_annotation.dart";

part "update_location_activities.g.dart";

@JsonSerializable()
class UpdateLocationActivities {
  int id;
  int placeId;
  String name;
  final List<int> activityIds;

  UpdateLocationActivities({
    required this.id,
    required this.placeId,
    required this.name,
    required this.activityIds,
  });

  factory UpdateLocationActivities.fromJson(Map<String, dynamic> json) =>
      _$UpdateLocationActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateLocationActivitiesToJson(this);
}
