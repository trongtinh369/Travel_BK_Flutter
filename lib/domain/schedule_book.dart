class ScheduleBook {
  int id;
  DateTime startDate;
  DateTime endDate;
  int maxSlot;
  int finalPrice;

  Tour tour;
  ScheduleBook({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.maxSlot,
    required this.finalPrice,
    required this.tour,
  });

  static ScheduleBook empty() {
    return ScheduleBook(
      id: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      maxSlot: 0,
      finalPrice: 0,
      tour: Tour(title: '',percentDeposit: 0 ,locations: []),
    );
  }
}

class Tour {
  String title;
  int percentDeposit;
  List<Location> locations;
  Tour({required this.title, required this.percentDeposit, required this.locations});
}

class Location {
  String name;
  Location({required this.name});
}
