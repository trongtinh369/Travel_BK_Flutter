import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/admin/tourguide_rating/cubit/tourguide_rating_cubit.dart';
import 'package:booking_tour_flutter/presentation/admin/tourguide_rating/cubit/tourguide_rating_state.dart';
import 'package:booking_tour_flutter/presentation/admin/tourguide_rating/schedule_staff_card.dart';
import 'package:booking_tour_flutter/presentation/widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourguideRatingScreen extends StatefulWidget {
  const TourguideRatingScreen({super.key});

  @override
  State<TourguideRatingScreen> createState() => _TourguideRatingScreenState();
}

class _TourguideRatingScreenState extends State<TourguideRatingScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final TourguideRatingCubit _cubit;
  int? _staffId; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  
    if (_staffId == null) {
      _staffId = ModalRoute.of(context)?.settings.arguments as int?;
      _cubit = TourguideRatingCubit(getIt<BookingRepository>());
      
      if (_staffId != null) {
        _cubit.setStaffId(_staffId!);
        _cubit.loadSchedules();
        _cubit.loadStaffInfo();
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _showFilterBottomSheet(TourguideRatingLoaded state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(
        initialProvinceId: state.provinceId,
        initialProvinceName: state.provinceName,
        initialStartDate: state.startDate,
        initialEndDate: state.endDate,
        initialStars: state.stars,
      ),
    ).then((result) {
      if (result != null) {
        _cubit.applyFilter(
          provinceId: result['provinceId'],
          provinceName: result['provinceName'],
          startDate: result['startDate'],
          endDate: result['endDate'],
          stars: result['stars'],
        );
      }
    });
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Đánh giá',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundAppBarTheme,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // ✅ Quay lại màn hình trước
        ),
      ),
      body: BlocBuilder<TourguideRatingCubit, TourguideRatingState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is TourguideRatingLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.backgroundAppBarTheme,
              ),
            );
          }

          if (state is TourguideRatingError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _cubit.loadSchedules();
                      _cubit.loadStaffInfo();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundAppBarTheme,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (state is TourguideRatingLoaded) {
            final staff = state.staff;
            final user = staff?.user;
            
            return Column(
              children: [
                // Header with profile info
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.backgroundAppBarTheme,
                        backgroundImage: user?.avatarPath != null && 
                                user!.avatarPath.isNotEmpty
                            ? NetworkImage(user.avatarPath)
                            : null,
                        child: user?.avatarPath == null || user!.avatarPath.isEmpty
                            ? Text(
                                _getInitials(user?.name ?? ''),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 12),
                      
                      // Name
                      Text(
                        staff?.user.name ?? 'Đang tải...',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                      // Role
                      Text(
                        staff?.role.title ?? 'Hướng dẫn viên',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Staff Code
                      Text(
                        'ID: ${staff?.code ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Rating stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(5, (index) {
                            final totalReviews = state.schedules.fold<int>(
                              0, 
                              (sum, s) => sum + s.totalReviews
                            );
                            final totalStars = state.schedules.fold<int>(
                              0, 
                              (sum, s) => sum + s.totalStars
                            );
                            final avgRating = totalReviews > 0 
                                ? totalStars / totalReviews 
                                : 0.0;
                            
                            return Icon(
                              index < avgRating.floor()
                                  ? Icons.star
                                  : (index < avgRating 
                                      ? Icons.star_half 
                                      : Icons.star_border),
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            '(${state.schedules.fold<int>(0, (sum, s) => sum + s.totalReviews)} đánh giá)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Search and Filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm lịch trình',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      _cubit.searchSchedules('');
                                    },
                                  )
                                : null,
                          ),
                          onSubmitted: (value) {
                            _cubit.searchSchedules(value);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => _showFilterBottomSheet(state),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.filter_list),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Schedules List
                Expanded(
                  child: state.schedules.isEmpty
                      ? const Center(
                          child: Text(
                            'Không có lịch trình nào',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.schedules.length,
                          itemBuilder: (context, index) {
                            final schedule = state.schedules[index];
                            return ScheduleStaffCard(
                              schedule: schedule,
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const Center(
            child: Text('Có lỗi xảy ra'),
          );
        },
      ),
    );
  }
}