// ignore_for_file: public_member_api_docs, sort_constructors_first

class ScheduleDetail {
  DateTime startDate;
  DateTime endDate;
  int maxSlot;
  Tour tour;
  
  ScheduleDetail({
    required this.startDate,
    required this.endDate,
    required this.maxSlot,
    required this.tour,
  });

  static ScheduleDetail empty() {
    return ScheduleDetail(
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      maxSlot: 0,
      tour: Tour(day: 0, title: '', dayOfTours: []),
    );
  }

  copyWith({
    DateTime? startDate,
    DateTime? endDate,
    int? maxSlot,
    Tour? tour,
  }) {
    return ScheduleDetail(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      maxSlot: maxSlot ?? this.maxSlot,
      tour: tour ?? this.tour,
    );
  }
}

class Tour {
  int day;
  String title;
  List<DayOfTour> dayOfTours;
  Tour({
    required this.day,
    required this.title,
    required this.dayOfTours,
  });
  
 
}

class DayOfTour {
  String title;
  String description;
  List<DayActivitie> dayActivities;
  DayOfTour({
    required this.title,
    required this.description,
    required this.dayActivities,
  });
  static DayOfTour empty() {
    return DayOfTour(
      title: '',
      description: '',
      dayActivities: [],
    );
  }

}

class DayActivitie {
  Activity activity;
  LocationActivity locationActivity;
  String time;
  DayActivitie({
    required this.activity,
    required this.locationActivity,
    required this.time,
  });
  static DayActivitie empty() {
    return DayActivitie(
      activity: Activity.empty(),
      locationActivity: LocationActivity.empty(),
      time: '',
    );
  }
}

class Activity {
  String action;
  Activity({
    required this.action,
  });
  static Activity empty() {
    return Activity(action: '');
  }
}

class LocationActivity {
  String name;
  LocationActivity({
    required this.name,
  });

  static LocationActivity empty() {
    return LocationActivity(name: '');
  }
}
