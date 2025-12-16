// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:booking_tour_flutter/domain/user.dart';

abstract class AccountantRefundState {}

class AccountantRefundInit extends AccountantRefundState {}

class AccountantRefundLoading extends AccountantRefundState {
  final List<User> users;
  AccountantRefundLoading({this.users = const []});
}

class AccountantRefundError extends AccountantRefundState {
  final String errorMessage;

  AccountantRefundError({required this.errorMessage});
}

class AccountantRefundLoaded extends AccountantRefundState {
  final List<User> users;

  AccountantRefundLoaded({required this.users});
}
