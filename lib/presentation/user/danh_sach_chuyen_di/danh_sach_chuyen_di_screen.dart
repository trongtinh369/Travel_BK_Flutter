import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_chuyen_di/cubit/danh_sach_chuyen_di_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_chuyen_di/cubit/danh_sach_chuyen_di_state.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_chuyen_di/widget/trip_card.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_chuyen_di/widget/trip_card_detail.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/search_bar_widget.dart';
import 'package:booking_tour_flutter/presentation/user/thong_bao/cubit/thong_bao_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/thong_bao/cubit/thong_bao_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanhSachChuyenDiScreen extends StatefulWidget {
  const DanhSachChuyenDiScreen({super.key});

  @override
  State<DanhSachChuyenDiScreen> createState() => _DanhSachChuyenDiScreenState();
}

class _DanhSachChuyenDiScreenState extends State<DanhSachChuyenDiScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final DanhSachChuyenDiCubit _cubit;
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _cubit = DanhSachChuyenDiCubit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      final userId = context.read<AuthCubit>().userId;
      // Load notifications để lấy unread count
      context.read<ThongBaoCubit>().load(userId);
      _hasLoaded = true;
    }
  }

  @override
  void dispose() {
    _cubit.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthCubit>().userId;
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Booking Tour',
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.backgroundAppBarTheme,
          actions: [
            BlocBuilder<ThongBaoCubit, ThongBaoState>(
              builder: (context, notificationState) {
                // Tính số thông báo chưa đọc
                final unreadCount =
                    notificationState.items.where((n) => !n.isRead).length;

                return Stack(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, "thong_bao");
                        // Reload lại notifications khi quay về
                        if (context.mounted) {
                          context.read<ThongBaoCubit>().load(userId);
                        }
                      },
                      icon: const Icon(Icons.notifications),
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            unreadCount > 99 ? '99+' : '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: BlocBuilder<DanhSachChuyenDiCubit, DanhSachChuyenDiState>(
            bloc: _cubit,
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SearchBarWidget(
                      controller: _searchController,
                      enabled: false,
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.searchTour);
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Chuyến đi nổi bật',
                        style: TextStyle(
                          fontSize: AppFonts.fontSize18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 8)),

                  if (state.mostFavoriteTrips.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(right: 16),
                            itemBuilder: (context, index) {
                              final trip = state.mostFavoriteTrips[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    "danh_sach_lich_trinh_user",
                                    arguments: {'tourId': trip.id},
                                  );
                                },
                                child: TripCard(trip: trip),
                              );
                            },
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 12),
                            itemCount: state.mostFavoriteTrips.length,
                          ),
                        ),
                      ),
                    ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  if (state.mostRecent.isNotEmpty)
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return TripCardDetail(
                          trip: state.mostRecent[index],
                          userId: userId,
                        );
                      }, childCount: state.mostRecent.length),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
