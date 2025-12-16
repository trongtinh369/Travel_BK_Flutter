import 'package:booking_tour_flutter/app/booking_dialog.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_activity/select_single_activity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSingleActivityCubit extends Cubit<SelectSingleActivityState> {
  SelectSingleActivityCubit() : super(SelectSingleActivityState());

  Future<void> chooseActivity() async {
    var activity = await BookingDialog.selectSingleActivity(
      locationActivityId: state.locationActivityId ?? 0,
      initActivity: state.activity,
    );
    if (activity == null) return;

    emit(state.copyWith(activity: activity));
  }

  void setActivity(Activity? activity) {
    emit(state.copyWith(activity: activity, isRemoveActivity: true));
  }

  void setLocationActivityId(int? id) {
    emit(
      state.copyWith(locationActivityId: id, isRemoveLocationActivity: true),
    );
  }
}
