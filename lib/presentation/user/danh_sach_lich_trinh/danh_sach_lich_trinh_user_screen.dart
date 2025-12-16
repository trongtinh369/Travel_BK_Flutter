import 'package:booking_tour_flutter/app/dependency_injection/format_date_number.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/book_a_schedule/cubit/book_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh/cubit/danh_sach_lich_trinh_user_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh/cubit/danh_sach_lich_trinh_user_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanhSachLichTrinhUserScreen extends StatelessWidget {
  DanhSachLichTrinhUserScreen({super.key});

  late BookScheduleCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.read<BookScheduleCubit>();

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final tourId = arguments['tourId'] as int;
    final userId = context.read<AuthCubit>().userId;
    return BlocProvider(
      create: (_) => DanhSachLichTrinhUserCubit()..loadSchedules(tourId),
      child: Scaffold(
        appBar: AppBar(title: Text("Booking tour")),
        backgroundColor: AppColors.white,
        body:
            BlocBuilder<DanhSachLichTrinhUserCubit, DanhSachLichTrinhUserState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Text(
                        "Lịch trình sắp tới",
                        style: TextStyle(
                          fontSize: AppFonts.fontSize18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.schedules.length,
                        itemBuilder: (context, index) {
                          return _buildLichTrinhCard(
                            state.schedules[index],
                            context,
                            userId,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }

  Widget _buildLichTrinhCard(
    ScheduleTourmanager scheduleTourmanager,
    context,
    int userId,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              scheduleTourmanager.tour.tourImages.isNotEmpty
                  ? scheduleTourmanager.tour.tourImages.first
                  : '',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 200,
                    color: AppColors.white,
                    child: Icon(Icons.image, size: 50, color: AppColors.gray),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scheduleTourmanager.tour.title,
                  style: TextStyle(
                    fontSize: AppFonts.fontSize18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildInfoRow(
                  "Số người :",
                  '${scheduleTourmanager.bookedSlot} / ${scheduleTourmanager.maxSlot.toString()} ',
                ),
                SizedBox(height: 12),
                _buildInfoRow(
                  "Thời gian :",
                  "${scheduleTourmanager.endDate.difference(scheduleTourmanager.startDate).inDays + 1} ngày",
                ),
                SizedBox(height: 8),
                _buildInfoRow(
                  "Địa điểm :",
                  (scheduleTourmanager.tour.provinces.isNotEmpty &&
                          (scheduleTourmanager
                              .tour
                              .provinces
                              .first
                              .name
                              .isNotEmpty))
                      ? scheduleTourmanager.tour.provinces.first.name
                      : "Không có tỉnh thành",
                ),
                SizedBox(height: 8),
                _buildInfoRow(
                  "Ngày bắt đầu :",
                  formatDate(scheduleTourmanager.startDate).toString(),
                ),
                SizedBox(height: 8),
                _buildInfoRow(
                  "Ngày kết thúc :",
                  formatDate(scheduleTourmanager.endDate).toString(),
                ),
                SizedBox(height: 8),
                Text(
                  "${formatCurrency(scheduleTourmanager.finalPrice).toString()} VNĐ/ 1 người",
                  style: TextStyle(
                    fontSize: AppFonts.fontSize14,
                    color: AppColors.delete,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BkButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'chi_tiet_lich_trinh_screen',
                          arguments: {
                            'scheduleTourmanager': scheduleTourmanager,
                          },
                        );
                      },
                      title: "Chi tiết",
                      backgroundColor: AppColors.borderButton,
                      borderRadius: 32,
                    ),
                    const SizedBox(width: 8),
                    BkButton(
                      onPressed: () async {
                        cubit.setIdSchedule(scheduleTourmanager.id);

                        cubit.loadData();

                        await Navigator.pushNamed(
                          context,
                          RouteName.bookSchedule,
                        );
                      },
                      title: "Đặt ngay",
                      borderRadius: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: AppFonts.fontSize14,
              color: AppColors.gray,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: AppFonts.fontSize14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
