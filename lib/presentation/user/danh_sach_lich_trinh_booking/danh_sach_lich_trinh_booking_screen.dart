import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/cubit/detail_paid_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh_booking/cubit/danh_sach_lich_trinh_booking_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh_booking/cubit/danh_sach_lich_trinh_booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanhSachLichTrinhBookingScreen extends StatelessWidget {
  DanhSachLichTrinhBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userId = context.read<AuthCubit>().state.id;
    var _cubit = context.read<DanhSachLichTrinhBookingCubit>();

    _cubit.syncBooking(userId);

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text("Danh sách lịch trình")),
        body: BlocBuilder<
          DanhSachLichTrinhBookingCubit,
          DanhSachLichTrinhBookingState
        >(
          builder: (context, state) {
            return _buidListBooking(state.booking);
          },
        ),
      ),
    );
  }

  Widget _buidListBooking(List<Booking> bookings) {
    // sap xep
    bookings.sort((a, b) {
      var adate = a.createdAt;
      var bdate = b.createdAt;
      return -adate.compareTo(bdate);
    });

    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _buildCard(context, booking);
      },
    );
  }

  Widget _buildCard(BuildContext context, Booking booking) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          AppNavigator.currentContext
              .read<DetailPaidScheduleCubit>()
              .setBooking(booking);
          await Navigator.pushNamed(
            AppNavigator.currentContext,
            RouteName.profileDetailPaidSchedule,
          );
          context.read<DanhSachLichTrinhBookingCubit>().syncBooking(
            AppNavigator.currentContext.read<AuthCubit>().state.id,
          );
        },
        child: Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 189, 235, 227),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(booking.status.icon, color: booking.status.color),
                    Text(
                      booking.status.name,
                      style: AppFonts.text16.copyWith(
                        color: booking.status.color,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          booking.schedule.tour.tourImages.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(color: Colors.black);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.park,
                                size: 20,
                                color: AppColors.backgroundAppBarTheme,
                              ),
                              Expanded(
                                child: Text(
                                  " ${booking.schedule.tour.title}",
                                  style: AppFonts.text16.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.how_to_vote,
                                size: 20,
                                color: AppColors.delete,
                              ),
                              Text(
                                " ${booking.totalPrice}",
                                style: AppFonts.text16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " / ${booking.numPeople * booking.schedule.finalPrice}",
                                style: AppFonts.text16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.people,
                                size: 20,
                                color: AppColors.textHightLight,
                              ),
                              Text(
                                " ${booking.numPeople}",
                                style: AppFonts.text16.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
