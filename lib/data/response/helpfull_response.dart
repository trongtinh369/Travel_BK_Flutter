import 'package:booking_tour_flutter/domain/helpful.dart';
import 'package:json_annotation/json_annotation.dart';
part 'helpfull_response.g.dart';

@JsonSerializable()
class HelpfullResponse {
  bool? isEnable;
  int? userId;
  int? reviewId;

  HelpfullResponse({this.isEnable, this.userId, this.reviewId});

  factory HelpfullResponse.fromJson(Map<String, dynamic> json) =>
      _$HelpfullResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HelpfullResponseToJson(this);
}

extension HelpfullResponseMapper on HelpfullResponse {
  Helpful toEntity() {
    return Helpful(
      isEnable: isEnable ?? false,
      userId: userId ?? 0,
      reviewId: reviewId ?? 0,
    );
  }
}
