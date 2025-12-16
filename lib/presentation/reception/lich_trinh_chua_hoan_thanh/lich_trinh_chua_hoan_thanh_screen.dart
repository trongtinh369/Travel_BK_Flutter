import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/schedule_reception.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';
import 'package:booking_tour_flutter/presentation/reception/kiem_tra_nguoi_tham_gia/cubit/kiem_tra_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/lich_trinh_chua_hoan_thanh/cubit/lich_trinh_chua_hoan_thanh_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/lich_trinh_chua_hoan_thanh/cubit/lich_trinh_chua_hoan_thanh_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LichTrinhChuaHoanThanhScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LichTrinhChuaHoanThanhCubit()..syncScheduleReception(),
      child: Scaffold(
        appBar: AppBar(title: Text("Lịch trình chưa hoàn thành")),
        body: BlocListener<
          LichTrinhChuaHoanThanhCubit,
          LichTrinhChuaHoanThanhState
        >(
          listenWhen: (previous, current) {
            return previous.scheduleReception != current.scheduleReception;
          },
          listener: (context, state) {
            if (state.scheduleReception.isNotEmpty) {
              context.read<LichTrinhChuaHoanThanhCubit>().syncUserCompletedScheduleBySchedule(
                state.scheduleReception.map((s) => s.id).toList(),
              );
            }
          },
          child: BlocBuilder<
            LichTrinhChuaHoanThanhCubit,
            LichTrinhChuaHoanThanhState
          >(
            builder: (context, state) {
              return buildListSchedule(state, context, state.scheduleReception);
            },
          ),
        ),
      ),
    );
  }

  Widget buildListSchedule(
    LichTrinhChuaHoanThanhState state,
    BuildContext context,
    List<ScheduleReception> scheduleReceptions,
  ) {
    return ListView.builder(
      itemCount: scheduleReceptions.length,
      itemBuilder: (context, index) {
        final scheduleReception = scheduleReceptions[index];
        return buildCard(state, context, scheduleReception);
      },
    );
  }

  Widget buildCard(
    LichTrinhChuaHoanThanhState state,
    BuildContext context,
    ScheduleReception scheduleReception,
  ) {
    
    // lay booking ra theo id lich trinh
    final userCompletedForThisSchedule = state.booking[scheduleReception.id] ?? [];
    print("hehehe ${userCompletedForThisSchedule.length}");

    // lay sl nguoi da coc, thanh toan
    int countByStatus(List<Booking> list, int statusId) {
      return list.where((item) => item.status.id == statusId).length;
    }

    int datCoc = countByStatus(userCompletedForThisSchedule, 2);
    int thanhToan = countByStatus(userCompletedForThisSchedule, 3);

    return InkWell(
      onTap: () {
        context.read<KiemTraNguoiThamGiaCubit>().syncBooking(scheduleReception.id);
        Navigator.pushNamed(AppNavigator.currentContext, RouteName.kiemTraNguoiThamGia);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 189, 235, 227),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      scheduleReception.tour.tourImages.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.black);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Mã: ",
                                style: AppFonts.text14.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                scheduleReception.code,
                                style: AppFonts.text14.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.park, size: 20, color: AppColors.button),
                              Text(
                                "${scheduleReception.tour.title.substring(0, 20)} ...",
                                style: AppFonts.text14.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 144, 184, 102),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Thanh toán: ",
                                          style: AppFonts.text14.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${thanhToan}",
                                          style: AppFonts.text14.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 100, 204, 199),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Đã cọc ",
                                          style: AppFonts.text14.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${datCoc}",
                                          style: AppFonts.text14.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
