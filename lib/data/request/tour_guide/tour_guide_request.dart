// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/response/user_response.dart';
import 'package:booking_tour_flutter/domain/tour_guide.dart';
import 'package:booking_tour_flutter/domain/user.dart';

part 'tour_guide_request.g.dart';

@JsonSerializable()
class TourGuideRequest {
  int? userId;
  bool? ischecked;
  TourGuideRequest({
    this.userId,
    this.ischecked,
  });



  Map<String, dynamic> toJson() => _$TourGuideRequestToJson(this);
}


