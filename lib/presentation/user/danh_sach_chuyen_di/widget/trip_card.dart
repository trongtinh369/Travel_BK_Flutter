import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({super.key, required this.trip});

  bool get _hasValidImage =>
      trip.tourImages.isNotEmpty && trip.tourImages.first.isNotEmpty;

  Widget _buildFallbackImage() {
    return Image.asset(
      'assets/images/destination_place.png',
      fit: BoxFit.cover,
    );
  }

  Widget _buildCoverImage() {
    if (_hasValidImage) {
      return Image.network(
        trip.tourImages.first,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage();
        },
      );
    }
    return _buildFallbackImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: _buildCoverImage(),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFonts.fontSize14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${trip.day} Ngày',
                  style: const TextStyle(
                    fontSize: AppFonts.fontSize12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatCurrency(trip.price)} VND',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFonts.fontSize12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
