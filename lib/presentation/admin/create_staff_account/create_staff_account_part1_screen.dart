import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';

import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_state.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/text_input.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/toggle_Input_field.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/create_staff_account/cubit/create_staff_account_part1_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateStaffAccountPart1Screen extends StatefulWidget {
  const CreateStaffAccountPart1Screen({super.key});

  @override
  State<CreateStaffAccountPart1Screen> createState() =>
      _CreateStaffAccountPart1ScreenState();
}

class _CreateStaffAccountPart1ScreenState
    extends State<CreateStaffAccountPart1Screen> {
  final _formKey = GlobalKey<FormState>();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  final nameCtrl = TextEditingController();
  final cccdCtrl = TextEditingController();
  final issuedDateCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final startDateCtrl = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  String? selectedRole;

  Future<void> _pickDate(TextEditingController ctrl) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      ctrl.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  void initState() {
    super.initState();
    // Load roles nếu chưa có
    final accountCubit = context.read<AccountManagementCubit>();
    if (accountCubit.state.roles.isEmpty) {
      accountCubit.loadAll();
    }
  }

  @override
  void dispose() {
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    nameCtrl.dispose();
    cccdCtrl.dispose();
    issuedDateCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    dobCtrl.dispose();
    startDateCtrl.dispose();
    super.dispose();
  }

  Widget _sectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info_outline, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: AppFonts.fontSize20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration([String? hint]) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 12.0,
      ),
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppBarTheme,
        title: const Text('Tạo tài khoản'),
        leading: BackButton(color: AppColors.white),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray.withOpacity(0.3),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: AppColors.backgroundAppBarTheme,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  // Card  thông tin tài khoản
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle("Thông tin tài khoản"),
                        const SizedBox(height: 8),
                        // Email
                        TextInput(
                          controller: emailCtrl,
                          hintText: 'Email',
                          labelText: 'Email',
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 8),

                        ToggleInputField(
                          controller: passwordCtrl,
                          title: "Mật khẩu",
                          color: AppColors.scaffoldBackgroundColor,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Nhập lại mật khẩu
                        ToggleInputField(
                          controller: confirmCtrl,
                          title: "Nhập lại mật khẩu",
                          color: AppColors.scaffoldBackgroundColor,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập lại mật khẩu';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Quyền truy cập
                        BlocBuilder<
                          AccountManagementCubit,
                          AccountManagementState
                        >(
                          builder: (context, accountState) {
                            final roles = accountState.roles;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quyền truy cập",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppFonts.fontSize14,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                DropdownButtonFormField<String?>(
                                  value: selectedRole,
                                  items: [
                                    const DropdownMenuItem<String?>(
                                      value: null,
                                      child: Text('--Quyền truy cập--'),
                                    ),
                                    ...roles.map<DropdownMenuItem<String?>>(
                                      (role) => DropdownMenuItem<String?>(
                                        value: role.title,
                                        child: Text(role.title),
                                      ),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    setState(() {
                                      selectedRole = v;
                                      if (v != null) {
                                        final selectedRoleObj = roles
                                            .firstWhere(
                                              (role) => role.title == v,
                                              orElse: () => roles.first,
                                            );
                                        context
                                            .read<
                                              CreateStaffAccountPart1Cubit
                                            >()
                                            .setRole(selectedRoleObj.id, v);
                                      }
                                    });
                                  },
                                  decoration: _inputDecoration(
                                    '--Quyền truy cập--',
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        // thông tin cá nhân
                        const SizedBox(height: 16),
                        _sectionTitle("Thông tin cá nhân"),
                        const SizedBox(height: 8),

                        // Họ và tên
                        TextInput(
                          controller: nameCtrl,
                          hintText: 'Họ và tên',
                          labelText: 'Họ và tên',
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập họ và tên';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Số CCCD
                        TextInput(
                          controller: cccdCtrl,
                          hintText: 'Số CCCD',
                          labelText: 'Số CCCD',
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập số CCCD';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        //Ngày cấp
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày cấp",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.fontSize14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: issuedDateCtrl,
                              readOnly: true,
                              onTap: () => _pickDate(issuedDateCtrl),
                              decoration: _inputDecoration('Ngày cấp'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Email
                        TextInput(
                          controller: emailCtrl,
                          hintText: 'Email',
                          labelText: 'Email',
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Số điện thoại
                        TextInput(
                          controller: phoneCtrl,
                          hintText: 'Số điện thoại',
                          labelText: 'Số điện thoại',
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập số điện thoại';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Địa chỉ
                        TextInput(
                          controller: addressCtrl,
                          hintText: 'Địa chỉ',
                          labelText: 'Địa chỉ',
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Vui lòng nhập địa chỉ';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),

                        // Ngày sinh
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày sinh",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.fontSize14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: dobCtrl,
                              readOnly: true,
                              onTap: () => _pickDate(dobCtrl),
                              decoration: _inputDecoration('Ngày sinh'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Ngày vào làm
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ngày vào làm",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.fontSize14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: startDateCtrl,
                              readOnly: true,
                              onTap: () => _pickDate(startDateCtrl),
                              decoration: _inputDecoration('Ngày vào làm'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        // Tiếp theo button
                        SizedBox(
                          width: double.infinity,
                          child: BkButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              if (passwordCtrl.text.trim() !=
                                  confirmCtrl.text.trim()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Mật khẩu không khớp'),
                                  ),
                                );
                                return;
                              }
                              if (selectedRole == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Vui lòng chọn quyền truy cập',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final part1Cubit =
                                  context.read<CreateStaffAccountPart1Cubit>();
                              final accountState =
                                  context.read<AccountManagementCubit>().state;
                              final selectedRoleObj = accountState.roles
                                  .firstWhere(
                                    (role) => role.title == selectedRole,
                                    orElse: () => accountState.roles.first,
                                  );

                              part1Cubit.saveData(
                                password: passwordCtrl.text.trim(),
                                name: nameCtrl.text.trim(),
                                cccd: cccdCtrl.text.trim(),
                                issuedDate:
                                    issuedDateCtrl.text.trim().isEmpty
                                        ? null
                                        : issuedDateCtrl.text.trim(),
                                email: emailCtrl.text.trim(),
                                phone: phoneCtrl.text.trim(),
                                address: addressCtrl.text.trim(),
                                dob:
                                    dobCtrl.text.trim().isEmpty
                                        ? null
                                        : dobCtrl.text.trim(),
                                startDate:
                                    startDateCtrl.text.trim().isEmpty
                                        ? null
                                        : startDateCtrl.text.trim(),
                                selectedRole: selectedRole ?? "",
                                roleId: selectedRoleObj.id,
                              );

                              Navigator.pushNamed(
                                context,
                                "create_staff_account_part2_screen",
                              );
                            },
                            title: 'Tiếp Theo',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
