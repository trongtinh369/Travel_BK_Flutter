class TourAssignment {
  final String titleTour;
  final int price;
  final List<Location> locations;
  final List<String> tourImages;

  TourAssignment({
    required this.titleTour,
    required this.price,
    required this.locations,
    required this.tourImages,
  });

  static TourAssignment empty(){
    return TourAssignment(
      titleTour: "",
      price: 0,
      locations: [Location.empty()],
      tourImages: []
    );
  }
}

class Location {
  final String name;

  Location({required this.name});

  static Location empty(){
    return Location(
      name: ""
    );
  }
}
