// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/data/request/tour/create_day_of_tour_request.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_day_activity.dart';
import 'package:booking_tour_flutter/domain/day_of_tour.dart';

class CTDayOfTour {
  String title;
  String description;
  late List<CTDayActivity> dayActivities;
  CTDayOfTour({
    this.title = "",
    this.description = "",
    List<CTDayActivity> dayActivities = const [],
  }) {
    this.dayActivities = List.from(dayActivities);
    if (this.dayActivities.isEmpty) {
      this.dayActivities.add(CTDayActivity());
    }
  }
}

extension CtDayOfTourExtension on CTDayOfTour {
  CreateDayOfTourRequest mapToRequest() {
    if (title.isEmpty || description.isEmpty || this.dayActivities.isEmpty) {
      throw Exception("can't parse create_day_of_tour_request");
    }

    var dayActivities =
        this.dayActivities.map((i) => i.mapToRequest()).toList();

    return CreateDayOfTourRequest(
      title: title,
      description: description,
      dayActivities: dayActivities,
    );
  }
}

extension DayOfTourToCTDayOfTour on DayOfTour {
  CTDayOfTour mapToCTDayOfTour() {
    return CTDayOfTour(
      dayActivities: dayActivities.map((i) => i.mapToCTDayActivity()).toList(),
      description: description,
      title: title,
    );
  }
}
