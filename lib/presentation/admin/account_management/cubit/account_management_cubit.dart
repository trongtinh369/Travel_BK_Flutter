import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/admin/update_staff_request.dart';
import 'package:booking_tour_flutter/data/request/admin/user_in_staff_update_request.dart';
import 'package:booking_tour_flutter/domain/role.dart';
import 'package:booking_tour_flutter/domain/staff.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_management_state.dart';

class AccountManagementCubit extends Cubit<AccountManagementState> {
  final BookingRepository _repo;

  AccountManagementCubit({BookingRepository? repository})
    : _repo = repository ?? getIt<BookingRepository>(),
      super(const AccountManagementState());
  Future<void> loadAll() async {
    emit(state.copyWith(loading: true, error: null));
    final staffRes = await _repo.getAllStaff(0);
    final roleRes = await _repo.getAllRole();

    List<Staff> staffs = [];
    List<Role> roles = [];
    String? error;

    staffRes.fold(
      (failure) => error = failure.message,
      (result) => staffs = result,
    );

    roleRes.fold(
      (failure) => error = failure.message,
      (result) => roles = result,
    );

    final filteredStaffs = _applySearchFilter(staffs, state.searchQuery);

    emit(
      state.copyWith(
        loading: false,
        staffs: filteredStaffs,
        allStaffs: staffs,
        roles: roles,
        error: error,
      ),
    );
  }

  Future<void> loadStaffsByRole(int roleId) async {
    emit(state.copyWith(loading: true, error: null));

    final staffRes = await _repo.getAllStaff(roleId);

    List<Staff> staffs = [];
    String? error;

    staffRes.fold(
      (failure) => error = failure.message,
      (result) => staffs = result,
    );

    final filteredStaffs = _applySearchFilter(staffs, state.searchQuery);

    emit(
      state.copyWith(
        loading: false,
        staffs: filteredStaffs,
        allStaffs: staffs,
        error: error,
      ),
    );
  }

  void setSelectedStaff(Staff staff) {
    emit(state.copyWith(selectedStaff: staff));
  }

  void clearSelectedStaff() {
    emit(state.copyWith(selectedStaff: null));
  }

  Future<bool> deleteStaff(int id) async {
    emit(state.copyWith(loading: true, error: null));

    final res = await _repo.deleteStaff(id);

    bool success = false;
    String? error;

    res.fold(
      (failure) {
        error = failure.message;
        success = false;
      },
      (_) {
        success = true;
      },
    );

    emit(state.copyWith(loading: false, error: error));

    if (success) {
      await loadAll();
    }

    return success;
  }

  // Tìm kiếm
  void search(String query) {
    final searchQuery = query.trim().toLowerCase();
    final filteredStaffs = _applySearchFilter(state.allStaffs, searchQuery);
    emit(state.copyWith(searchQuery: searchQuery, staffs: filteredStaffs));
  }

  List<Staff> _applySearchFilter(List<Staff> staffs, String query) {
    if (query.isEmpty) {
      return staffs;
    }

    return staffs.where((staff) {
      final name = staff.user.name.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  // hàm này update role của staff
  Future<bool> updateStaffRole(Staff staff, int newRoleId) async {
    emit(state.copyWith(loading: true, error: null));

    final userRequest = UserInStaffUpdateRequest(
      id: staff.user.id,
      roleId: newRoleId,
      money: 0,
      bankNumber: "",
      bank: "",
      name: staff.user.name,
      email: staff.user.email,
      phone: staff.user.phone,
      avatarPath: "",
      bankBranch: "",
      refundStatus: true,
    );

    final request = UpdateStaffRequest(
      userId: staff.userId,
      code: staff.code,
      isActive: staff.isActive,
      cccd: staff.cccd,
      address: staff.address,
      dateOfBirth: staff.dateOfBirth,
      startWorkingDate: staff.startWorkingDate,
      cccdIssueDate: staff.cccdIssueDate,
      cccD_front_image: staff.cccD_front_path,
      cccD_back_image: staff.cccD_back_path,
      isRetainCCCDFront: true,
      isRetainCCCDBack: true,
      endWorkingDate: staff.endWorkingDate,
      user: userRequest,
    );

    final res = await _repo.updateStaff(request);

    bool success = false;
    String? error;

    res.fold(
      (failure) {
        error = failure.message;
        success = false;
      },
      (_) {
        success = true;
      },
    );

    emit(state.copyWith(loading: false, error: error));

    if (success) {
      await loadAll();
    }

    return success;
  }

  // này update trạng thái active của staff
  Future<bool> updateStaffStatus(Staff staff, bool isActive) async {
    emit(state.copyWith(loading: true, error: null));

    final userRequest = UserInStaffUpdateRequest(
      id: staff.user.id,
      roleId: staff.role.id,
      money: 0,
      bankNumber: "",
      bank: "",
      name: staff.user.name,
      email: staff.user.email,
      phone: staff.user.phone,
      avatarPath: "",
      bankBranch: "",
      refundStatus: true,
    );

    final request = UpdateStaffRequest(
      userId: staff.userId,
      code: staff.code,
      isActive: isActive,
      cccd: staff.cccd,
      address: staff.address,
      dateOfBirth: staff.dateOfBirth,
      startWorkingDate: staff.startWorkingDate,
      cccdIssueDate: staff.cccdIssueDate,
      cccD_front_image: staff.cccD_front_path,
      cccD_back_image: staff.cccD_back_path,
      isRetainCCCDFront: true,
      isRetainCCCDBack: true,
      endWorkingDate: staff.endWorkingDate,
      user: userRequest,
    );

    final res = await _repo.updateStaff(request);

    bool success = false;
    String? error;

    res.fold(
      (failure) {
        error = failure.message;
        success = false;
      },
      (_) {
        success = true;
      },
    );

    emit(state.copyWith(loading: false, error: error));

    if (success) {
      await loadAll();
    }

    return success;
  }

  // hàm này update thông tin của staff
  Future<bool> updateStaffInfo(Staff staff) async {
    emit(state.copyWith(loading: true, error: null));

    final userRequest = UserInStaffUpdateRequest(
      id: staff.user.id,
      roleId: staff.role.id,
      money: staff.user.money,
      bankNumber: staff.user.bankNumber,
      bank: staff.user.bank,
      name: staff.user.name,
      email: staff.user.email,
      phone: staff.user.phone,
      avatarPath: staff.user.avatarPath,
      bankBranch: staff.user.bankBranch,
      refundStatus: staff.user.refundStatus,
    );

    final request = UpdateStaffRequest(
      userId: staff.userId,
      code: staff.code,
      isActive: staff.isActive,
      cccd: staff.cccd,
      address: staff.address,
      dateOfBirth: staff.dateOfBirth,
      startWorkingDate: staff.startWorkingDate,
      cccdIssueDate: staff.cccdIssueDate,
      cccD_front_image: staff.cccD_front_path,
      cccD_back_image: staff.cccD_back_path,
      isRetainCCCDFront: true,
      isRetainCCCDBack: true,
      endWorkingDate: staff.endWorkingDate,
      user: userRequest,
    );

    final res = await _repo.updateStaff(request);

    bool success = false;
    String? error;

    res.fold(
      (failure) {
        error = failure.message;
        success = false;
      },
      (_) {
        success = true;
      },
    );

    emit(state.copyWith(loading: false, error: error));

    if (success) {
      await loadAll();
    }

    return success;
  }
}
