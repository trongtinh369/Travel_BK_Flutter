import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/bank.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/user/vi/cubit/vi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViCubit extends Cubit<ViState> {
  final bookingRepository = getIt<BookingRepository>();
  ViCubit() : super(ViState(user: User.empty(), bank: []));

  // get Banks
  Future<void> syncBank() async {
    var result = await bookingRepository.getBank();

    result.fold((f) {}, (banks) {
      emit(state.copyWith(bank: banks));
    });
  }

  void selectBank(Bank bank) {
    emit(state.copyWith(selectedBank: bank));
  }

  // load data
  Future<void> syncUser(int id) async {
    var result = await bookingRepository.getUserById(id: id);

    result.fold(
      (failure) {
        print('Lỗi: ${failure.message}');
      },
      (user) {
        final hasExistingData =
            user.bank.isNotEmpty &&
            user.bankBranch.isNotEmpty &&
            user.bankNumber.isNotEmpty;
        if (hasExistingData) {
          emit(state.copyWith(showBankFields: true));
        }
        emit(state.copyWith(user: user));
      },
    );
  }

  void updateLocalField({
    required String bankName,
    required String bankBranch,
    required String bankNumber,
  }) {
    final user = state.user;

    if (bankName.isEmpty || bankBranch.isEmpty || bankNumber.isEmpty) {
      return;
    }

    final hasChanges =
        bankNumber != user.bankNumber ||
        bankName != user.bank ||
        bankBranch != user.bankBranch;

    if (hasChanges) {
      final updateUser = User(
        id: user.id,
        roleId: user.roleId,
        money: user.money,
        bankNumber: bankNumber,
        bank: bankName,
        name: user.name,
        email: user.email,
        phone: user.phone,
        avatarPath: user.avatarPath,
        bankBranch: bankBranch,
        refundStatus: user.refundStatus,
      );
      emit(state.copyWith(user: updateUser, showBankFields: true));
    }
  }

  Future<void> saveChangeUpdate() async {
    var user = state.user;
    final result = await bookingRepository.updateUserId(
      id: user.id,
      money: user.money,
      name: user.name,
      email: user.email,
      phone: user.phone,
      bank: user.bank,
      avatarPath: user.avatarPath,
      bankBranch: user.bankBranch,
      bankNumber: user.bankNumber,
      refundStatus: true
    );

    result.fold(
      (failure) {
        print("faild");
      },
      (user) {
        emit(state.copyWith(user: user));
      },
    );
  }
}
