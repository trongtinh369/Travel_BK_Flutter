import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/thong_tin_cua_ban/cubit/thong_tin_cua_ban_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThongTinCuaBanCubit extends Cubit<ThongTinCuaBanState> {
  final bookingRepository = getIt<BookingRepository>();

  ThongTinCuaBanCubit() : super(ThongTinCuaBanState(user: User.empty()));

  // load data
  Future<void> syncUser(int id) async {
    var result = await bookingRepository.getUserById(id: id);

    result.fold(
      (failure) {
        print('Lỗi: ${failure.message}');
      },
      (user) {
        emit(state.copyWith(user: user));
      },
    );
  }

  void updateLocalFeild(String label, String newValue) {
    final user = state.user;

    final updateUser = User(
      id: user.id,
      roleId: user.roleId,
      money: user.money,
      bankNumber: user.bankNumber,
      bank: user.bank,
      name: label == "Tên" ? newValue : user.name,
      email: label == "Email" ? newValue : user.email,
      phone: label == "SDT" ? newValue : user.phone,
      avatarPath: user.avatarPath,
      bankBranch: user.bankBranch,
      refundStatus: user.refundStatus
    );
    emit(state.copyWith(user: updateUser));
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
      refundStatus: user.refundStatus
    );

    var cubitAuth = AppNavigator.currentContext.read<AuthCubit>();
    cubitAuth.setUser(user);

    result.fold((failure){
      print("faild");
    }, (user){
      emit(state.copyWith(user: user));
    });
  }
}
