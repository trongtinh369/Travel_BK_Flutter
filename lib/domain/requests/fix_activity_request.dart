import "package:json_annotation/json_annotation.dart";

part "fix_activity_request.g.dart";

@JsonSerializable()
class FixActivityRequest {
  final int id;
  final String action;

  FixActivityRequest({required this.id, required this.action});

  factory FixActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$FixActivityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FixActivityRequestToJson(this);
}
