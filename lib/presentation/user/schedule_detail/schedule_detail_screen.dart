import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/schedule_detail.dart';
import 'package:booking_tour_flutter/presentation/user/schedule_detail/cubit/schedule_detail_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/schedule_detail/cubit/schedule_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleDetailScreen extends StatelessWidget {
  late final ScheduleDetailCubit _cubit;

  @override
  Widget build(BuildContext context) {
    _cubit = context.read<ScheduleDetailCubit>();

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text("Chi tiết lịch trình")),
        body: Center(child: columnOfWidget()),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget() {
    return BlocBuilder<ScheduleDetailCubit, ScheduleDetailState>(
      builder: (context, state) {
        var startDate = state.scheduleDetail.startDate;
        var endDate = state.scheduleDetail.endDate;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                color: AppColors.backgroundAppBarTheme,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D9488),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 30,
                            color: Color(0xFFEA4335),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}",
                            style: AppFonts.text16.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 30),
                          const Icon(
                            Icons.person_outline,
                            size: 30,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${state.scheduleDetail.maxSlot}",
                            style: AppFonts.text16.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 60,
                    child: days(state.scheduleDetail),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.white,
                child: scheduleDetail(
                  state.scheduleDetail.tour.dayOfTours[state.daySelected - 1],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget scheduleDetail(DayOfTour dayOfTour) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 15),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "${_cubit.getDay()}",
                    style: AppFonts.text18.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${dayOfTour.title.trim()}", style: AppFonts.text20),

                  Text(
                    "${dayOfTour.description.trim()}",
                    style: AppFonts.text14,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 30),
        activities(dayOfTour.dayActivities),
      ],
    );
  }

  Widget activities(List<DayActivitie> dayActivities) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dayActivities.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: itemActivitie(dayActivities[index]),
        );
      },
    );
  }

  Widget itemActivitie(DayActivitie dayActivitie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 15),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFCCFBF1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${dayActivitie.time.substring(0, 5)}",
              style: AppFonts.text14.copyWith(
                color: const Color(0xFF0D9488),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${dayActivitie.activity.action}",
                    style: AppFonts.text16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${dayActivitie.locationActivity.name}",
                        style: AppFonts.text16.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget days(ScheduleDetail schedule) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: schedule.tour.day,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: itemDay(index + 1),
        );
      },
    );
  }

  Widget itemDay(int day) {
    return InkWell(
      onTap: () {
        _cubit.updateDay(day);
      },
      child: Container(
        decoration: BoxDecoration(
          color: _cubit.getDay() == day ? Color(0xFF0D9488) : Color(0xFFEFEDED),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Center(
            child: Text(
              "Ngày $day",
              style:
                  _cubit.getDay() == day
                      ? AppFonts.text18.copyWith(color: AppColors.white)
                      : AppFonts.text18,
            ),
          ),
        ),
      ),
    );
  }
}
