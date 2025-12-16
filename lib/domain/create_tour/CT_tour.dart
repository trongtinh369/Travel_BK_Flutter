// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/data/request/tour/create_tour_request.dart';
import 'package:booking_tour_flutter/data/request/tour/update_tour_request.dart';
import 'package:booking_tour_flutter/domain/trip.dart';

class CTTour {
  String tourName;
  String description;
  String price;
  String percent;

  CTTour({
    this.tourName = "",
    this.description = "",
    this.price = "",
    this.percent = "",
  });
}

extension CTMapper on CTTour {
  CreateTourRequest mapToCreateRequest() {
    var priceValue = int.tryParse(price);
    var percentValue = int.tryParse(percent);

    if (tourName.isEmpty ||
        description.isEmpty ||
        priceValue == null ||
        percentValue == null) {
      throw Exception("can't create create_tour_request");
    }

    return CreateTourRequest(
      day: 0,
      title: tourName,
      price: priceValue,
      percentDeposit: percentValue,
      description: description,
      dayOfTours: [],
    );
  }

  UpdateTourRequest mapToUpdateRequest() {
    var priceValue = int.tryParse(price);
    var percentValue = int.tryParse(percent);

    if (tourName.isEmpty ||
        description.isEmpty ||
        priceValue == null ||
        percentValue == null) {
      throw Exception("can't create create_tour_request");
    }

    return UpdateTourRequest(
      id: 0,
      day: 0,
      title: tourName,
      price: priceValue,
      percentDeposit: percentValue,
      description: description,
      dayOfTours: [],
      tourImages: [],
      retainImages: [],
    );
  }
}

extension TripToCTTour on Trip {
  CTTour mapToCTTour() {
    return CTTour(
      tourName: title,
      description: description,
      price: price.toString(),
      percent: percentDeposit.toString(),
    );
  }
}
