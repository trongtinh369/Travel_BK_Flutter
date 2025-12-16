import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/admin/account_management/account_management_screen.dart';
import 'package:booking_tour_flutter/presentation/admin/income_statistics/income_statistics_screen.dart';
import 'package:flutter/material.dart';

class MainAdmin extends StatefulWidget {
  final int initialIndex;

  const MainAdmin({super.key, this.initialIndex = 0});

  @override
  State<MainAdmin> createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  late int _currentIndex;
  static final List<Widget> _screens = [
      IncomeStatisticScreen(key: UniqueKey()),
    AccountManagementScreen(key: UniqueKey()),
  
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Quản lý'),
        ],
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.textPrimary,
        backgroundColor: AppColors.backgroundAppBarTheme,
      ),
    );
  }
}
