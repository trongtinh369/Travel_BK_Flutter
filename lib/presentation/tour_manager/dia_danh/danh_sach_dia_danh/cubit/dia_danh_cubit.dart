import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/place.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/dia_danh/danh_sach_dia_danh/cubit/dia_danh_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiaDanhCubit extends Cubit<DiaDanhState> {
  final bookingRepository = getIt<BookingRepository>();

  DiaDanhCubit() : super(DiaDanhState(provinces: [], places: []));

  //Dữ liệu ban đầu
  Future<void> syncProvinces() async {
    var result1 = await bookingRepository.getProvinces();
    var result2 = await bookingRepository.getPlaces();

    result1.fold((failure) {}, (province) {
      emit(state.copyWith(provinces: province));
    });

    result2.fold((failure) {}, (places) {
      emit(state.copyWith(places: places));
    });
  }

  // reset tìm kiếm && tỉnh thành
  void clearSearchAndFilter({TextEditingController? searchController}) {
    emit(state.copyWith(
      filteredPlaces: state.places, 
    ));
    searchController?.clear();
  }

  void replaceLocalFakePlace(int fakeId, Place realPlace) {
    print("province: ${realPlace.province.name}");
    final updatedList =
        state.places.map((place) {
          if (place.id == fakeId) {
            return realPlace;
          }
          return place;
        }).toList();

    emit(state.copyWith(places: updatedList, filteredPlaces: updatedList));
  }

  //Chọn tỉnh thành
  void selectProvinces(Province? province) async {
    if (province == null) return;
    emit(state.copyWith(selectedProvince: province));

    final result = await bookingRepository.getPlaces(
      provinceIds: [province.id],
    );
    result.fold(
      (failure) {
        print("Lỗi khi lấy địa danh: $failure");
      },
      (places) {
        emit(state.copyWith(places: places, filteredPlaces: places));
      },
    );
  }

  // Tìm kiếm
  void filterPlaces(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredPlaces: state.places));
      return;
    }
    final filtered =
        state.places
            .where(
              (place) => place.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    emit(state.copyWith(filteredPlaces: filtered));
  }

  //Thêm
  Future<bool> addLocalPlace(Place newPlace) async {
    final updatedList = List<Place>.from(state.places)..insert(0, newPlace);
    emit(state.copyWith(places: updatedList, filteredPlaces: updatedList));

    final result = await bookingRepository.createPlace(
      name: newPlace.name,
      locationId: newPlace.province.id,
    );

    return result.fold(
      (failure) async {
        // API lỗi -> reload danh sách server
        await syncProvinces();
        return false;
      },
      (realPlace) {
        final placeWithProvince = Place(
          id: realPlace.id,
          name: realPlace.name,
          province: newPlace.province,
        );
        // Replace local fake bằng ID thật
        replaceLocalFakePlace(newPlace.id, placeWithProvince);
        return true;
      },
    );
  }

  // Cap nhat
  Future<bool> updatedLocalPlace(Place updatedPlace,) async {
    final updatedList =
        state.places.map((p) {
          if (p.id == updatedPlace.id) return updatedPlace;
          return p;
        }).toList();

    emit(state.copyWith(places: updatedList, filteredPlaces: updatedList));

    final result = await bookingRepository.updatePlace(
      id: updatedPlace.id,
      name: updatedPlace.name,
      locationId: updatedPlace.province.id,
    );

    return result.fold(
      (failure) async {
        await syncProvinces();
        return false;
      },
      (realPlace) {
        replaceLocalFakePlace(updatedPlace.id, realPlace);
        return true;
      },
    );
  }

  //Delete
  Future<bool> deletePlace(int id) async {
    // Lưu danh sách cũ
    final oldList = state.places;

    final delete = state.places.where((p) => p.id != id).toList();
    emit(state.copyWith(places: delete, filteredPlaces: delete));

    final result = await bookingRepository.deletePlace(id: id);

    return result.fold((Failure) {
      emit(state.copyWith(places: oldList, filteredPlaces: oldList));
      return false;
    }, (_) {
      return true;
    });
  }
}