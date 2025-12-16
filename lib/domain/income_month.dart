class IncomeMonth {
  final int january;
  final int february;
  final int march;
  final int april;
  final int may;
  final int june;
  final int july;
  final int august;
  final int september;
  final int october;
  final int november;
  final int december;

  IncomeMonth({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
    required this.may,
    required this.june,
    required this.july,
    required this.august,
    required this.september,
    required this.october,
    required this.november,
    required this.december,
  });

  List<int> toList() {
    return [
      january,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september,
      october,
      november,
      december,
    ];
  }
}