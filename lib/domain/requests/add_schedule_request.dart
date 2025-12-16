import "package:json_annotation/json_annotation.dart";

part "add_schedule_request.g.dart";

@JsonSerializable()
class AddScheduleRequest {
  int tourId;
  String startDate;
  String endDate;
  String openDate;
  int maxSlot;
  int finalPrice;
  String gatheringTime;
  String code;
  int desposit;

  AddScheduleRequest({
    required this.tourId,
    required this.startDate,
    required this.endDate,
    required this.openDate,
    required this.maxSlot,
    required this.finalPrice,
    required this.gatheringTime,
    required this.code,
    required this.desposit,
  });

  Map<String, dynamic> toJson() {
    return {
      "tourId": tourId,
      "startDate": startDate,
      "endDate": endDate,
      "openDate": openDate,
      "maxSlot": maxSlot,
      "finalPrice": finalPrice,
      "gatheringTime": gatheringTime,
      "code": code,
      "desposit": desposit,
    };
  }
}
