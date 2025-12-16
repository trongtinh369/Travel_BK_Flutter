abstract class IncomeStatisticState {}

class IncomeStatisticInitial extends IncomeStatisticState {}

class IncomeStatisticLoading extends IncomeStatisticState {}

class IncomeStatisticLoaded extends IncomeStatisticState {
  final int totalIcome;
  final int average;
  final int highest;
  final List<int> months;
  final List<String>? years;
  final bool isMonthView;

  IncomeStatisticLoaded({
    required this.totalIcome,
    required this.average,
    required this.highest,
    required this.months,
    this.years,
    this.isMonthView = true,
  });
}

class IncomeStatisticError extends IncomeStatisticState {
  final String message;
  IncomeStatisticError(this.message);
}