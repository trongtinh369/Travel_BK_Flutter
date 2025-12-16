import 'package:booking_tour_flutter/domain/province.dart';

class SuaDiaDanhState {
  final String? name;
  final List<Province> provinces;
  final Province? province;
  final String? error;
  final String? successMessage;

  SuaDiaDanhState({
    this.name,
    this.provinces = const [],
    this.province,
    this.error,
    this.successMessage,
  });

  SuaDiaDanhState copyWith({
    String? name,
    List<Province>? provinces,
    Province? province,
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return SuaDiaDanhState(
      name: name ?? this.name,
      provinces: provinces ?? this.provinces,
      province: province ?? this.province,
      error: error,
      successMessage: successMessage,
    );
  }
}
