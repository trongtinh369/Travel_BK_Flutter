import 'package:equatable/equatable.dart';

class Province extends Equatable{
  int id;
  String name;

  Province({required this.id, required this.name});
  
  @override
  List<Object?> get props => [id, name];
}
