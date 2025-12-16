import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';

class PermissionDialog extends StatefulWidget {
  final String currentRole;
  final List<String> roles;
  final Function(String) onConfirm;

  const PermissionDialog({
    super.key,
    required this.currentRole,
    required this.roles,
    required this.onConfirm,
  });

  @override
  State<PermissionDialog> createState() => _PermissionDialogState();
}

class _PermissionDialogState extends State<PermissionDialog> {
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.currentRole;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phân quyền"),
            const SizedBox(height: 16),
            ...widget.roles.map(
              (role) => RadioListTile<String>(
                value: role,
                groupValue: selectedRole,
                title: Text(role),
                activeColor: AppColors.backgroundAppBarTheme,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BkButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: "Hủy",
                  backgroundColor: AppColors.backgroundDisable,
                ),
                const SizedBox(width: 8),
                BkButton(
                  onPressed: () {
                    if (selectedRole != null) {
                      widget.onConfirm(selectedRole!);
                      Navigator.pop(context);
                    }
                  },
                  title: "Xác nhận",
                  backgroundColor: AppColors.backgroundAppBarTheme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
