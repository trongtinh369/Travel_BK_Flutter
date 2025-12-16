import 'package:booking_tour_flutter/domain/favorite_post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_favorite_response.g.dart';

@JsonSerializable()
class PostFavoriteResponse {
  int? number;

  PostFavoriteResponse({this.number});

  PostFavoriteResponse postFavoriteResponseFromJson(
    Map<String, dynamic> json,
  ) => _$PostFavoriteResponseFromJson(json);
  Map<String, dynamic> postFavoriteResponseToJson() =>
      _$PostFavoriteResponseToJson(this);
}

extension PostFavoriteResponseMapper on PostFavoriteResponse {
  FavoritePost map() {
    return FavoritePost(number: number ?? 0);
  }
}
