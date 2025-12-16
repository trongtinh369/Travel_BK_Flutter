// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/location_activity.dart';

class SelectSingleLocationActivityState {
  final int? placeId;
  final LocationActivity? locationActivity;
  SelectSingleLocationActivityState({this.placeId, this.locationActivity});

  SelectSingleLocationActivityState copyWith({
    bool isRemovePlace = false,
    bool isRemoveLocationActivity = false,
    int? placeId,
    LocationActivity? locationActivity,
  }) {
    return SelectSingleLocationActivityState(
      placeId: placeId ?? (isRemovePlace ? null : this.placeId),
      locationActivity:
          locationActivity ??
          (isRemoveLocationActivity ? null : this.locationActivity),
    );
  }
}
