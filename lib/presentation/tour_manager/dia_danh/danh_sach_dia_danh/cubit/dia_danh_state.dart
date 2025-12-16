import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';

class DiaDanhState {
  final List<Province> provinces;
  final List<Place> places;
  final Province? selectedProvince;
  final List<Place>? filteredPlaces;

  DiaDanhState({
    required this.provinces,
    required this.places,
    this.selectedProvince,
    this.filteredPlaces,
  });

  DiaDanhState copyWith({
    List<Province>? provinces,
    List<Place>? places,
    List<Place>? filteredPlaces,
    Province? selectedProvince,
  }) {
    return DiaDanhState(
      provinces: provinces ?? this.provinces,
      places: places ?? this.places,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      filteredPlaces: filteredPlaces ?? this.filteredPlaces
    );
  }
}
