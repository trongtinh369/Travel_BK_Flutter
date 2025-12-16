import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_location_activity/select_single_location_activity_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_location_activity/select_single_location_activity_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/spinner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSingleLocationActivityField extends StatelessWidget {
  final void Function(LocationActivity?) onChange;
  final _cubit = SelectSingleLocationActivityCubit();
  final double? padding;
  final bool isDisable;
  final bool isShowError;
  final String? errorMessage;

  SelectSingleLocationActivityField({
    super.key,
    required this.onChange,
    LocationActivity? locationActivity,
    int? placeId,
    this.padding,
    this.isDisable = false,
    this.isShowError = false,
    this.errorMessage,
  }) {
    _cubit.setLocationActivity(locationActivity);
    _cubit.setPlaceId(placeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      SelectSingleLocationActivityCubit,
      SelectSingleLocationActivityState
    >(
      bloc: _cubit,
      listener: (context, state) => onChange(state.locationActivity),
      builder: (context, state) {
        return SpinnerDialog(
          title: "Địa điểm hoạt động",
          hint: "Chọn địa điểm hoạt động",
          padding: padding ?? 10,
          onTap: () {
            _cubit.chooseLocationActivity();
          },
          content: state.locationActivity?.name,
          isDisable: isDisable,
          isShowError: isShowError,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
