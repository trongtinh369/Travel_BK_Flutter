import 'package:json_annotation/json_annotation.dart';

part 'delete_activity_response.g.dart';

@JsonSerializable()
class DeleteActivityResponse {
  final bool? data;

  DeleteActivityResponse({this.data});

  factory DeleteActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteActivityResponseFromJson(json);
}
