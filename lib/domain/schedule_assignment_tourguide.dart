class ScheduleAssignmentTourguide {
  final int id;
  final int tourId;
  final DateTime startDate;
  final DateTime endDate;
  final int maxSlot;
  final String code;
  final Tour tour;

  ScheduleAssignmentTourguide({
    required this.id,
    required this.tourId,
    required this.startDate,
    required this.endDate,
    required this.code,
    required this.maxSlot,
    required this.tour,
  });

  static ScheduleAssignmentTourguide empty() {
    return ScheduleAssignmentTourguide(
      id: 0,
      tourId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      code: '',
      maxSlot: 0,
      tour: Tour(title: '', locations: [], description: ''),
    );
  }

  ScheduleAssignmentTourguide copyWith({
    int? id,
    int? tourId,
    DateTime? startDate,
    DateTime? endDate,
    String? code,
    int? maxSlot,
    Tour? tour,
  }) {
    return ScheduleAssignmentTourguide(
      id: id ?? this.id,
      tourId: tourId ?? this.tourId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      code: code ?? this.code,
      maxSlot: maxSlot ?? this.maxSlot,
      tour: tour ?? this.tour,
    );
  }
}

class Tour {
  final String title;
  final String description;
  final List<Location> locations;
  Tour({
    required this.title,
    required this.locations,
    required this.description,
  });

  static Tour empty() {
    return Tour(title: '', locations: [], description: '');
  }
}

class Location {
  final String name;

  Location({required this.name});
}
