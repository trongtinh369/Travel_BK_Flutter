import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_state.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/widget/account_card.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/widget/permission_dialog.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/search_bar_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final controller = TextEditingController();
  String selectedValue = "Tất cả";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountManagementCubit>().loadAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Quản lý tài khoản'),
        backgroundColor: AppColors.backgroundAppBarTheme,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBarWidget(
                    controller: controller,
                    hintText: "Tìm kiếm nhân viên",
                    onChanged: (value) {
                      context.read<AccountManagementCubit>().search(value);
                    },
                    onClear: () {
                      controller.clear();
                      context.read<AccountManagementCubit>().search("");
                    },
                  ),
                ),
                const SizedBox(width: 8),
                BlocBuilder<AccountManagementCubit, AccountManagementState>(
                  builder: (context, state) {
                    final filteredRoles =
                        state.roles
                            .where((role) => role.title.toLowerCase() != 'user')
                            .toList();

                    final items = [
                      "Tất cả",
                      ...filteredRoles.map((role) => role.title),
                    ];
                    return DropdownButton<String>(
                      value: selectedValue,
                      items:
                          items
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                        if (value == "Tất cả") {
                          context
                              .read<AccountManagementCubit>()
                              .loadStaffsByRole(0);
                        } else {
                          final selectedRole = filteredRoles.firstWhere(
                            (role) => role.title == value,
                          );
                          context
                              .read<AccountManagementCubit>()
                              .loadStaffsByRole(selectedRole.id);
                        }
                      },
                    );
                  },
                ),
              ],
            ),

            Expanded(
              child: BlocBuilder<
                AccountManagementCubit,
                AccountManagementState
              >(
                builder: (context, state) {
                  final staffs = state.staffs;

                  final filteredRoles =
                      state.roles
                          .where((role) => role.title.toLowerCase() != 'user')
                          .toList();
                  final roleTitles =
                      filteredRoles.map((role) => role.title).toList();

                  return ListView.builder(
                    itemCount: staffs.length,
                    itemBuilder: (context, index) {
                      final s = staffs[index];
                      return AccountCardWidget(
                        name: s.user.name,
                        role: s.role.title,
                        phone: s.user.phone,
                        avatarPath: s.user.avatarPath,
                        roles: roleTitles,
                        onPermission: () {
                          final currentState =
                              context.read<AccountManagementCubit>().state;
                          final availableRoles =
                              currentState.roles
                                  .where(
                                    (role) =>
                                        role.title.toLowerCase() != 'user',
                                  )
                                  .toList();

                          showDialog(
                            context: context,
                            builder:
                                (_) => PermissionDialog(
                                  currentRole: s.role.title,
                                  roles: roleTitles,
                                  onConfirm: (selectedRole) async {
                                    final selectedRoleObj = availableRoles
                                        .firstWhere(
                                          (role) => role.title == selectedRole,
                                          orElse: () => availableRoles.first,
                                        );

                                    final success = await context
                                        .read<AccountManagementCubit>()
                                        .updateStaffRole(s, selectedRoleObj.id);

                                    if (!mounted) return;

                                    if (success) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Cập nhật quyền thành công',
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Cập nhật quyền thất bại',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                          );
                        },
                        onTap: () {
                          context
                              .read<AccountManagementCubit>()
                              .setSelectedStaff(s);
                          Navigator.pushNamed(context, 'detail_staff_screen');
                        },
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 4),
            BkButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "create_staff_account_part1_screen",
                );
              },
              title: "Thêm",
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
