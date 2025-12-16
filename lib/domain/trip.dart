import 'package:booking_tour_flutter/domain/day_of_tour.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';

class Trip {
  final int id;
  final int day;
  final String title;
  final int price;
  final int percentDeposit;
  final String description;
  final List<Province> provinces;
  final List<String> tourImages;
  final List<DayOfTour> dayOfTours;
  final int totalReviews;
  final int totalStars;
  final List<Place> places;
  Trip({
    required this.id,
    required this.day,
    required this.title,
    required this.price,
    required this.percentDeposit,
    required this.description,
    required this.provinces,
    required this.tourImages,
    required this.dayOfTours,
    required this.totalReviews,
    required this.totalStars,
    required this.places,
  });

  factory Trip.empty() {
    return Trip(
      id: 0,
      day: 0,
      title: "",
      price: 0,
      percentDeposit: 0,
      description: "",
      provinces: [],
      tourImages: [],
      dayOfTours: [],
      totalReviews: 0,
      totalStars: 0,
      places: [],
    );
  }
}
