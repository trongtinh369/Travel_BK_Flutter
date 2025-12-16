  // review_detail_screen.dart
  import 'package:booking_tour_flutter/presentation/admin/schedulereviewdetail/cubit/schedule_review_detail_cubit.dart';
  import 'package:booking_tour_flutter/presentation/admin/schedulereviewdetail/cubit/schedule_review_detail_state.dart';
  import 'package:booking_tour_flutter/presentation/admin/schedulereviewdetail/schedule_review_detail_card.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:intl/intl.dart';
  import 'package:booking_tour_flutter/domain/schedule_staff.dart';
  import 'package:booking_tour_flutter/data/booking_repository.dart';

  class ReviewDetailScreen extends StatelessWidget {
    final ScheduleStaff schedule;

    const ReviewDetailScreen({
      Key? key,
      required this.schedule,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: const Color(0xFF26A69A),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Đánh giá chi tiết',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ReviewDetailCubit, ReviewDetailState>(
          builder: (context, state) {
            if (state is ReviewDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF26A69A),
                ),
              );
            }

            if (state is ReviewDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ReviewDetailCubit>().loadReviews(schedule);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF26A69A),
                      ),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              );
            }

            if (state is ReviewDetailLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderCard(state),
                    const SizedBox(height: 8),
                    _buildFilterSection(context, state),
                    const SizedBox(height: 8),
                    _buildRatingSection(state),
                    _buildReviewsList(state),
                    if (state.filteredReviews.isEmpty)
                      _buildEmptyState()
                    else
                      _buildLoadMoreButton(),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      );
    }

    Widget _buildHeaderCard(ReviewDetailLoaded state) {
      final dateFormat = DateFormat('dd/MM/yyyy');

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.cityName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ngày bắt đầu',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(state.startDate),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ngày kết thúc',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateFormat.format(state.endDate),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return const Icon(
                    Icons.star,
                    size: 24,
                    color: Color(0xFFFFD700),
                  );
                }),
                const SizedBox(width: 12),
                Text(
                  '${state.averageRating.toStringAsFixed(1)} (${state.totalReviews} đánh giá)',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildFilterSection(BuildContext context, ReviewDetailLoaded state) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          children: List.generate(5, (index) {
            final stars = index + 1;
            final isSelected = state.selectedStarFilter == stars;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<ReviewDetailCubit>().filterByStar(stars);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF26A69A).withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$stars sao',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? const Color(0xFF26A69A)
                          : (stars == 5
                              ? const Color(0xFFFFB300)
                              : Colors.black87),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }

    Widget _buildRatingSection(ReviewDetailLoaded state) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            const Text(
              'Đánh giá',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              state.averageRating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.star,
              size: 20,
              color: Color(0xFFFFD700),
            ),
          ],
        ),
      );
    }

    Widget _buildReviewsList(ReviewDetailLoaded state) {
      if (state.filteredReviews.isEmpty) {
        return const SizedBox();
      }

      return Container(
        color: Colors.white,
        child: Column(
          children: state.filteredReviews
              .map((review) => ReviewCard(review: review))
              .toList(),
        ),
      );
    }

    Widget _buildEmptyState() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        color: Colors.white,
        child: Column(
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có đánh giá nào',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildLoadMoreButton() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Center(
          child: TextButton(
            onPressed: () {
              // TODO: Implement pagination if needed
            },
            child: Text(
              'Xem thêm >',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
      );
    }
  }