import 'package:json_annotation/json_annotation.dart';

part 'update_status_booking_request.g.dart';

@JsonSerializable()
class UpdateStatusBookingRequest {
  final int id;
  final int statusId;

  UpdateStatusBookingRequest({required this.id, required this.statusId});

  Map<String, dynamic> toJson() => _$UpdateStatusBookingRequestToJson(this);
}