// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/activity.dart';

class SelectSingleActivityState {
  final int? locationActivityId;
  final Activity? activity;
  SelectSingleActivityState({this.locationActivityId, this.activity});

  SelectSingleActivityState copyWith({
    bool isRemoveLocationActivity = false,
    bool isRemoveActivity = false,
    int? locationActivityId,
    Activity? activity,
  }) {
    return SelectSingleActivityState(
      locationActivityId:
          locationActivityId ??
          (isRemoveLocationActivity ? null : this.locationActivityId),
      activity: activity ?? (isRemoveActivity ? null : this.activity),
    );
  }
}
