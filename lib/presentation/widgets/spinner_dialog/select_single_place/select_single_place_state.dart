// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/place.dart';

class SelectSinglePlaceState {
  final Place? place;
  final List<int> provinceIds;
  SelectSinglePlaceState({this.place, required this.provinceIds});

  SelectSinglePlaceState copyWith({
    bool isRemovePlace = false,
    Place? place,
    List<int>? provinceIds,
  }) {
    return SelectSinglePlaceState(
      place: isRemovePlace ? null : place ?? this.place,
      provinceIds: provinceIds ?? this.provinceIds,
    );
  }
}
