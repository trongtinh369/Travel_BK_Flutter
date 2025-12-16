// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/province.dart';

class SelectMulProvinceState {
  final List<Province> provinces;

  SelectMulProvinceState({required this.provinces});

  SelectMulProvinceState copyWith({List<Province>? provinces}) {
    return SelectMulProvinceState(provinces: provinces ?? this.provinces);
  }
}
