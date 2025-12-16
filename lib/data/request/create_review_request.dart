import 'package:json_annotation/json_annotation.dart';

part 'create_review_request.g.dart';

@JsonSerializable()
class CreateReviewRequest {
  int userId;
  int scheduleId;
  int rating;
  String content;

  CreateReviewRequest({
    required this.userId,
    required this.scheduleId,
    required this.rating,
    required this.content,
  });

  Map<String, dynamic> toJson() => _$CreateReviewRequestToJson(this);
}
