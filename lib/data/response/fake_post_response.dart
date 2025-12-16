import 'package:booking_tour_flutter/domain/fake_post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fake_post_response.g.dart';

@JsonSerializable(createToJson: false)
class FakePostResponse {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  FakePostResponse({this.userId, this.id, this.title, this.body});

  factory FakePostResponse.fromJson(Map<String, dynamic> json) =>
      _$FakePostResponseFromJson(json);
}

extension FakePostResponseMap on FakePostResponse {
  FakePost map() {
    return FakePost(
      userId: userId ?? 0,
      id: id ?? 0,
      title: title ?? "",
      body: body ?? "",
    );
  }
}
