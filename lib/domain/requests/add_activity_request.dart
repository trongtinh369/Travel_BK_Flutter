import "package:json_annotation/json_annotation.dart";

part "add_activity_request.g.dart";

@JsonSerializable()
class AddActivityRequest {
  String action;

  AddActivityRequest({required this.action});
  factory AddActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$AddActivityRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddActivityRequestToJson(this);
}
