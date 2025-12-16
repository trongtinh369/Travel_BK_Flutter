
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';

class  Assignment {
final int id;
final String title ;
final Place placeNames ;
final Province locations;
final String tourImages; 
Assignment(
  {
    required this.id,
    required this.title,
    required this.placeNames,
    required this.locations,
    required this.tourImages
  }
);

}
