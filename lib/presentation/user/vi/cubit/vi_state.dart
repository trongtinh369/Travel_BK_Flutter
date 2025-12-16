import 'package:booking_tour_flutter/domain/bank.dart';
import 'package:booking_tour_flutter/domain/user.dart';

class ViState {
  final User user;
  final List<Bank> bank;
  final Bank? selectedBank;
  final bool? showBankFields;

  ViState({required this.user, required this.bank, this.selectedBank,this.showBankFields = false,});

  ViState copyWith({User? user, List<Bank>? bank, Bank? selectedBank,bool? showBankFields,}) {
    return ViState(
      user: user ?? this.user,
      bank: bank ?? this.bank,
      selectedBank: selectedBank ?? this.selectedBank,
      showBankFields: showBankFields ?? this.showBankFields,
    );
  }
}
