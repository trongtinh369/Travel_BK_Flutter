import 'package:booking_tour_flutter/domain/user.dart';

class LoginState{
  final User user;
  final bool login;

  
  LoginState({required this.user, this.login = false});

  LoginState copyWith({User? user}){
    return LoginState(user:  user ?? this.user, login: true);
  }
  
  LoginState copyWithError(){
    return LoginState(user: User.empty(), login: false);
  }
}