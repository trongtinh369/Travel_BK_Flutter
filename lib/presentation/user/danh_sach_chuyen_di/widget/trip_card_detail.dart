import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/trip.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';

class TripCardDetail extends StatefulWidget {
  final Trip trip;
  final int userId;
  const TripCardDetail({super.key, required this.trip, required this.userId});

  @override
  State<TripCardDetail> createState() => _TripCardDetailState();
}

class _TripCardDetailState extends State<TripCardDetail> {
  bool _isExpanded = false;

  bool get _hasValidImage =>
      widget.trip.tourImages.isNotEmpty &&
      widget.trip.tourImages.first.isNotEmpty;

  String get _primaryProvince =>
      widget.trip.provinces.isNotEmpty &&
              widget.trip.provinces.first.name.isNotEmpty
          ? widget.trip.provinces.first.name
          : 'Không có tỉnh thành';

  Widget _buildFallbackImage() {
    return Image.asset(
      'assets/images/destination_place.png',
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildCoverImage() {
    if (_hasValidImage) {
      return Image.network(
        widget.trip.tourImages.first,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallbackImage();
        },
      );
    }
    return _buildFallbackImage();
  }

  List<String> _extractLocationNames(Trip trip) {
    final names =
        trip.dayOfTours
            .expand((day) => day.dayActivities)
            .map((act) => act.locationActivity.name)
            .where((name) => name.isNotEmpty)
            .toList();
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.gray,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: _buildCoverImage(),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.trip.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFonts.fontSize18,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thời gian',
                            style: TextStyle(
                              fontSize: AppFonts.fontSize14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Địa điểm',
                            style: TextStyle(
                              fontSize: AppFonts.fontSize14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.trip.day} Ngày",
                            style: const TextStyle(
                              fontSize: AppFonts.fontSize14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _primaryProvince,
                            style: const TextStyle(
                              fontSize: AppFonts.fontSize14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Builder(
                    builder: (context) {
                      final averageStars =
                          widget.trip.totalReviews > 0
                              ? widget.trip.totalStars /
                                  widget.trip.totalReviews
                              : 0.0;
                      final roundedStars = averageStars.round();

                      return Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              Icons.star,
                              color:
                                  index < roundedStars
                                      ? AppColors.warning
                                      : AppColors.secondary,
                              size: 18,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            widget.trip.totalReviews > 0
                                ? '${averageStars.toStringAsFixed(1)} (${widget.trip.totalReviews} đánh giá)'
                                : '0 (0 đánh giá)',
                            style: const TextStyle(
                              fontSize: AppFonts.fontSize14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.orange[50],
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                'Giá',
                                style: TextStyle(
                                  fontSize: AppFonts.fontSize14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${formatCurrency(widget.trip.price)} VND/',
                                  style: const TextStyle(
                                    fontSize: AppFonts.fontSize16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.delete,
                                  ),
                                ),
                                const Text(
                                  'Người',
                                  style: TextStyle(
                                    fontSize: AppFonts.fontSize14,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Text(
                          'Danh sách địa điểm đi chuyến',
                          style: TextStyle(
                            fontSize: AppFonts.fontSize14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ..._extractLocationNames(widget.trip).map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: AppColors.delete,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: AppFonts.fontSize14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            BkButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  "danh_sach_lich_trinh_user",
                                  arguments: {
                                    'tourId': widget.trip.id,
                                    'userId': widget.userId,
                                  },
                                );
                              },
                              title: "Chi tiết",
                              borderRadius: 32,
                            ),
                          ],
                        ),
                      ],
                    ),
                    crossFadeState:
                        _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
