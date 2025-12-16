import 'package:json_annotation/json_annotation.dart';

part 'get_reviews_request.g.dart';

@JsonSerializable()
class GetReviewsRequest {
  int userId;
  int tourId;

  GetReviewsRequest({required this.userId, required this.tourId});
  Map<String, dynamic> toJson() => _$GetReviewsRequestToJson(this);
}
