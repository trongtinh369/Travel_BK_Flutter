import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';

class AccountCardWidget extends StatelessWidget {
  final String name;
  final String role;
  final String phone;
  final String avatarPath;
  final List<String> roles;
  final VoidCallback onPermission;
  final VoidCallback? onTap;

  const AccountCardWidget({
    super.key,
    required this.name,
    required this.role,
    required this.phone,
    required this.avatarPath,
    required this.roles,
    required this.onPermission,
    this.onTap,
  });

  Widget _buildAvatar() {
    const double avatarSize = 50;

    return Image.network(
      avatarPath,
      width: avatarSize,
      height: avatarSize,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: avatarSize,
          height: avatarSize,
          decoration: const BoxDecoration(
            color: Color(0xFF1ABC9C),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.white,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(child: _buildAvatar()),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: AppFonts.fontSize16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role,
                    style: TextStyle(fontSize: 13, color: AppColors.gray),
                  ),
                  Text(
                    phone,
                    style: TextStyle(fontSize: 13, color: AppColors.gray),
                  ),
                ],
              ),
            ),

            BkButton(onPressed: onPermission, title: "Phân quyền"),
          ],
        ),
      ),
    );
  }
}
