import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/cubit/account_management_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/widget/permission_dialog.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/dialog_noti.dart';
import 'package:flutter/material.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booking_tour_flutter/domain/staff.dart';

class DetailStaffScreen extends StatelessWidget {
  final Staff? staff;

  const DetailStaffScreen({super.key, this.staff});

  Widget _sectionCard({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.backgroundAppBarTheme,
                child: Icon(Icons.person, size: 16, color: AppColors.white),
              ),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.backgroundAppBarTheme.withOpacity(0.1),
            child: Icon(icon, size: 16, color: AppColors.backgroundAppBarTheme),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(flex: 3, child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedStaff =
        staff ?? context.watch<AccountManagementCubit>().state.selectedStaff;

    if (selectedStaff == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundAppBarTheme,
          title: const Text('Chi tiết nhân viên'),
          leading: BackButton(color: AppColors.white),
          elevation: 0,
        ),
        body: const Center(child: Text('Không tìm thấy dữ liệu nhân viên')),
      );
    }

    final staffData = selectedStaff;
    final statusText = staffData.isActive ? 'Đang hoạt động' : 'Tạm khóa';
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundAppBarTheme,
        title: const Text('Chi tiết nhân viên'),
        leading: BackButton(color: AppColors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.gray.withOpacity(0.3)),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: AppColors.backgroundAppBarTheme,
                      child: const Icon(
                        Icons.person,
                        size: 28,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      staffData.user.name,
                      style: const TextStyle(
                        fontSize: AppFonts.fontSize18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      staffData.role.title,
                      style: const TextStyle(color: AppColors.gray),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'ID: ${staffData.user.id}',
                        style: const TextStyle(color: AppColors.gray),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // thông tin cá nhân
            _sectionCard(
              title: 'Thông tin cá nhân',
              children: [
                _infoRow(Icons.email, 'Email', staffData.user.email),
                _infoRow(Icons.phone, 'Số điện thoại', staffData.user.phone),
                _infoRow(
                  Icons.cake,
                  'Ngày sinh',
                  formatDate(staffData.dateOfBirth),
                ),
                _infoRow(Icons.location_on, 'Địa chỉ', staffData.address),
                _infoRow(Icons.badge, 'CCCD/CMND', staffData.cccd),
                _infoRow(
                  Icons.date_range,
                  'Ngày cấp CCCD',
                  formatDate(staffData.cccdIssueDate),
                ),
              ],
            ),

            // thông tin công việc
            _sectionCard(
              title: 'Thông tin công việc',
              children: [
                _infoRow(
                  Icons.calendar_today,
                  'Ngày vào làm',
                  formatDate(staffData.startWorkingDate),
                ),
                if (!staffData.isActive)
                  _infoRow(
                    Icons.calendar_today,
                    'Ngày nghỉ việc',
                    formatDate(staffData.endWorkingDate),
                  ),
                _infoRow(
                  Icons.workspace_premium,
                  'Cấp bậc',
                  staffData.role.title,
                ),
                _infoRow(Icons.check_circle_outline, 'Trạng thái', statusText),
              ],
            ),

            // Đánh giá (chỉ hiển thị nếu là hướng dẫn viên)
            if (staffData.role.title.toLowerCase() == 'tour guide')
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'tourguide_rating_screen',
                    arguments: staffData.userId, // Truyền staffId qua arguments
                  );
                },
                child: _sectionCard(
                  title: 'Đánh giá',
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Xem đánh giá',
                          style: TextStyle(
                            color: AppColors.backgroundAppBarTheme,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.backgroundDisable,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            if (staffData.role.title.toLowerCase() == 'hướng dẫn viên')
              const SizedBox(height: 12),

            //  các nút chức năng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: BkButton(
                      onPressed: () {
                        final currentState =
                            context.read<AccountManagementCubit>().state;
                        final availableRoles =
                            currentState.roles
                                .where(
                                  (role) => role.title.toLowerCase() != 'user',
                                )
                                .toList();

                        final roleTitles =
                            availableRoles.map((role) => role.title).toList();

                        showDialog(
                          context: context,
                          builder:
                              (_) => PermissionDialog(
                                currentRole: staffData.role.title,
                                roles: roleTitles,
                                onConfirm: (selectedRole) async {
                                  final selectedRoleObj = availableRoles
                                      .firstWhere(
                                        (role) => role.title == selectedRole,
                                        orElse: () => availableRoles.first,
                                      );

                                  final success = await context
                                      .read<AccountManagementCubit>()
                                      .updateStaffRole(
                                        staffData,
                                        selectedRoleObj.id,
                                      );

                                  if (!context.mounted) return;

                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Cập nhật quyền thành công',
                                        ),
                                      ),
                                    );
                                    if (context.mounted) {
                                      final updatedStaff = staffData.copyWith(
                                        role: selectedRoleObj,
                                      );
                                      context
                                          .read<AccountManagementCubit>()
                                          .setSelectedStaff(updatedStaff);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                      title: 'Phân quyền',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BkButton(
                      title: staffData.isActive ? 'Tạm khóa' : 'Mở khóa',
                      backgroundColor:
                          staffData.isActive
                              ? AppColors.orange
                              : AppColors.backgroundAppBarTheme,
                      onPressed: () {
                        DialogNoti.confirm(
                          context: context,
                          title:
                              staffData.isActive
                                  ? "Xác nhận tạm khóa"
                                  : "Xác nhận mở khóa",
                          message:
                              staffData.isActive
                                  ? "Bạn có chắc chắn muốn tạm khóa tài khoản này?"
                                  : "Bạn có chắc chắn muốn mở khóa tài khoản này?",
                          confirmText:
                              staffData.isActive ? "Tạm khóa" : "Mở khóa",
                          cancelText: "Hủy",
                        ).then((value) async {
                          if (value) {
                            final newStatus = !staffData.isActive;
                            final success = await context
                                .read<AccountManagementCubit>()
                                .updateStaffStatus(staffData, newStatus);

                            if (!context.mounted) return;

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    newStatus
                                        ? 'Tài khoản đã được mở khóa'
                                        : 'Tài khoản đã bị tạm khóa',
                                  ),
                                ),
                              );
                              final updatedStaff = staffData.copyWith(
                                isActive: newStatus,
                              );
                              context
                                  .read<AccountManagementCubit>()
                                  .setSelectedStaff(updatedStaff);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Cập nhật trạng thái thất bại'),
                                ),
                              );
                            }
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BkButton(
                title: 'Cập nhật',
                backgroundColor: AppColors.borderButton,
                onPressed: () {
                  context.read<AccountManagementCubit>().setSelectedStaff(
                    staffData,
                  );
                  Navigator.pushNamed(context, 'update_staff_account_screen');
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
