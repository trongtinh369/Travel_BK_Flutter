class ScheduleAssignment {
  final int id;
  final String code;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAssignment;

  ScheduleAssignment({
    required this.id,
    required this.code,
    required this.startDate,
    required this.endDate,
    required this.isAssignment,
  });

  static ScheduleAssignment empty() {
    return ScheduleAssignment(
      id: 0,
      code: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      isAssignment: false,
    );
  }

  ScheduleAssignment copyWith({
    int? id,
    String? code,
    DateTime? startDate,
    DateTime? endDate,
    bool? isAssignment,
  }) {
    return ScheduleAssignment(
      id: id ?? this.id,
      code: code ?? this.code,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isAssignment: isAssignment ?? this.isAssignment,
    );
  }

  
}