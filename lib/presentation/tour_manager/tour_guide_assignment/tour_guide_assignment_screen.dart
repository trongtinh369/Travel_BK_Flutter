import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/schedule_assignment_tourguide.dart';
import 'package:booking_tour_flutter/domain/tour_guide.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/tour_guide_assignment/cubit/tour_guide_assignment_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/tour_guide_assignment/cubit/tour_guide_assignment_state.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/search_bar_new.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourGuideAssignmentScreen extends StatelessWidget {
  final TextEditingController _controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<TourGuideAssignmentCubit>();

    return BlocProvider<TourGuideAssignmentCubit>.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Phân công hướng dẫn viên')),
        body: columnOfWidget(_cubit),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget(TourGuideAssignmentCubit _cubit) {
    final context = AppNavigator.currentContext;

    return Column(
      children: [
        SizedBox(height: 30),

        scheduleCard(),

        SizedBox(height: 5),

        SearchBarNewWidget(
          controller: _controllerSearch,
          onClear: () {
            _controllerSearch.clear();
            _cubit.searchTourGuides('');
          },
          onChanged: (value) => _cubit.searchTourGuides(value),
          hintText: "Tìm kiếm nhân viên ...",
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column(
            children: [
              customButton(
                onPressed: () async {
                  var isSuccess = await _cubit.touchButton();

                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('Xác nhận thành công')),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('Xác nhận thất bại')),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
                text: "Xác Nhận",
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(child: tourGuideCard(_cubit)),
      ],
    );
  }

  // quản lý tourGuide
  Widget tourGuideCard(TourGuideAssignmentCubit _cubit) {
    return BlocSelector<
      TourGuideAssignmentCubit,
      TourGuideAssignmentState,
      List<TourGuide>
    >(
      selector: (state) => state.tourGuidesSearch,
      builder: (context, tourGuides) {
        if (tourGuides.isEmpty) {
          return Center(child: Text('No tour guides available'));
        }

        return ListView.builder(
          itemCount: tourGuides.length,
          itemBuilder: (context, index) {
            final tourGuide = tourGuides[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: staffCard(
                tourGuide: tourGuide,
                onCheckChanged: (bool? value) {
                  _cubit.toggleTourGuideCheck(tourGuide.userId, value!);
                },
              ),
            );
          },
        );
      },
    );
  }

  // item tourGuide
  Widget staffCard({
    required TourGuide tourGuide,
    required Function(bool?) onCheckChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF9F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      tourGuide.user.avatarPath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            width: 60,
                            height: 60,
                            child: const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 30),

              // Thông tin nhân viên
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 30,
                        color: Colors.black,
                      ),

                      const SizedBox(width: 14),

                      Text(
                        tourGuide.user.name,
                        style: AppFonts.text16.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Mã nhân viên
                  Row(
                    children: [
                      const Icon(Icons.code, size: 30, color: Colors.black),

                      const SizedBox(width: 14),

                      Text(
                        tourGuide.code,
                        style: AppFonts.text16.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Email
                  Row(
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Color(0xFFEA4335),
                      ),

                      const SizedBox(width: 14),

                      Text(
                        tourGuide.user.email,
                        style: AppFonts.text16.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Số điện thoại
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        size: 30,
                        color: Colors.black54,
                      ),

                      const SizedBox(width: 14),

                      Text(
                        tourGuide.user.phone,
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

          // Checkbox
          Checkbox(
            value: tourGuide.ischecked,
            onChanged: (bool? value) {
              onCheckChanged(value);
            },

            activeColor: Colors.black,

            checkColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  // quản lý Schedule
  Widget scheduleCard() {
    return BlocSelector<
      TourGuideAssignmentCubit,
      TourGuideAssignmentState,
      ScheduleAssignmentTourguide
    >(
      selector: (state) => state.schedule,
      builder: (context, schedule) {
        return scheduleInfoCard(schedule: schedule);
      },
    );
  }

  Widget scheduleInfoCard({required ScheduleAssignmentTourguide schedule}) {
    var startDate = schedule.startDate;
    var endDate = schedule.endDate;

    final locationNames = schedule.tour.locations
        .map((loc) => loc.name)
        .join(', ');

    return Container(
      width: double.infinity,
      color: AppColors.button,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mã lịch trình
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Mã Lịch Trình: ${schedule.code}",
                  style: AppFonts.text32.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
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
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.red,
                  ),
          
                  const SizedBox(width: 8),
          
                  Text(
                    "${startDate.day}/${startDate.month}/${startDate.year}",
                    style: AppFonts.text16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          
                  const SizedBox(width: 15),
          
                  const Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.black54,
                  ),
          
                  const SizedBox(width: 15),
          
                  Text(
                    "${endDate.day}/${endDate.month}/${endDate.year}",
                    style: AppFonts.text16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 8),
          
              // Địa điểm
              Row(
                children: [
                  const Icon(Icons.location_on, size: 20, color: Colors.red),
                  const SizedBox(width: 30),
                  Text(
                    locationNames,
                    style: AppFonts.text16.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
          
              const SizedBox(height: 8),
          
              // tour title
              Row(
                children: [
                  const Icon(Icons.tour, size: 20, color: Color(0xFF1B5621)),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      schedule.tour.title,
                      style: AppFonts.text16.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
          
              // Số lượng khách
              Row(
                children: [
                  const Icon(Icons.people, size: 20, color: Colors.orange),
                  const SizedBox(width: 30),
                  Text(
                    "Tối đa: ${schedule.maxSlot}",
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
