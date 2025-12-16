// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/guide_reviews.dart';
import 'package:booking_tour_flutter/domain/user.dart';

class Review {
  final int id;
  final int rating;
  final String content;
  final DateTime createdAt;
  final User user;
  final List<GuideReviews> guideReviews;
  final Booking booking;
  final bool isHelpful;
  final int countHelpful;
  Review({
    required this.id,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.user,
    required this.guideReviews,
    required this.booking,
    required this.isHelpful,
    required this.countHelpful,
  });
}
