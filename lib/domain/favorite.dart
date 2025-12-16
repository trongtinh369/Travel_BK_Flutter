import 'package:booking_tour_flutter/domain/trip.dart';

class Favorite {
  final int userId;
  final int tourId;
  final Trip tour;

  Favorite({
    required this.userId,
    required this.tourId,
    required this.tour,
  });

  
}