import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'income_statistic_state.dart';

class IncomeCubit extends Cubit<IncomeStatisticState> {
  final BookingRepository _repository;

  IncomeCubit(this._repository) : super(IncomeStatisticInitial());

  Future<void> loadIncomeByMonth() async {
    emit(IncomeStatisticLoading());

    try {
      final result = await _repository.getIncomeByMonth();

      result.fold(
        (failure) => emit(IncomeStatisticError(failure.message)),
        (incomeMonth) {
          final monthsList = incomeMonth.toList();
          final total = monthsList.reduce((a, b) => a + b);
          final average = monthsList.isEmpty ? 0 : total ~/ monthsList.length;
          final highest = monthsList.isEmpty
              ? 0
              : monthsList.reduce((a, b) => a > b ? a : b);

          emit(
            IncomeStatisticLoaded(
              totalIcome: total,
              average: average,
              highest: highest,
              months: monthsList,
              isMonthView: true,
            ),
          );
        },
      );
    } catch (e) {
      emit(IncomeStatisticError("Đã có lỗi xảy ra: ${e.toString()}"));
    }
  }

  Future<void> loadIncomeByYear() async {
    emit(IncomeStatisticLoading());

    try {
      final result = await _repository.getIncomeByYear();

      result.fold(
        (failure) => emit(IncomeStatisticError(failure.message)),
        (incomeYears) {
          final values = incomeYears.map((item) => item.value).toList();
          final years = incomeYears.map((item) => item.year).toList();

          final total = values.isEmpty ? 0 : values.reduce((a, b) => a + b);
          final average = values.isEmpty ? 0 : total ~/ values.length;
          final highest =
              values.isEmpty ? 0 : values.reduce((a, b) => a > b ? a : b);

          emit(
            IncomeStatisticLoaded(
              totalIcome: total,
              average: average,
              highest: highest,
              months: values,
              years: years,
              isMonthView: false,
            ),
          );
        },
      );
    } catch (e) {
      emit(IncomeStatisticError("Đã có lỗi xảy ra: ${e.toString()}"));
    }
  }
}