import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_home/widgets/tabbar_item.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/accountant_refund_screen.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/cubit/accountant_refund_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/cubit/accountant_refund_state.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/accountant_starting_schedule_screen.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/cubit/accountant_starting_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/cubit/accountant_starting_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/widgets/account_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantHomeScreen extends StatefulWidget {
  const AccountantHomeScreen({super.key});

  @override
  State<AccountantHomeScreen> createState() => _AccountantHomeScreenState();
}

class _AccountantHomeScreenState extends State<AccountantHomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  AccountantRefundCubit _refundCubit = AccountantRefundCubit()..getData();
  AccountantStartingScheduleCubit _startingScheduleCubit =
      AccountantStartingScheduleCubit()..getData();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _refundCubit),
        BlocProvider.value(value: _startingScheduleCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(title: Text("Danh Sách lịch trình")),
        body: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 250.0),
              child: Material(
                color: AppColors.white,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    BlocBuilder<
                      AccountantStartingScheduleCubit,
                      AccountantStartingScheduleState
                    >(
                      builder: (context, state) {
                        var countSchedules = 0;
                        if (state is AccountantStartingScheduleLoaded) {
                          countSchedules = state.schedules.length;
                        }
                        return TabbarItem(
                          name: "Đang diễn ra",
                          count: countSchedules,
                          backgroundNumColor: AppColors.backgroundAppBarTheme,
                        );
                      },
                    ),
                    BlocBuilder<AccountantRefundCubit, AccountantRefundState>(
                      builder: (context, state) {
                        var countRequests = 0;
                        if (state is AccountantRefundLoaded) {
                          countRequests = state.users.length;
                        }

                        return TabbarItem(
                          name: "Yêu cầu hoàn tiền",
                          count: countRequests,
                          backgroundNumColor: AppColors.error,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AccountantStartingScheduleScreen(),
                  AccountantRefundScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
