import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/cubit/accountant_refund_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantRefundCubit extends Cubit<AccountantRefundState> {
  final _repository = getIt<BookingRepository>();
  AccountantRefundCubit() : super(AccountantRefundInit());

  Future<void> getData() async {
    emit(AccountantRefundLoading());

    var result = await _repository.getRefundUsers();

    result.fold(
      (failure) {
        emit(
          AccountantRefundError(errorMessage: "Lỗi trong quá trình xảy ra lỗi"),
        );
      },
      (users) {
        emit(AccountantRefundLoaded(users: users));
      },
    );
  }

  Future<void> submitRefund(int userId) async {
    await DialogHelper.showLoadingDialog();

    var result = await _repository.submitRefund(userId);
    result.fold(
      (failure) async {
        await DialogHelper.showInformDialog(
          Text("Lỗi trong quá trình xác nhận đã hoàn tiền"),
        );
        DialogHelper.dismissDialog();
      },
      (user) {
        AccountantRefundState newState;
        if (state is AccountantRefundLoaded) {
          newState = AccountantRefundLoaded(
            users: (state as AccountantRefundLoaded).users..remove(user),
          );
        } else {
          newState = AccountantRefundLoaded(
            users: (state as AccountantRefundLoading).users..remove(user),
          );
        }
        emit(newState);
        DialogHelper.dismissDialog();
      },
    );
  }
}
