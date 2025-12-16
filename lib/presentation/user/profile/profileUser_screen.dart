import 'package:booking_tour_flutter/app/dependency_injection/configure_injectable.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/data/booking_repository.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';
import 'profile_card.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  late final ProfileCubit _cubit;
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    _cubit = ProfileCubit(getIt<BookingRepository>());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      final userId = context.read<AuthCubit>().userId;

      _cubit.loadUser(userId);
      _hasLoaded = true;
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Widget buildItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(subtitle, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundAppBarTheme,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _cubit,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          if (state is ProfileLoaded) {
            final user = state.user;
            return Column(
              children: [
                ProfileCard(user: user),
                buildItem(
                  icon: Icons.person,
                  title: 'Tài Khoản Của Tôi',
                  subtitle: 'Thay đổi thông tin tài khoản của bạn',
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      RouteName.thongTinCuaBan,
                    );

                    final userId = context.read<AuthCubit>().userId;
                    _cubit.loadUser(userId);
                  },
                ),
                buildItem(
                  icon: Icons.account_balance_wallet,
                  title: 'Ví',
                  subtitle: 'nơi chứa tiền dư của bạn',
                  onTap: () async {
                    await Navigator.pushNamed(context, RouteName.vi);

                     final userId = context.read<AuthCubit>().userId;
                    _cubit.loadUser(userId);
                  },
                ),
                buildItem(
                  icon: Icons.check_circle,
                  title: 'Hoàn Thành',
                  subtitle: 'các lịch trình đã hoàn thành',
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      RouteName.lichTrinhDaHoanThanh,
                    );

                    final userId = context.read<AuthCubit>().userId;
                    _cubit.loadUser(userId);
                  },
                ),
                buildItem(
                  icon: Icons.receipt_long,
                  title: 'Lịch Sử Thanh Toán',
                  subtitle: 'xem lại lịch trình đã thanh toán',
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      RouteName.danhSachLichTrinhBooking,
                    );
                    
                    final userId = context.read<AuthCubit>().userId;
                    _cubit.loadUser(userId);
                  },
                ),
                buildItem(
                  icon: Icons.logout,
                  title: 'Đăng Xuất',
                  subtitle: 'Đăng xuất khỏi app', 
                  onTap: () {
                    // đăng xuất
                    var cubitAuth = context.read<AuthCubit>();
                    cubitAuth.logout();

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.login,
                      (route) => false,
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
