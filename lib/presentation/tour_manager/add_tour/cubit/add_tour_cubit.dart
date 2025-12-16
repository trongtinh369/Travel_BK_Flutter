// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_error_fields.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/validate_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_day_activity.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_day_of_tour.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_tour.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_state.dart';
import 'package:sprintf/sprintf.dart';

class _Validator {
  final List<List<Object>> Function(AddTourState)? iterate;
  final String field;
  final String? largeField;
  final String message;
  final bool Function(AddTourState, List<Object>) check;

  _Validator({
    required this.field,
    required this.message,
    required this.check,
    this.largeField,
    this.iterate,
  });
}

class AddTourCubit extends Cubit<AddTourState> {
  final _repository = getIt<BookingRepository>();
  final List<_Validator> _validators = [];

  AddTourCubit()
    : super(
        AddTourState(
          daysOfTour: [CTDayOfTour()],
          selectedDayOfTour: 0,
          tour: CTTour(),
          provinces: [],
          images: [],
        ),
      ) {
    _setupValidator();
  }

  void setState(AddTourState state) {
    emit(state);
  }

  void setId(int id) {
    emit(state.copyWith(id: id));
  }

  void rebuild() async {
    emit(state.copyWith());
  }

  void addActivity() {
    state.daysOfTour[state.selectedDayOfTour].dayActivities.add(
      CTDayActivity(),
    );

    emit(state.copyWith());
  }

  void removeActivity(int index) {
    state.daysOfTour[state.selectedDayOfTour].dayActivities.removeAt(index);
    if (state.isValidated) {
      validate();
    }

    emit(state.copyWith());
  }

  void addDayOfTour() {
    state.daysOfTour.add(CTDayOfTour());

    emit(state.copyWith());
  }

  void removeDayOfTour() {
    var newState = state;
    state.daysOfTour.removeAt(state.selectedDayOfTour);
    if (state.selectedDayOfTour >= state.daysOfTour.length - 2) {
      newState = state.copyWith(selectedDayOfTour: state.daysOfTour.length - 1);
    }

    if (state.isValidated) {
      validate();
    }
    emit(newState);
  }

  void changeSelectedDay(int selectedDay) {
    emit(state.copyWith(selectedDayOfTour: selectedDay));
  }

  void setProvinces(List<Province> provinces) {
    emit(state.copyWith(provinces: provinces));
    correctAllDayActivity();
  }

  void setImages(List<Either<File, String>> images) {
    emit(state.copyWith(images: images));
  }

  void resetState() {
    emit(
      AddTourState(
        daysOfTour: [CTDayOfTour()],
        selectedDayOfTour: 0,
        tour: CTTour(),
        provinces: [],
        images: [],
        validateState: ValidateState(errors: {}, isValidated: false),
      ),
    );
  }

  void correctAllDayActivity() {
    for (var dayOfTour in state.daysOfTour) {
      for (var dayActivity in dayOfTour.dayActivities) {
        _correctDayActivityHelper(dayActivity);
      }
    }

    emit(state.copyWith());
  }

  void correctDayActivity(CTDayActivity day) {
    _correctDayActivityHelper(day);

    emit(state.copyWith());
  }

  void _correctDayActivityHelper(CTDayActivity day) {
    _correctPlace(day);
    _correctLocationActivity(day);
    _correctActivity(day);
  }

  void _correctPlace(CTDayActivity day) {
    if (!state.provinces.contains(day.place?.province)) {
      day.place = null;
    }

    if (day.place == null) {
      day.locationActivity = null;
      day.activity = null;
    }
  }

  void _correctLocationActivity(CTDayActivity day) {
    if (day.locationActivity?.place != day.place) {
      day.locationActivity = null;
    }

    if (day.locationActivity == null) {
      day.activity = null;
    }
  }

  void _correctActivity(CTDayActivity day) {
    if (day.locationActivity == null) {
      return;
    }

    if (!day.locationActivity!.activities.contains(day.activity)) {
      day.activity = null;
    }
  }

  Future<bool> add() async {
    validate();

    if (state.validateState.errors.isNotEmpty) {
      return false;
    }

    var result = await _repository.createTour(
      tour: state.tour,
      dayOfTours: state.daysOfTour,
      images: state.images,
    );

    return result.fold(
      (failure) {
        return false;
      },
      (tour) {
        return true;
      },
    );
  }

  Future<bool> update() async {
    validate();

    if (state.validateState.errors.isNotEmpty) {
      return false;
    }

    var result = await _repository.updateTour(
      id: state.id!,
      tour: state.tour,
      dayOfTours: state.daysOfTour,
      images: state.images,
    );

    return result.fold(
      (failure) {
        return false;
      },
      (tour) {
        return true;
      },
    );
  }

  void validate() {
    ValidateState newValidateState = ValidateState(
      errors: {},
      isValidated: true,
    );
    for (var validator in _validators) {
      if (validator.iterate != null) {
        _validateIterableValidator(newValidateState, validator);
      } else {
        _validateSingleValidator(
          errorState: newValidateState,
          validator: validator,
        );
      }
    }

    emit(state.copyWith(validateState: newValidateState));
  }

  void _validateIterableValidator(
    ValidateState errorState,
    _Validator validator,
  ) {
    var params = validator.iterate!.call(state);

    for (var param in params) {
      _validateSingleValidator(
        errorState: errorState,
        validator: validator,
        param: param,
      );
    }
  }

  void _validateSingleValidator({
    required ValidateState errorState,
    required _Validator validator,
    List<Object> param = const [],
  }) {
    if (validator.check(state, param) == false) {
      var field = sprintf(validator.field, param);
      errorState.errors.addAll({field: validator.message});

      if (validator.largeField != null) {
        var largeField = sprintf(validator.largeField!, param);
        errorState.errors.addAll({largeField: validator.message});
      }
    }
  }

  void _setupValidator() {
    _setupValidatorImages();
    _setupValidatorProvince();
    _setupValidatorsTour();
    _setupValidateDaysOfTour();
    _setupValidateDaysActivity();
  }

  void _setupValidatorImages() {
    _addValidator(
      field: AddTourErrorFields.tourImages,
      message: "Vui lòng chọn hình ảnh",
      check: (state, _) {
        if (state.images.isEmpty) {
          return false;
        }

        return true;
      },
    );
  }

  void _setupValidatorsTour() {
    _addValidator(
      field: AddTourErrorFields.tourName,
      message: "Vui lòng nhập tên chuyến đi",
      check: (state, _) {
        if (state.tour.tourName.trim().isEmpty) {
          return false;
        }

        return true;
      },
    );

    _addValidator(
      field: AddTourErrorFields.tourDescription,
      message: "Vui lòng nhập mô tả chuyến đi",
      check: (state, _) {
        if (state.tour.description.trim().isEmpty) {
          return false;
        }

        return true;
      },
    );

    _addValidator(
      field: AddTourErrorFields.tourPercent,
      message: "Phần trăm đặt cọc không hợp lệ",
      check: (state, _) {
        int? percent = int.tryParse(state.tour.percent);
        if (percent != null && 0 <= percent && percent <= 100) {
          return true;
        }

        return false;
      },
    );

    _addValidator(
      field: AddTourErrorFields.tourPrice,
      message: "Số tiền chuyến đi không hợp lệ",
      check: (state, _) {
        int? price = int.tryParse(state.tour.price);
        if (price != null && 0 <= price && price <= 100000000) {
          return true;
        }

        return false;
      },
    );
  }

  void _setupValidateDaysOfTour() {
    _addValidator(
      iterate: _iterateDayOfTour,
      field: AddTourErrorFields.dayOfTourTitle,
      message: "Vui lòng nhập tiêu đề cho ngày",
      largeField: AddTourErrorFields.dayOfTour,
      check: (state, params) {
        int day = params[0] as int;
        if (state.daysOfTour[day].title.trim().isEmpty) {
          return false;
        }

        return true;
      },
    );

    _addValidator(
      iterate: _iterateDayOfTour,
      field: AddTourErrorFields.dayOfTourDescription,
      message: "Vui lòng nhập mô tả cho ngày",
      largeField: AddTourErrorFields.dayOfTour,
      check: (state, params) {
        int day = params[0] as int;
        if (state.daysOfTour[day].description.trim().isEmpty) {
          return false;
        }

        return true;
      },
    );
  }

  void _setupValidateDaysActivity() {
    _addValidator(
      iterate: _iterateDaysActivity,
      field: AddTourErrorFields.dayActivityLocationActivity,
      message: "Vui lòng nhập địa điểm hoạt động",
      largeField: AddTourErrorFields.dayOfTour,
      check: (state, params) {
        int dayTour = params[0] as int;
        int dayActivity = params[1] as int;
        if (state
                .daysOfTour[dayTour]
                .dayActivities[dayActivity]
                .locationActivity ==
            null) {
          return false;
        }

        return true;
      },
    );

    _addValidator(
      iterate: _iterateDaysActivity,
      field: AddTourErrorFields.dayActivityTime,
      message: "Vui lòng nhập thời gian",
      largeField: AddTourErrorFields.dayOfTour,
      check: (state, params) {
        int dayTour = params[0] as int;
        int dayActivity = params[1] as int;
        if (state.daysOfTour[dayTour].dayActivities[dayActivity].time == null) {
          return false;
        }

        return true;
      },
    );

    _addValidator(
      iterate: _iterateDaysActivity,
      field: AddTourErrorFields.dayActivityPlace,
      largeField: AddTourErrorFields.dayOfTour,
      message: "Vui lòng nhập địa danh",
      check: (state, params) {
        int dayTour = params[0] as int;
        int dayActivity = params[1] as int;
        if (state.daysOfTour[dayTour].dayActivities[dayActivity].place ==
            null) {
          return false;
        }

        return true;
      },
    );

    _addValidator(
      iterate: _iterateDaysActivity,
      field: AddTourErrorFields.dayActivityActivity,
      largeField: AddTourErrorFields.dayOfTour,
      message: "Vui lòng nhập hoạt động cho ngày",
      check: (state, params) {
        int dayTour = params[0] as int;
        int dayActivity = params[1] as int;
        if (state.daysOfTour[dayTour].dayActivities[dayActivity].activity ==
            null) {
          return false;
        }

        return true;
      },
    );
  }

  void _setupValidatorProvince() {
    _addValidator(
      field: AddTourErrorFields.province,
      message: "Vui lòng nhập tỉnh thành",
      check: (state, _) {
        if (state.provinces.isEmpty) {
          return false;
        }

        return true;
      },
    );
  }

  void _addValidator({
    required String field,
    required String message,
    required bool Function(AddTourState, List<Object>) check,
    String? largeField,
    List<List<Object>> Function(AddTourState state)? iterate,
  }) {
    _validators.add(
      _Validator(
        field: field,
        message: message,
        check: check,
        largeField: largeField,
        iterate: iterate,
      ),
    );
  }

  List<List<Object>> _iterateDayOfTour(AddTourState state) {
    List<List<Object>> params = [];

    for (int i = 0; i < state.daysOfTour.length; i++) {
      List<Object> param = [];
      param.add(i);
      params.add(param);
    }

    return params;
  }

  List<List<Object>> _iterateDaysActivity(AddTourState state) {
    List<List<Object>> params = [];

    for (int i = 0; i < state.daysOfTour.length; i++) {
      List<Object> param = [];
      param.add(i);
      for (int j = 0; j < state.daysOfTour[i].dayActivities.length; j++) {
        param.add(j);
        params.add(List.of(param));
        param.removeLast();
      }
    }

    return params;
  }
}
