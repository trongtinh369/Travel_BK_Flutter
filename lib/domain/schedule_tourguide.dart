class ScheduleTourguide {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final String idSchedule;
  final String location;
  final int quantity;
  final String tourImages;
  ScheduleTourguide({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.idSchedule,
    required this.quantity,
    required this.tourImages,
    required this.location,
  });
}
