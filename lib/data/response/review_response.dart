import 'package:booking_tour_flutter/data/response/booking_response.dart';
import 'package:booking_tour_flutter/data/response/guide_reviews_response.dart';
import 'package:booking_tour_flutter/data/response/user_response.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/review.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_response.g.dart';

@JsonSerializable()
class ReviewResponse {
  int? id;
  int? rating;
  String? content;
  DateTime? createdAt;
  UserResponse? user;
  List<GuideReviewsResponse>? guides;
  BookingResponse? booking;
  bool? isHelpful;
  int? countHelpful;

  ReviewResponse({
    this.id,
    this.rating,
    this.content,
    this.createdAt,
    this.user,
    this.guides,
    this.booking,
    this.isHelpful,
    this.countHelpful,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}

extension ReviewResponseMapper on ReviewResponse {
  Review map() {
    return Review(
      id: id ?? 0,
      rating: rating ?? 0,
      content: content ?? '',
      createdAt: createdAt ?? DateTime.now(),
      user: user?.map() ?? User.empty(),
      guideReviews: guides?.map((e) => e.map()).toList() ?? [],
      booking: booking?.map() ?? Booking.empty(),
      isHelpful: isHelpful ?? false,
      countHelpful: countHelpful ?? 0,
    );
  }
}
