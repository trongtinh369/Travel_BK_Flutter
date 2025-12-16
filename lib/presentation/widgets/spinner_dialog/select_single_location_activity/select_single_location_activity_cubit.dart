import 'package:booking_tour_flutter/app/booking_dialog.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_location_activity/select_single_location_activity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSingleLocationActivityCubit
    extends Cubit<SelectSingleLocationActivityState> {
  SelectSingleLocationActivityCubit()
    : super(SelectSingleLocationActivityState());

  Future<void> chooseLocationActivity() async {
    var locationActivity = await BookingDialog.selectSingleLocationActivity(
      placeId: state.placeId ?? 0,
      initLocationActivity: state.locationActivity,
    );
    if (locationActivity == null) return;

    emit(state.copyWith(locationActivity: locationActivity));
  }

  void setLocationActivity(LocationActivity? locationActivity) {
    emit(
      state.copyWith(
        locationActivity: locationActivity,
        isRemoveLocationActivity: true,
      ),
    );
  }

  void setPlaceId(int? id) {
    emit(state.copyWith(placeId: id, isRemovePlace: true));
  }
}
