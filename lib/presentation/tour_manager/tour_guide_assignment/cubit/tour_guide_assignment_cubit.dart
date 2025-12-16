import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';
import 'package:booking_tour_flutter/domain/tour_guide.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/tour_guide_assignment/cubit/tour_guide_assignment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourGuideAssignmentCubit extends Cubit<TourGuideAssignmentState> {
  static final tourGuideAssignmentTourguide = getIt<BookingRepository>();

  TourGuideAssignmentCubit()
    : super(
        TourGuideAssignmentState(
          tourGuides: [],
          schedule: ScheduleAssignmentTourguide.empty(),
          tourGuidesSearch: [],
          idSchedule: 0,
        ),
      );

  // chuyển màn set dữ liệu idSchedule vào
  void setIdSchedule({required int id}) {
    emit(state.copyWith(idSchedule: id));
  }

  // đọc dữ liệu từ api
  Future<void> loadData() async {
    var schedule = await tourGuideAssignmentTourguide.getScheduleAssignmentById(
      idSchedule: state.idSchedule,
    );

    schedule.fold((failure) {}, (schedule) {
      emit(state.copyWith(schedule: schedule));
    });

    var tourGuides = await tourGuideAssignmentTourguide.getTourGuides(
      idschedule: state.idSchedule,
    );
    tourGuides.fold((failure) {}, (tourGuides) {
      emit(
        state.copyWith(tourGuides: tourGuides, tourGuidesSearch: tourGuides),
      );
    });
  }

  // tìm kiếm hướng dẫn viên
  void searchTourGuides(String query) {
    final filteredTourGuides =
        state.tourGuides.where((guide) {
          final guideName = guide.user.name.toLowerCase() ?? '';
          final guideCode = guide.code?.toLowerCase() ?? '';
          final searchLower = query.toLowerCase();

          return guideName.contains(searchLower) ||
              guideCode.contains(searchLower);
        }).toList();

    emit(state.copyWith(tourGuidesSearch: filteredTourGuides));
  }

  void toggleTourGuideCheck(int userId, bool isChecked) {
    // cập nhập danh sách bình thường
    final updatedList =
        state.tourGuides.map((guide) {
          if (guide.userId == userId) {
            return guide.copyWith(ischecked: isChecked);
          }
          return guide;
        }).toList();

    // cập nhập danh sách search
    final updatedTourGuidesSearch =
        state.tourGuidesSearch.map((guide) {
          if (guide.userId == userId) {
            return guide.copyWith(ischecked: isChecked);
          }
          return guide;
        }).toList();

    emit(
      state.copyWith(
        tourGuides: updatedList,
        tourGuidesSearch: updatedTourGuidesSearch,
      ),
    );
  }

  // click vào button
  Future<bool> touchButton() async {
    var tourGuideResponse = state.tourGuides.map((t) => t.toRequest()).toList();

    var response = await tourGuideAssignmentTourguide.checkAssignment(
      scheduleId: state.schedule.id,
      tourGuides: tourGuideResponse,
    );

    bool isSuccess = false;

    response.fold(
      (failure) {
        isSuccess = false;
      },
      (success) {
        isSuccess = success;
      },
    );

    return isSuccess;
  }
}
