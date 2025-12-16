import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/change_schedule/cubit/change_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/change_schedule/cubit/change_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/cubit/detail_paid_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh_booking/cubit/danh_sach_lich_trinh_booking_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeScheduleScreen extends StatelessWidget {
  const ChangeScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Các lịch trình để đổi")),
      body: _buildAll(context),
    );
  }

  Widget _buildAll(BuildContext context) {
    return BlocConsumer<ChangeScheduleCubit, ChangeScheduleState>(
      bloc: context.read<ChangeScheduleCubit>(),
      listener: (context, state) async {
        if (state is ChangedSchedule) {
          await DialogHelper.showInformDialog(Text("Đổi chuyến đi thành công"));
          context.read<DanhSachLichTrinhBookingCubit>().syncBooking(context.read<AuthCubit>().state.id);
          context.read<DetailPaidScheduleCubit>().setBooking(state.booking);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
        if (state is ChangeScheduleLoadFail) {
          //await DialogHelper.showInformDialog(Text(state.message));
          await DialogHelper.showInformDialog(Text("Lỗi đã xảy ra"));
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      builder: (context, state) {
        if (state is ChangeScheduleLoadSuccess) {
          return _buildSuccess(context, state);
        }
        if (state is ChangeScheduleLoadFail) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSuccess(BuildContext context, ChangeScheduleLoadSuccess state) {
    if (state.schedules.isEmpty) {
      return Center(child: Text("Chưa có lịch trình đi phù hợp"));
    }

    return ListView.builder(
      itemCount: state.schedules.length,
      itemBuilder: (context, index) {
        var schedule = state.schedules[index];
        var tour = schedule.tour;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundAppBarTheme,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Image.asset(
                          'assets/images/destination_place.png',
                          width: 32,
                          height: 32,
                        ),
                        title: Text(
                          tour.title,
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(color: AppColors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/code.png',
                          width: 32,
                          height: 32,
                        ),
                        title: Text(
                          "Mã lịch trình: ${schedule.code}",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(color: AppColors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/calender.png',
                          width: 32,
                          height: 32,
                        ),
                        title: Text(
                          "${FormatterHelper.formatDate(schedule.startDate)} - ${FormatterHelper.formatDate(schedule.endDate)}",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(color: AppColors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: BkButton(
                      onPressed: () async {
                        await context.read<ChangeScheduleCubit>().changeBooking(
                          schedule.id,
                        );
                      },
                      title: "Xác nhận",
                      backgroundColor: AppColors.warning,
                      textColor: AppColors.black,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
