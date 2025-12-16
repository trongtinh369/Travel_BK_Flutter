import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int starCount;
  final int rating;
  final bool isEnable;
  final ValueChanged<int> onRatingChanged;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 5,
    this.isEnable = true,
    required this.onRatingChanged,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index + 1 > rating) {
      icon = Icon(Icons.star_border, color: AppColors.warning, size: 32);
    } else {
      icon = Icon(Icons.star, color: AppColors.warning, size: 32);
    }
    return GestureDetector(
      onTap: isEnable ? () => onRatingChanged(index + 1) : null,
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
