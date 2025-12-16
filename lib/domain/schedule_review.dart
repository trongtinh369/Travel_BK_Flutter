// Trong domain/schedule_review.dart
import 'package:booking_tour_flutter/domain/user.dart'; // ✅ Import User từ domain

class ScheduleReview {
  final int id;
  final int rating;
  final String content;
  final DateTime createdAt;
  final int countHelpful;
  final bool isHelpful;
  final User user; 

  ScheduleReview({
    required this.id,
    required this.rating,
    required this.content,
    required this.createdAt,
    required this.countHelpful,
    required this.isHelpful,
    required this.user,
  });
}

