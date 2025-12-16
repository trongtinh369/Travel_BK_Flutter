import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/review.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/book_a_schedule/cubit/book_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/chi_tiet_lich_trinh.dart/cubit/chi_tiet_lich_trinh_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/chi_tiet_lich_trinh.dart/cubit/chi_tiet_lich_trinh_state.dart';
import 'package:booking_tour_flutter/presentation/user/schedule_detail/cubit/schedule_detail_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChiTietLichTrinhScreen extends StatefulWidget {
  const ChiTietLichTrinhScreen({super.key});

  @override
  State<ChiTietLichTrinhScreen> createState() => _ChiTietLichTrinhScreenState();
}

class _ChiTietLichTrinhScreenState extends State<ChiTietLichTrinhScreen> {
  static const int _initialReviewCount = 3;
  static const int _reviewsIncrement = 3;
  static const int _maxLoadMorePresses = 5;
  int _selectedImageIndex = 0;
  int _displayedReviewCount = _initialReviewCount;
  int _loadMorePressCount = 0;
  final Map<dynamic, bool> _helpfulOverrides = {};
  final Map<dynamic, int> _countHelpfulOverrides = {};

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final schedule = arguments['scheduleTourmanager'] as ScheduleTourmanager;
    final tour = schedule.tour;
    final userId = context.read<AuthCubit>().userId;
    final tourImages = tour.tourImages;
    final validTourImages =
        tourImages
            .whereType<String>()
            .where((img) => img.trim().isNotEmpty)
            .toList();
    final imageCount = validTourImages.length;
    final int selectedImageIndex =
        imageCount > 0 ? _selectedImageIndex.clamp(0, imageCount - 1) : 0;
    final provinces = tour.provinces;
    final provinceNames =
        provinces
            .map((e) => (e.name).trim())
            .where((name) => name.isNotEmpty)
            .toList();
    final provinceDisplay =
        provinceNames.isNotEmpty
            ? provinceNames.join(", ")
            : "Chưa có thông tin";
    return BlocProvider(
      create: (context) {
        final cubit = ChiTietLichTrinhCubit();
        cubit.loadRviews(tour.id, userId);
        cubit.loadFavoriteStatus(userId, tour.id);

        return cubit;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(title: Text(tour.title), centerTitle: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    color: AppColors.gray,
                    child:
                        imageCount > 0 &&
                                validTourImages[selectedImageIndex].isNotEmpty
                            ? _buildSafeNetworkImage(
                                validTourImages[selectedImageIndex],
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image_not_supported, size: 48),
                  ),
                  if (imageCount > 1 && selectedImageIndex > 0)
                    Positioned(
                      left: 8,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _buildImageNavButton(
                          icon: Icons.chevron_left,
                          onTap: () {
                            setState(() {
                              _selectedImageIndex = selectedImageIndex - 1;
                            });
                          },
                        ),
                      ),
                    ),
                  if (imageCount > 1 && selectedImageIndex < imageCount - 1)
                    Positioned(
                      right: 8,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: _buildImageNavButton(
                          icon: Icons.chevron_right,
                          onTap: () {
                            setState(() {
                              _selectedImageIndex = selectedImageIndex + 1;
                            });
                          },
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: BlocBuilder<
                      ChiTietLichTrinhCubit,
                      ChiTietLichTrinhState
                    >(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            final cubit = context.read<ChiTietLichTrinhCubit>();
                            cubit.toggleFavorite(userId, tour.id);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              state.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  state.isFavorite
                                      ? AppColors.delete
                                      : AppColors.gray,
                              size: 24,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Container(
                height: 90,
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: imageCount,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, index) {
                    final isSelected = index == selectedImageIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.secondary
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _buildSafeNetworkImage(
                            validTourImages[index],
                            width: 120,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),
              Divider(color: AppColors.secondary, thickness: 8, height: 1),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.title,
                      style: TextStyle(
                        fontSize: AppFonts.fontSize20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_outlined, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            "${formatDate(schedule.startDate)} - ${formatDate(schedule.endDate)}",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Icon(Icons.group, size: 20),
                          const SizedBox(width: 6),
                          Text("${schedule.maxSlot} người"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.money, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            "${NumberFormat("#,###", "vi_VN").format(tour.price)} VNĐ / người",
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: AppFonts.fontSize14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColors.delete,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            provinceDisplay,
                            style: TextStyle(fontSize: AppFonts.fontSize14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 8),
              Divider(color: AppColors.secondary, thickness: 8, height: 1),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Các điểm đến",
                      style: TextStyle(
                        fontSize: AppFonts.fontSize20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...tour.places.map((place) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12, left: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.delete,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                place.name,
                                style: TextStyle(fontSize: AppFonts.fontSize14),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        var cubit = context.read<ScheduleDetailCubit>();

                        cubit.setIdSchedule(schedule.id);

                        await cubit.loadData();

                        await Navigator.pushNamed(
                          context,
                          RouteName.scheduleDetail,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chi tiết lịch trình",
                            style: TextStyle(
                              fontSize: AppFonts.fontSize16,
                              color: AppColors.gray,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.gray,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const SizedBox(height: 8),
              Divider(color: AppColors.secondary, thickness: 8, height: 1),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Mô tả",
                      style: TextStyle(
                        fontSize: AppFonts.fontSize20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text('Mô tả: ${tour.description}'),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const SizedBox(height: 8),
              Divider(color: AppColors.secondary, thickness: 8, height: 1),
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Đánh giá",
                      style: TextStyle(
                        fontSize: AppFonts.fontSize20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<ChiTietLichTrinhCubit, ChiTietLichTrinhState>(
                      builder: (context, state) {
                        final reviews = state.reviews;
                        final averageRating =
                            reviews.isNotEmpty
                                ? reviews
                                        .map((r) => r.rating)
                                        .reduce((a, b) => a + b) /
                                    reviews.length
                                : 0.0;

                        final totalReviews = reviews.length;
                        final maxDisplayableReviews =
                            _initialReviewCount +
                            _reviewsIncrement * _maxLoadMorePresses;
                        final allowedDisplayCount =
                            totalReviews < maxDisplayableReviews
                                ? totalReviews
                                : maxDisplayableReviews;
                        final effectiveDisplayCount =
                            _displayedReviewCount < allowedDisplayCount
                                ? _displayedReviewCount
                                : allowedDisplayCount;
                        final visibleReviews =
                            reviews.take(effectiveDisplayCount).toList();
                        final bool canLoadMore =
                            totalReviews > effectiveDisplayCount &&
                            _loadMorePressCount < _maxLoadMorePresses &&
                            effectiveDisplayCount < maxDisplayableReviews;
                        final bool canCollapse =
                            effectiveDisplayCount > _initialReviewCount;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  averageRating.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: AppFonts.fontSize20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildStarRating(averageRating, size: 20),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ...visibleReviews.map((review) {
                              return _buildReviewItem(review, context, userId);
                            }),
                            if (canLoadMore || canCollapse)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    if (canLoadMore)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            final maxAllowed =
                                                _initialReviewCount +
                                                _reviewsIncrement *
                                                    _maxLoadMorePresses;
                                            _displayedReviewCount +=
                                                _reviewsIncrement;
                                            if (_displayedReviewCount >
                                                maxAllowed) {
                                              _displayedReviewCount =
                                                  maxAllowed;
                                            }
                                            if (_displayedReviewCount >
                                                totalReviews) {
                                              _displayedReviewCount =
                                                  totalReviews;
                                            }
                                            _loadMorePressCount += 1;
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            "Xem thêm >",
                                            style: TextStyle(
                                              fontSize: AppFonts.fontSize14,
                                              color: AppColors.gray,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (canLoadMore && canCollapse)
                                      const SizedBox(width: 16),
                                    if (canCollapse)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _displayedReviewCount =
                                                _initialReviewCount;
                                            _loadMorePressCount = 0;
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Text(
                                            "Ẩn bớt",
                                            style: TextStyle(
                                              fontSize: AppFonts.fontSize14,
                                              color: AppColors.gray,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BkButton(
                        onPressed: () async {
                          var cubit = context.read<BookScheduleCubit>();

                          cubit.setIdSchedule(schedule.id);

                          cubit.loadData();

                          await Navigator.pushNamed(
                            context,
                            RouteName.bookSchedule,
                          );
                        },
                        title: "Đặt ngay",
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: AppColors.warning, size: size);
        } else if (index < rating) {
          return Icon(Icons.star_half, color: AppColors.warning, size: size);
        } else {
          return Icon(Icons.star_border, color: AppColors.gray, size: size);
        }
      }),
    );
  }

  Widget _buildReviewItem(Review review, BuildContext context, userId) {
    final bool isHelpful =
        _helpfulOverrides.containsKey(review.id)
            ? _helpfulOverrides[review.id]!
            : review.isHelpful;

    final int countHelpful =
        _countHelpfulOverrides.containsKey(review.id)
            ? _countHelpfulOverrides[review.id]!
            : review.countHelpful;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.user.name,
                style: TextStyle(
                  fontSize: AppFonts.fontSize16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {
                  final cubit = context.read<ChiTietLichTrinhCubit>();

                  cubit.postHelpFul(userId, review.id);
                  setState(() {
                    final current =
                        _helpfulOverrides.containsKey(review.id)
                            ? _helpfulOverrides[review.id]!
                            : review.isHelpful;
                    final toggled = !current;

                    // Cập nhật trạng thái helpful
                    if (toggled == review.isHelpful) {
                      _helpfulOverrides.remove(review.id);
                    } else {
                      _helpfulOverrides[review.id] = toggled;
                    }

                    // Cập nhật countHelpful
                    final currentCount =
                        _countHelpfulOverrides.containsKey(review.id)
                            ? _countHelpfulOverrides[review.id]!
                            : review.countHelpful;

                    if (toggled) {
                      _countHelpfulOverrides[review.id] = currentCount + 1;
                    } else {
                      _countHelpfulOverrides[review.id] = currentCount - 1;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Hữu ích ($countHelpful)",
                        style: TextStyle(
                          fontSize: AppFonts.fontSize14,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        isHelpful ? Icons.thumb_up : Icons.thumb_up_outlined,
                        size: 18,
                        color: isHelpful ? AppColors.warning : AppColors.gray,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          _buildStarRating(review.rating.toDouble()),
          const SizedBox(height: 8),

          Text(review.content, style: TextStyle(fontSize: AppFonts.fontSize14)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (review.guideReviews.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hướng dẫn viên: ${review.guideReviews.first.nameStaff}",
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.gray, thickness: 1, height: 1),
        ],
      ),
    );
  }

  Widget _buildImageNavButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: AppColors.black, size: 28),
      ),
    );
  }

  Widget _buildSafeNetworkImage(
    String url, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    if (url.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 48);
    }

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.broken_image_outlined, size: 32, color: Colors.grey),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}
