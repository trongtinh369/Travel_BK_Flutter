import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_activity/select_single_activity_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_activity/select_single_activity_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/spinner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSingleActivityField extends StatelessWidget {
  final void Function(Activity?) onChange;
  final _cubit = SelectSingleActivityCubit();
  final double? padding;
  final bool isDisable;
  final bool isShowError;
  final String? errorMessage;

  SelectSingleActivityField({
    super.key,
    required this.onChange,
    Activity? activity,
    int? locationActivityId,
    this.padding,
    this.isDisable = false,
    this.isShowError = false,
    this.errorMessage,
  }) {
    _cubit.setActivity(activity);
    _cubit.setLocationActivityId(locationActivityId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectSingleActivityCubit, SelectSingleActivityState>(
      bloc: _cubit,
      listener: (context, state) {
        onChange(state.activity);
      },
      builder: (context, state) {
        return SpinnerDialog(
          title: "Hoạt động",
          hint: "Chọn Hoạt động",
          padding: padding ?? 10,
          onTap: () {
            _cubit.chooseActivity();
          },
          content: state.activity?.action,
          isDisable: isDisable,
          isShowError: isShowError,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
