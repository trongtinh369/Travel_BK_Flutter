import 'dart:io';

import 'package:booking_tour_flutter/app/app_encode_helper.dart';
import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/data/request/admin/new_staff_request.dart';
import 'package:booking_tour_flutter/data/request/admin/user_request.dart';
import 'package:booking_tour_flutter/presentation/admin/create_staff_account/cubit/create_staff_account_part1_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'create_staff_account_part2_state.dart';

class CreateStaffAccountPart2Cubit extends Cubit<CreateStaffAccountPart2State> {
  final BookingRepository _repository;
  final ImagePicker _picker = ImagePicker();

  CreateStaffAccountPart2Cubit({BookingRepository? repository})
    : _repository = repository ?? getIt<BookingRepository>(),
      super(const CreateStaffAccountPart2State());

  // hàm lấy ảnh
  Future<void> pickImage(ImageSource source, {required bool isFront}) async {
    try {
      final picked = await _picker.pickImage(source: source, imageQuality: 85);
      if (picked != null) {
        if (isFront) {
          emit(state.copyWith(frontPath: picked.path));
        } else {
          emit(state.copyWith(backPath: picked.path));
        }
      }
    } catch (_) {}
  }

  // hàm xoá ảnh
  void removeImage({required bool isFront}) {
    if (isFront) {
      emit(state.copyWith(frontPath: null));
    } else {
      emit(state.copyWith(backPath: null));
    }
  }

  void reset() {
    emit(const CreateStaffAccountPart2State());
  }

  // Helper to parse date from dd/MM/yyyy format
  DateTime? _parseDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateFormat('dd/MM/yyyy').parse(dateStr);
    } catch (_) {
      return null;
    }
  }

  // hàm tạo tài khoản
  Future<bool> createStaff(CreateStaffAccountPart1State part1Data) async {
    emit(state.copyWith(submitting: true, errorMessage: null));

    final roleId = part1Data.roleId ?? 2;
    final dateOfBirth = _parseDate(part1Data.dob) ?? DateTime.now();
    final startWorkingDate = _parseDate(part1Data.startDate) ?? DateTime.now();
    final cccdIssueDate = _parseDate(part1Data.issuedDate) ?? DateTime.now();
    final endWorkingDate = DateTime.now();

    // Convert ảnh sang base64
    String frontImage = "";
    String backImage = "";

    if (state.frontPath != null) {
      frontImage = await AppEncodeHelper.toBase64String(File(state.frontPath!));
    }

    if (state.backPath != null) {
      backImage = await AppEncodeHelper.toBase64String(File(state.backPath!));
    }

    final userRequest = UserRequest(
      roleId: roleId,
      password: part1Data.password ?? "",
      money: 0,
      bankNumber: "",
      bank: "",
      name: part1Data.name ?? "",
      email: part1Data.email ?? "",
      phone: part1Data.phone ?? "",
      avatarPath: "",
      bankBranch: "",
      token: "",
    );

    final request = NewStaffRequest(
      code: "",
      isActive: true,
      cccd: part1Data.cccd ?? "",
      address: part1Data.address ?? "",
      dateOfBirth: dateOfBirth,
      startWorkingDate: startWorkingDate,
      cccdIssueDate: cccdIssueDate,
      cccD_front_image: frontImage,
      cccD_back_image: backImage,
      endWorkingDate: endWorkingDate,
      user: userRequest,
    );

    final result = await _repository.createNewStaff(request);

    bool success = false;
    result.fold(
      (failure) {
        emit(state.copyWith(submitting: false, errorMessage: failure.message));
        success = false;
      },
      (_) {
        emit(state.copyWith(submitting: false));
        success = true;
      },
    );

    return success;
  }
}
