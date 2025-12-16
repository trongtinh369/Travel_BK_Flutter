import 'package:json_annotation/json_annotation.dart';

part 'get_helpfull_request.g.dart';

@JsonSerializable()
class GetHelpFullRequest {
  int userId;
  int reviewId;

  GetHelpFullRequest({required this.userId, required this.reviewId});
  Map<String, dynamic> toJson() => _$GetHelpFullRequestToJson(this);
}
