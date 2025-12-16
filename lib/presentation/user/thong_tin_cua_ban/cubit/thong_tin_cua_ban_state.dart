import 'package:booking_tour_flutter/domain/user.dart';

class ThongTinCuaBanState {
  final User user;

  ThongTinCuaBanState({
    required this.user
  });

  ThongTinCuaBanState copyWith({
    User? user
  }){
    return ThongTinCuaBanState(user: user ?? this.user);
  }
}