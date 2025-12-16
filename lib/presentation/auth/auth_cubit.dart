import 'package:booking_tour_flutter/domain/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<User> {
  AuthCubit() : super(User.empty());

  void setUser(User user) {
    emit(user);
  }

  void logout() {
    emit(User.empty());
  }

  int get userId => state.id;
}