import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:get_it/get_it.dart';
import 'hoat_dong_state.dart';

class HoatDongCubit extends Cubit<HoatDongState> {
  static final _repository = GetIt.instance<BookingRepository>();

  HoatDongCubit() : super(HoatDongInitial());

  // Lấy danh sách hoạt động
  Future<void> loadActivities() async {
    emit(HoatDongLoading());

    try {
      final result = await _repository.getActivities();

      result.fold(
        (failure) => emit(HoatDongError(message: failure.message)),
        (activities) => emit(HoatDongLoaded(activities: activities)),
      );
    } catch (e) {
      emit(
        HoatDongError(message: 'Có lỗi xảy ra khi tải danh sách hoạt động: $e'),
      );
    }
  }

  // Thêm hoạt động mới
  Future<void> addActivity(String action) async {
    if (state is! HoatDongLoaded) return;

    final currentState = state as HoatDongLoaded;
    emit(currentState.copyWith(isLoading: true));

    final result = await _repository.postActivity(action);

    result.fold(
      (failure) {
        emit(HoatDongError(message: failure.message));
        emit(currentState.copyWith(isLoading: false));
      },
      (activities) async {
        emit(
          HoatDongSuccess(
            message: 'Thêm hoạt động thành công',
            activities: currentState.activities,
          ),
        );
        await loadActivities();
      },
    );
  }

  // Cập nhật hoạt động
  Future<void> updateActivity(int activityId, String newAction) async {
    if (state is! HoatDongLoaded) return;

    final currentState = state as HoatDongLoaded;
    emit(currentState.copyWith(isLoading: true, error: null));

    final result = await _repository.putActivity(activityId, newAction);

    result.fold(
      (failure) {
        emit(currentState.copyWith(isLoading: false, error: failure.message));
      },
      (activities) async {
        emit(
          HoatDongSuccess(
            message: 'Cập nhật hoạt động thành công',
            activities: currentState.activities,
          ),
        );
        await loadActivities();
      },
    );
  }

  // Xóa hoạt động
  Future<void> deleteActivity(int activityId) async {
    if (state is! HoatDongLoaded) return;

    final currentState = state as HoatDongLoaded;
    emit(currentState.copyWith(isLoading: true, error: null));

    final result = await _repository.deleteActivity(activityId);

    result.fold(
      (failure) {
        emit(HoatDongError(message: "Không thể xóa hoạt động"));
        emit(currentState.copyWith(isLoading: false));
      },
      (success) async {
        if (success) {
          emit(
            HoatDongSuccess(
              message: 'Xóa hoạt động thành công',
              activities: currentState.activities,
            ),
          );
          await loadActivities();
        } else {
          emit(currentState.copyWith(isLoading: false, error: 'Xóa thất bại'));
        }
      },
    );
  }

  // Làm mới danh sách
  Future<void> refreshActivities() async {
    await loadActivities();
  }

  // Xóa thông báo lỗi
  void clearError() {
    if (state is HoatDongLoaded) {
      final currentState = state as HoatDongLoaded;
      emit(currentState.copyWith(error: null));
    }
  }

  // Xóa thông báo thành công
  void clearSuccess() {
    if (state is HoatDongSuccess) {
      final successState = state as HoatDongSuccess;
      emit(HoatDongLoaded(activities: successState.activities));
    }
  }
}
