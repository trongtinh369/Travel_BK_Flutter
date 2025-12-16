import 'package:json_annotation/json_annotation.dart';

part 'trip_manager_request.g.dart';
@JsonSerializable()
class DeleteTripRequest {
  final int id; 

  DeleteTripRequest({required this.id}); 

  factory DeleteTripRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteTripRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteTripRequestToJson(this);
}