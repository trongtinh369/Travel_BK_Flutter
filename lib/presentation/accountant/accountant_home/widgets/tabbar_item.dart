import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class TabbarItem extends StatelessWidget {
  const TabbarItem({
    super.key,
    required this.name,
    required this.count,
    this.backgroundNumColor = AppColors.backgroundAppBarTheme,
  });

  final String name;
  final int count;
  final Color backgroundNumColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        Spacer(),
        Container(
          decoration: BoxDecoration(
            color: backgroundNumColor,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            count.toString(),
            style: Theme.of(
              context,
            ).tabBarTheme.labelStyle!.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
