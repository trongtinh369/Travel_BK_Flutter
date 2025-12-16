import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/schedule_assignment.dart';
import 'package:booking_tour_flutter/domain/tour_assignment.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/schedule_assignment/cubit/schedule_assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/schedule_assignment/cubit/schedule_assignment_state.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/tour_guide_assignment/cubit/tour_guide_assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/tour_guide_assignment/tour_guide_assignment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleAssignmentScreen extends StatelessWidget {

  ScheduleAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ScheduleAssignmentCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Phân công công các lịch trình',
            style: AppFonts.textWhite,
          ),
          backgroundColor: AppColors.button,
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFEFEDED),
        body: columnOfWidget(),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12)),

        SliverToBoxAdapter(child: tourCard()),

        SliverToBoxAdapter(child: SizedBox(height: 10)),

        SliverToBoxAdapter(
          child: BlocSelector<
            ScheduleAssignmentCubit,
            ScheduleAssignmentState,
            List<ScheduleAssignment>
          >(
            selector: (state) => state.schedules,
            builder: (context, schedules) {
              return listSchedule(schedules);
            },
          ),
        ),
      ],
    );
  }

  // Quản lý item schedule
  Widget listSchedule(List<ScheduleAssignment> schedules) {
    return ListView.builder(
      shrinkWrap: true, // Cho phép ListView co lại theo nội dung
      physics:
          NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn bên trong ListView
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        var schedule = schedules[index];

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: itemSchedule(schedule),
        );
      },
    );
  }

  // item schedule
  Widget itemSchedule(ScheduleAssignment schedule) {
    var context = AppNavigator.navigatorKey.currentContext!;
    String startDay =
        "${schedule.startDate.day}/${schedule.startDate.month}/${schedule.startDate.year}";
    String endDay =
        "${schedule.endDate.day}/${schedule.endDate.month}/${schedule.endDate.year}";

    return InkWell(
      onTap: () async {
        final cubit = context.read<TourGuideAssignmentCubit>();

        // đẩy id qua cubit của màn đích
        cubit.setIdSchedule(id: schedule.id);

        cubit.loadData();

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TourGuideAssignmentScreen(),
          ),
        );

        context.read<ScheduleAssignmentCubit>().loadData();
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              // Mã nhân viên
              Row(
                children: [
                  const Icon(Icons.code, size: 30, color: Colors.black),

                  const SizedBox(width: 14),

                  Text(
                    schedule.code,
                    style: AppFonts.text20.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 20),

                  schedule.isAssignment
                      ? Icon(
                        Icons.check_circle_outline,
                        size: 30,
                        color: Colors.green,
                      )
                      : Icon(
                        Icons.check_circle_outline,
                        size: 30,
                        color: Colors.red,
                      ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 30,
                    color: Color(0xFFEA4335),
                  ),

                  const SizedBox(width: 14),

                  Text(
                    "Ngày bắt đầu: ${startDay}",
                    style: AppFonts.text20.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 30,
                    color: Color(0xFFEA4335),
                  ),

                  const SizedBox(width: 14),

                  Text(
                    "Ngày kết thúc: ${endDay}",
                    style: AppFonts.text20.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Quản lý tour card
  Widget tourCard() {
    return BlocSelector<
      ScheduleAssignmentCubit,
      ScheduleAssignmentState,
      TourAssignment
    >(
      selector: (state) => state.tour,
      builder: (context, tour) {
        return tourCardInfor(tour);
      },
    );
  }

  //  widget tour card
  Widget tourCardInfor(TourAssignment tour) {
    var locationName = tour.locations.map((e) => e.name).join(", ");

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Ảnh
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child:
                tour.tourImages.isNotEmpty
                    ? Image.network(
                      tour.tourImages[0],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                    : Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: Icon(Icons.image, color: Colors.grey[600]),
                    ),
          ),

          // Content
          SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tour.titleTour,
                style: AppFonts.text20.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Icon(Icons.location_on, size: 22),
                  SizedBox(width: 10),
                  Text(
                    locationName,
                    style: AppFonts.text20.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              Row(
                children: [
                  Text(
                    tour.price.toString(),
                    style: AppFonts.text20.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6779E3),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "VNĐ",
                    style: AppFonts.text20.copyWith(
                      fontWeight: FontWeight.bold,
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