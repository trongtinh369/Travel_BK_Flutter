// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/response/user_response.dart';
import 'package:booking_tour_flutter/domain/tour_guide.dart';
import 'package:booking_tour_flutter/domain/user.dart';

part 'tour_guide_response.g.dart';

@JsonSerializable()
class TourGuideResponse {
  int? userId;
  String? code;
  bool? isActive;
  String? cccd;
  String? address;
  String? dateOfBirth;
  String? startWorkingDate;
  String? cccdIssueDate;
  String? CCCD_front_path;
  String? CCCD_back_path;
  String? endWorkingDate;

  bool? ischecked;
  UserResponse? user;

  TourGuideResponse({
    this.userId,
    this.code,
    this.isActive,
    this.cccd,
    this.address,
    this.dateOfBirth,
    this.startWorkingDate,
    this.cccdIssueDate,
    this.CCCD_front_path,
    this.CCCD_back_path,
    this.endWorkingDate,
    this.ischecked,
    this.user,
  });

  factory TourGuideResponse.fromJson(Map<String, dynamic> json) =>
      _$TourGuideResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TourGuideResponseToJson(this);
}

extension TourGuideResponseMapper on TourGuideResponse {
  TourGuide map() {
    return TourGuide(
      userId: userId ?? 0,
      code: code ?? "",
      isActive: isActive ?? false,
      cccd: cccd ?? "",
      address: address ?? "",
      dateOfBirth: DateTime.tryParse(dateOfBirth ?? "") ?? DateTime.now(),
      startWorkingDate:
          DateTime.tryParse(startWorkingDate ?? "") ?? DateTime.now(),
      cccdIssueDate: DateTime.tryParse(cccdIssueDate ?? "") ?? DateTime.now(),
      cccdFrontPath: CCCD_front_path ?? "",
      cccBackPath: CCCD_back_path ?? "",
      endWorkingDate: DateTime.tryParse(endWorkingDate ?? "") ?? DateTime.now(  ),
      ischecked: ischecked ?? false,
      user: user?.map() ?? User.empty(),
    );
  }
}
