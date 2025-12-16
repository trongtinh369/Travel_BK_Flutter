import 'package:booking_tour_flutter/domain/schedule_review.dart';
import 'package:booking_tour_flutter/data/response/user_response.dart'; // ✅ Import UserResponse từ file đã có

class ScheduleReviewResponse {
  final int id;
  final int rating;
  final String content;
  final String createdAt;
  final int countHelpful;
  final bool isHelpful;
  final UserResponse user;

  ScheduleReviewResponse({
    required this.id,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.countHelpful,
    required this.isHelpful,
    required this.user,
  });

  factory ScheduleReviewResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleReviewResponse(
      id: json['id'] ?? 0,
      rating: json['rating'] ?? 0,
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? '',
      countHelpful: json['countHelpful'] ?? 0,
      isHelpful: json['isHelpful'] ?? false,
      user: UserResponse.fromJson(json['user'] ?? {}),
    );
  }

  ScheduleReview map() {
    return ScheduleReview(
      id: id,
      rating: rating,
      content: content,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      countHelpful: countHelpful,
      isHelpful: isHelpful,
      user: user.map(), 
    );
  }
}

