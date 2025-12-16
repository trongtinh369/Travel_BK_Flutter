import "package:json_annotation/json_annotation.dart";

part "update_schedule_request.g.dart";

@JsonSerializable()
class UpdateScheduleRequest {
  int id;
  int tourId;
  String startDate;
  String endDate;
  String openDate;
  int maxSlot;
  int finalPrice;
  String gatheringTime;
  String code;
  int desposit;

  UpdateScheduleRequest({
    required this.id,
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
      "id": id,
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
