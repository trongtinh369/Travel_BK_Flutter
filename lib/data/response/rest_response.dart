import 'package:json_annotation/json_annotation.dart';

part 'rest_response.g.dart';

@JsonSerializable()
class RestResponse {
  dynamic data;

  RestResponse({this.data});

  factory RestResponse.fromJson(Map<String, dynamic> json) =>
      _$RestResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$RestResponseToJson(this);
}
