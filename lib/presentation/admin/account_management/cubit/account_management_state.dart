import 'package:booking_tour_flutter/domain/role.dart';
import 'package:booking_tour_flutter/domain/staff.dart';
import 'package:equatable/equatable.dart';

class AccountManagementState extends Equatable {
  final List<Staff> staffs;
  final List<Staff> allStaffs;
  final List<Role> roles;
  final Staff? selectedStaff;
  final bool loading;
  final String? error;
  final String searchQuery;

  const AccountManagementState({
    this.staffs = const [],
    this.allStaffs = const [],
    this.roles = const [],
    this.selectedStaff,
    this.loading = false,
    this.error,
    this.searchQuery = "",
  });

  AccountManagementState copyWith({
    List<Staff>? staffs,
    List<Staff>? allStaffs,
    List<Role>? roles,
    Staff? selectedStaff,
    bool? loading,
    String? error,
    String? searchQuery,
  }) {
    return AccountManagementState(
      staffs: staffs ?? this.staffs,
      allStaffs: allStaffs ?? this.allStaffs,
      roles: roles ?? this.roles,
      selectedStaff: selectedStaff,
      loading: loading ?? this.loading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    staffs,
    allStaffs,
    roles,
    selectedStaff,
    loading,
    error,
    searchQuery,
  ];
}
