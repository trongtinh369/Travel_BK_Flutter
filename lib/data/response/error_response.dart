// ignore_for_file: public_member_api_docs, sort_constructors_first
import "package:json_annotation/json_annotation.dart";

part "error_response.g.dart";

@JsonSerializable()
class ErrorResponse {
  final String? errorMessage;

  ErrorResponse({this.errorMessage});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
