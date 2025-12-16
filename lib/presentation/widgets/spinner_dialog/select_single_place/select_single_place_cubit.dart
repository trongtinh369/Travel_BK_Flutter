import 'package:booking_tour_flutter/app/booking_dialog.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_place/select_single_place_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSinglePlaceCubit extends Cubit<SelectSinglePlaceState> {
  SelectSinglePlaceCubit()
    : super(SelectSinglePlaceState(place: null, provinceIds: []));

  void setProvinceIds(List<int> provinceIds) {
    var newState = state.copyWith(provinceIds: provinceIds);

    emit(newState);
  }

  Future<void> choosePlace() async {
    var newPlace = await BookingDialog.selectSinglePlace(
      provinceIds: state.provinceIds,
      initPlace: state.place,
    );
    if (newPlace == null) return;

    emit(state.copyWith(place: newPlace));
  }

  void setPlace(Place? place) {
    emit(state.copyWith(place: place, isRemovePlace: place == null));
  }
}
