import 'package:json_annotation/json_annotation.dart';

part 'change_booking_request.g.dart';

@JsonSerializable()
class ChangeBookingRequest {
  final int scheduleId;
  final int bookingId;
  ChangeBookingRequest({required this.scheduleId, required this.bookingId});

  Map<String, dynamic> toJson() => _$ChangeBookingRequestToJson(this);
}
