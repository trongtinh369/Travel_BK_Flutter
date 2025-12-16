// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  int id;
  String action;

  Activity({required this.id, required this.action});

  @override
  List<Object?> get props => [id, action];
}
