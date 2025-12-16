import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_staff_account_part1_state.dart';

class CreateStaffAccountPart1Cubit extends Cubit<CreateStaffAccountPart1State> {
  CreateStaffAccountPart1Cubit() : super(const CreateStaffAccountPart1State());

  void setRole(int roleId, String roleTitle) {
    emit(state.copyWith(roleId: roleId, selectedRole: roleTitle));
  }

  void saveData({
    required String password,
    required String name,
    required String cccd,
    String? issuedDate,
    required String email,
    required String phone,
    required String address,
    String? dob,
    String? startDate,
    required String selectedRole,
    int? roleId,
  }) {
    emit(
      state.copyWith(
        password: password,
        name: name,
        cccd: cccd,
        issuedDate: issuedDate,
        email: email,
        phone: phone,
        address: address,
        dob: dob,
        startDate: startDate,
        selectedRole: selectedRole,
        roleId: roleId,
      ),
    );
  }

  void reset() {
    emit(const CreateStaffAccountPart1State());
  }
}
