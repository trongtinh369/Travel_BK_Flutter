import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_place/select_single_place_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_place/select_single_place_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/spinner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSinglePlaceField extends StatelessWidget {
  final void Function(Place? provinces) onChange;
  final _cubit = SelectSinglePlaceCubit();
  final double? padding;
  final bool isDisable;
  final bool isShowError;
  final String? errorMessage;

  SelectSinglePlaceField({
    super.key,
    required this.onChange,
    List<int> provinceIds = const [],
    Place? place,
    this.padding,
    this.isDisable = false,
    this.isShowError = false,
    this.errorMessage,
  }) {
    _cubit.setPlace(place);
    _cubit.setProvinceIds(provinceIds);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectSinglePlaceCubit, SelectSinglePlaceState>(
      bloc: _cubit,
      listener: (context, state) {
        onChange(state.place);
      },
      builder: (context, state) {
        return SpinnerDialog(
          title: "Địa danh",
          hint: "Chọn địa danh",
          padding: padding ?? 10,
          onTap: () {
            _cubit.choosePlace();
          },
          content: state.place?.name,
          isDisable: isDisable,
          isShowError: isShowError,
          errorMessage: errorMessage,
        );
      },
    );
  }
}
