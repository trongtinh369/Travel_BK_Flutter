// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'booking_schedule_request.g.dart';

@JsonSerializable()
class BookingScheduleRequest {
  int scheduleId;
  int userId;
  int numPeople;
  String email;
  String phone;
  int totalPrice;
  BookingScheduleRequest({
    required this.scheduleId,
    required this.userId,
    required this.numPeople,
    required this.email,
    required this.phone,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => _$BookingScheduleRequestToJson(this);
}
