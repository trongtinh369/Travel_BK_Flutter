import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/network/dio/failure.dart';
import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/schedule_user_completed.dart';
import 'package:booking_tour_flutter/presentation/profile/review_schedule/cubit/review_schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScheduleCubit extends Cubit<ReviewScheduleState> {
  final BookingRepository _repository = getIt<BookingRepository>();
  ReviewScheduleCubit() : super(ReviewScheduleState(stars: 5, review: ""));

  void setUserId(int userId) {
    emit(state.copyWith(userId: userId));
  }

  void setSchedule(ScheduleTourmanager schedule) {
    emit(state.copyWith(schedule: schedule));
  }

  void setStars(int stars) {
    emit(state.copyWith(stars: stars));
  }

  void setComment(String review) {
    state.review = review;
  }

  void resetState() {
    emit(ReviewScheduleState(stars: 5, review: ""));
  }

  void setIsSent(bool isSent) {
    emit(state.copyWith(isSent: isSent));
  }

  void setIsBack(bool isBack) {
    emit(state.copyWith(isBack: isBack));
  }

  void setIsLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  Future<void> getData() async {
    setIsLoading(true);
    var result = await _repository.getSpecifiedReview(
      userId: state.userId,
      scheduleId: state.schedule!.id,
    );

    result.fold(
      (failure) async {
        await DialogHelper.showInformDialog(
          Text("Lỗi trong quá trình đọc đánh giá từ server"),
        );
        setIsLoading(false);
      },
      (review) {
        if (review != null) {
          emit(
            state.copyWith(
              stars: review.rating,
              isSent: true,
              review: review.content,
            ),
          );
        }
        setIsLoading(false);
      },
    );
  }

  Future<void> sendReview() async {
    await DialogHelper.showLoadingDialog();
    var result = await _repository.createReview(
      userId: state.userId,
      scheduleId: state.schedule!.id,
      content: state.review.trim(),
      rating: state.stars,
    );

    result.fold((failure) {}, (success) {
      emit(state.copyWith(isSent: true, isBack: true));
    });
    DialogHelper.dismissDialog();
  }
}
