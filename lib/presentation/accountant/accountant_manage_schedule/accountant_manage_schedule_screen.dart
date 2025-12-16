import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/booking_list_screen.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/cubit/accountant_manage_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/cubit/accountant_manage_schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantManageScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<AccountantManageScheduleCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quản lý lịch trình",
          style: AppFonts.text24.copyWith(color: AppColors.white),
        ),
      ),
      body: BlocBuilder<
        AccountantManageScheduleCubit,
        AccountantManageScheduleState
      >(
        builder: (context, state) {
          return columnOfWidget(_cubit);
        },
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget(AccountantManageScheduleCubit cubit) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: scheduleInfoCard(cubit.state.scheduleTourmanager),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TabBar(
                    onTap: (index) {
                      cubit.setStatus(
                        status: BookingStatus.copyWith(id: index + 1),
                      );
                    },
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.button,
                    ),
                    labelStyle: AppFonts.text16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: AppFonts.text16,
                    labelColor: AppColors.white,
                    tabs:
                        BookingStatus.allStatuses
                            .map((status) => Tab(text: status.nameVn))
                            .toList(),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
          child: TabBarView(
            children: [
              BookingListScreen(
                status: cubit.getStatus(),
                bookings: cubit.getBookingProcessing(),
                cubit: cubit,
              ),
              BookingListScreen(
                status: cubit.getStatus(),
                bookings: cubit.getBookingDeposit(),
                cubit: cubit,
              ),
              BookingListScreen(
                status: cubit.getStatus(),
                bookings: cubit.getBookingPay(),
                cubit: cubit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget scheduleInfoCard(ScheduleTourmanager schedule) {
    var startDate = schedule.startDate;
    var endDate = schedule.endDate;

    final locationNames = schedule.tour.provinces.map((p) => p.name).join(', ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.button,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          // Mã lịch trình
          Row(
            children: [
              Text(
                "#${schedule.code}",
                style: AppFonts.text20.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Ngày tháng
          Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/destination_place.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${schedule.tour.title}",
                            style: AppFonts.text24.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/calender.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "${startDate.day} - ${endDate.day}/${endDate.month}/${endDate.year}",
                        style: AppFonts.text16.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      // Số lượng khách
                      Image.asset(
                        "assets/images/group_of_people.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "${schedule.bookedSlot}-${schedule.maxSlot} người",
                        style: AppFonts.text16.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Địa điểm
              Row(
                children: [
                  Image.asset(
                    "assets/images/start_place.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "${locationNames}",
                    style: AppFonts.text16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
