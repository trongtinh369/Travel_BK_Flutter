import 'package:booking_tour_flutter/data/request/admin/user_in_staff_update_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_staff_request.g.dart';

@JsonSerializable()
class UpdateStaffRequest {
  int userId;
  String code;
  bool isActive;
  String cccd;
  String address;
  DateTime dateOfBirth;
  DateTime startWorkingDate;
  DateTime cccdIssueDate;

  String cccD_front_image;
  String cccD_back_image;

  bool isRetainCCCDFront;
  bool isRetainCCCDBack;
  DateTime endWorkingDate;
  UserInStaffUpdateRequest user;

  UpdateStaffRequest({
    required this.userId,
    required this.code,
    required this.isActive,
    required this.cccd,
    required this.address,
    required this.dateOfBirth,
    required this.startWorkingDate,
    required this.cccdIssueDate,
    required this.cccD_front_image,
    required this.cccD_back_image,
    required this.isRetainCCCDFront,
    required this.isRetainCCCDBack,
    required this.endWorkingDate,
    required this.user,
  });

  Map<String, dynamic> toJson() => _$UpdateStaffRequestToJson(this);
}
