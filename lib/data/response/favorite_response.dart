// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:booking_tour_flutter/data/response/trip_manager_response.dart';
import 'package:booking_tour_flutter/domain/favorite.dart';
import 'package:booking_tour_flutter/domain/trip.dart';

part 'favorite_response.g.dart';

@JsonSerializable()
class FavoriteResponse {
  int? userId;
  int? tourId;
  TripManagerResponse? tour;

  FavoriteResponse({this.userId, this.tourId, this.tour});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
}

extension FavoriteResponseMapper on FavoriteResponse {
  Favorite map() {
    final Trip mappedTrip =
        tour != null
            ? tour!.map()
            : Trip(
              id: 0,
              day: 0,
              title: '',
              price: 0,
              percentDeposit: 0,
              description: '',
              provinces: [],
              tourImages: [],
              dayOfTours: [],
              totalReviews: 0,
              totalStars: 0,
              places: [],
            );

    return Favorite(userId: userId ?? 0, tourId: tourId ?? 0, tour: mappedTrip);
  }
}
