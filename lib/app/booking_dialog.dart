import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/domain/location_activity.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';

class BookingDialog {
  static final _repository = getIt<BookingRepository>();

  static Future<List<Province>?> selectMultiProvince({
    List<Province> initProvinces = const [],
  }) async {
    var result = await _repository.getProvinces();
    return await result.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (provinces) {
        return DialogHelper.selectMany<Province>(
          context: AppNavigator.navigatorKey.currentState!.context,
          title: "Chọn tỉnh thành",
          items: provinces,
          display: (province) {
            return province.name;
          },
          initial: initProvinces,
        );
      },
    );
  }

  static Future<Province?> selectSingleProvince({
    Province? initProvince,
  }) async {
    var result = await _repository.getProvinces();

    return await result.fold((failure) => throw Exception(failure.message), (
      provinces,
    ) {
      return DialogHelper.selectOne<Province>(
        context: AppNavigator.navigatorKey.currentState!.context,
        title: "Chọn tỉnh thành",
        items: provinces,
        display: (province) => province.name,
        initial: initProvince,
      );
    });
  }

  static Future<Activity?> selectSingleActivity({
    int? locationActivityId,
    Activity? initActivity,
  }) async {
    var result = await _repository.getActivities(
      locationActivityId: locationActivityId,
    );

    return result.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (activities) {
        return DialogHelper.selectOne(
          context: AppNavigator.currentContext,
          title: "Chọn hoạt động",
          items: activities,
          display: (activity) {
            return activity.action;
          },
          initial: initActivity,
        );
      },
    );
  }

  static Future<Place?> selectSinglePlace({
    List<int> provinceIds = const [],
    Place? initPlace,
  }) async {
    var result = await _repository.getPlaces(provinceIds: provinceIds);

    return result.fold(
      (failure) {
        throw Exception(failure);
      },
      (places) {
        return DialogHelper.selectOne(
          context: AppNavigator.currentContext,
          title: "Chọn địa danh",
          items: places,
          display: (place) {
            return place.name;
          },
          initial: initPlace,
        );
      },
    );
  }

  static Future<LocationActivity?> selectSingleLocationActivity({
    required int placeId,
    LocationActivity? initLocationActivity,
  }) async {
    var result = await _repository.getLocationActivities(placeId: placeId);

    return result.fold(
      (failure) {
        throw Exception(failure);
      },
      (locationActivities) {
        return DialogHelper.selectOne(
          context: AppNavigator.currentContext,
          title: "Chọn địa điểm hoạt động",
          items: locationActivities,
          display: (locationActivity) {
            return locationActivity.name;
          },
          initial: initLocationActivity,
        );
      },
    );
  }
}
