import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_chuyen_di/danh_sach_chuyen_di_screen.dart';
import 'package:booking_tour_flutter/presentation/user/favorite/cubit/favorite_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/favorite/favorite_tour_screen.dart';
import 'package:booking_tour_flutter/presentation/user/profile/profileUser_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainUser extends StatefulWidget {
  final int initialIndex;

  const MainUser({super.key, this.initialIndex = 0});

  @override
  State<MainUser> createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  late int _currentIndex;
  static final List<Widget> _screens = [
    DanhSachChuyenDiScreen(key: UniqueKey()),
    FavoriteTourScreen(key: UniqueKey()),
    ProfileUserScreen(key: UniqueKey()),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) async {
    if (index == 1) {
      final cubit = context.read<FavoriteCubit>();
      final userId = context.read<AuthCubit>().userId;
      await cubit.loadFavorites(userId: userId);
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.textPrimary,
        backgroundColor: AppColors.backgroundAppBarTheme,
      ),
    );
  }
}
