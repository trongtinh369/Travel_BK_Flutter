import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/role.dart';
import 'package:booking_tour_flutter/domain/staff.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStaffAccountScreen extends StatefulWidget {
  const UpdateStaffAccountScreen({super.key});

  @override
  State<UpdateStaffAccountScreen> createState() =>
      _UpdateStaffAccountScreenState();
}

class _UpdateStaffAccountScreenState extends State<UpdateStaffAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _cccdController;
  late final TextEditingController _idIssueDateController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _dobController;
  late final TextEditingController _joinDateController;
  late final TextEditingController _leaveDateController;

  String? _roleValue;
  bool _isActive = true;
  Staff? _staff;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<AccountManagementCubit>().state;
    _staff = state.selectedStaff;
    _isActive = _staff?.isActive ?? true;
    _roleValue = _staff?.role.title;

    _idController = TextEditingController(
      text: _staff?.user.id.toString() ?? '',
    );
    _nameController = TextEditingController(text: _staff?.user.name ?? '');
    _cccdController = TextEditingController(text: _staff?.cccd ?? '');
    _idIssueDateController = TextEditingController(
      text: _staff == null ? '' : formatDate(_staff!.cccdIssueDate),
    );
    _emailController = TextEditingController(text: _staff?.user.email ?? '');
    _phoneController = TextEditingController(text: _staff?.user.phone ?? '');
    _addressController = TextEditingController(text: _staff?.address ?? '');
    _dobController = TextEditingController(
      text: _staff == null ? '' : formatDate(_staff!.dateOfBirth),
    );
    _joinDateController = TextEditingController(
      text: _staff == null ? '' : formatDate(_staff!.startWorkingDate),
    );
    _leaveDateController = TextEditingController(
      text: _staff == null ? '' : formatDate(_staff!.endWorkingDate),
    );

    if (_staff == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không có dữ liệu nhân viên')),
        );
        Navigator.of(context).pop();
      });
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _cccdController.dispose();
    _idIssueDateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _joinDateController.dispose();
    _leaveDateController.dispose();
    super.dispose();
  }

  DateTime _parseDate(String value, DateTime fallback) {
    try {
      final parts = value.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (_) {}
    return fallback;
  }

  Future<void> _pickDate(
    TextEditingController controller,
    DateTime fallback, {
    void Function(DateTime picked)? onDatePicked,
  }) async {
    final initial = _parseDate(controller.text, fallback);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = formatDate(picked);
      onDatePicked?.call(picked);
    }
  }

  Future<void> _save() async {
    if (_staff == null || _isSaving) return;
    if (!_formKey.currentState!.validate()) return;

    final current = _staff!;
    final updatedUser = User(
      id: current.user.id,
      roleId: current.user.roleId,
      money: current.user.money,
      bankNumber: current.user.bankNumber,
      bank: current.user.bank,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      avatarPath: current.user.avatarPath,
      bankBranch: current.user.bankBranch,
      refundStatus: current.user.refundStatus,
    );

    final updatedRole = Role(
      id: current.role.id,
      title: _roleValue ?? current.role.title,
    );

    final updatedStaff = Staff(
      userId: current.userId,
      code: current.code,
      isActive: _isActive,
      cccd: _cccdController.text.trim(),
      address: _addressController.text.trim(),
      dateOfBirth: _parseDate(_dobController.text, current.dateOfBirth),
      startWorkingDate: _parseDate(
        _joinDateController.text,
        current.startWorkingDate,
      ),
      cccdIssueDate: _parseDate(
        _idIssueDateController.text,
        current.cccdIssueDate,
      ),
      cccD_front_path: current.cccD_front_path,
      cccD_back_path: current.cccD_back_path,
      endWorkingDate: _parseDate(
        _leaveDateController.text,
        current.endWorkingDate,
      ),
      user: updatedUser,
      role: updatedRole,
    );

    setState(() {
      _isSaving = true;
    });

    final cubit = context.read<AccountManagementCubit>();
    final success = await cubit.updateStaffInfo(updatedStaff);

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (success) {
      cubit.setSelectedStaff(updatedStaff);
      setState(() => _staff = updatedStaff);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cập nhật thành công')));
      Navigator.of(context).pop();
    } else {
      final error = cubit.state.error;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error ?? 'Cập nhật thất bại')));
    }
  }

  Widget _buildDateField(
    TextEditingController controller,
    DateTime fallback, {
    bool isRequired = true,
    void Function(DateTime picked)? onDatePicked,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _pickDate(controller, fallback, onDatePicked: onDatePicked),
      decoration: InputDecoration(suffixIcon: const Icon(Icons.calendar_today)),
      validator: (value) {
        if (!isRequired) return null;
        return value == null || value.isEmpty ? 'Vui lòng chọn ngày' : null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppBarTheme,
        title: const Text('Cập nhật nhân viên'),
        leading: BackButton(color: Colors.white),
      ),
      body:
          _staff == null
              ? const SizedBox.shrink()
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 34,
                              backgroundColor: AppColors.backgroundAppBarTheme,
                              child: Text(
                                _staff!.user.name.isNotEmpty
                                    ? _staff!.user.name[0].toUpperCase()
                                    : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _staff!.user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.security),
                          const SizedBox(width: 8),
                          Text(
                            "Thông tin tài khoản",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.fontSize18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        controller: _idController,
                        labelText: "Tài khoản",
                        hintText: "Tài khoản",
                        enabled: false,
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Chức vụ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.fontSize16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            enabled: false,
                            initialValue: _roleValue,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: AppColors.gray),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person),
                          const SizedBox(width: 8),
                          Text(
                            "Thông tin cá nhân",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.fontSize18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        controller: _nameController,
                        labelText: 'Họ và tên',
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Vui lòng nhập họ và tên'
                                    : null,
                        hintText: 'Họ và tên',
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Email',
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Vui lòng nhập email'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        controller: _phoneController,
                        labelText: 'Số điện thoại',
                        hintText: 'Số điện thoại',
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Vui lòng nhập số điện thoại'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        controller: _addressController,
                        labelText: 'Địa chỉ',
                        hintText: 'Địa chỉ',
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Vui lòng nhập địa chỉ'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        controller: _cccdController,
                        labelText: 'Căn cước công dân (CCCD)',
                        hintText: 'Căn cước công dân (CCCD)',
                        validator:
                            (value) =>
                                value == null || value.trim().isEmpty
                                    ? 'Vui lòng nhập CCCD'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ngày cấp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.fontSize16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDateField(
                            _idIssueDateController,
                            _staff!.cccdIssueDate,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ngày sinh",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.fontSize16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDateField(_dobController, _staff!.dateOfBirth),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ngày bắt đầu làm việc",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppFonts.fontSize16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDateField(
                            _joinDateController,
                            _staff!.startWorkingDate,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          _isActive
                              ? "Trạng thái: Đang làm việc"
                              : "Trạng thái: Đã nghỉ",
                        ),
                        value: _isActive,
                        onChanged: (value) {
                          setState(() {
                            _isActive = value;
                            if (value) {
                              _leaveDateController.clear();
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      if (!_isActive)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày kết thúc làm việc",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.fontSize16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildDateField(
                              _leaveDateController,
                              _staff!.endWorkingDate,
                              onDatePicked: (_) {
                                if (_isActive) {
                                  setState(() {
                                    _isActive = false;
                                  });
                                }
                              },
                            ),
                          ],
                        )
                      else
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () async {
                              await _pickDate(
                                _leaveDateController,
                                _staff!.endWorkingDate,
                                onDatePicked: (_) {
                                  setState(() {
                                    _isActive = false;
                                  });
                                },
                              );
                            },
                            icon: const Icon(Icons.event_busy),
                            label: const Text(
                              "Thiết lập ngày kết thúc làm việc",
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: BkButton(
                              title: 'Hủy',
                              backgroundColor: AppColors.white,
                              textColor: Colors.black87,
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: BkButton(
                              title: 'Cập nhật',
                              backgroundColor: AppColors.backgroundAppBarTheme,
                              onPressed: _save,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
    );
  }
}
