import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/change_schedule/cubit/change_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/cubit/detail_paid_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/cubit/detail_paid_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/widgets/info_row.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/widgets/info_two_row.dart';
import 'package:booking_tour_flutter/presentation/profile/detail_paid_schedule/widgets/text_confirm_cancel_schedule.dart';
import 'package:booking_tour_flutter/presentation/user/danh_sach_lich_trinh_booking/cubit/danh_sach_lich_trinh_booking_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/qr_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPaidScheduleScreen extends StatelessWidget {
  DetailPaidScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<DetailPaidScheduleCubit>();

    return Scaffold(
      appBar: AppBar(title: Text("Du lịch vũng tàu")),
      body: BlocConsumer<DetailPaidScheduleCubit, DetailPaidScheduleState>(
        bloc: _cubit,
        listener: (context, state) async {
          if (state.errorMessage != null) {
            await DialogHelper.showInformDialog(Text(state.errorMessage!));
          }
          if (state.message != null) {
            await DialogHelper.showInformDialog(Text(state.message!));

            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              //tour
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundAppBarTheme,
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                          "Chuyến đi ${state.booking.schedule.tour.title}",
                          textAlign: TextAlign.center,
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
                          "Mã chuyến đi: ${state.booking.schedule.code}",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/calender.png',
                          width: 32,
                          height: 32,
                        ),
                        title: Text(
                          "${FormatterHelper.formatDate(state.booking.schedule.startDate)} - ${FormatterHelper.formatDate(state.booking.schedule.endDate)}",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/start_place.png',
                          width: 32,
                          height: 32,
                        ),
                        title: Text(
                          "Khởi hành từ Tp. Hồ Chí Minh",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //booking
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InfoRow(
                        label: Text(
                          "Loại thanh toán",
                          style: Theme.of(context).textTheme.bodyLarge!,
                        ),
                        content: Text(
                          state.booking.status.nameVn,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: state.booking.status.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      InfoRow(
                        label: Text("Tổng số tiền"),
                        content: Text(
                          FormatterHelper.formatCurrency(
                            state.booking.totalPrice,
                          ),
                        ),
                      ),
                      InfoRow(
                        label: Text("Email"),
                        content: Text(state.booking.email),
                      ),
                      InfoRow(
                        label: Text("Số điện thoại"),
                        content: Text(state.booking.phone),
                      ),
                      InfoRow(
                        label: Text("Tổng số người"),
                        content: Text(state.booking.numPeople.toString()),
                      ),
                    ],
                  ),
                ),
              ),
              //total money
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: InfoTwoRow(
                    title: "Tổng số tiền",
                    content: FormatterHelper.formatCurrency(
                      state.booking.schedule.finalPrice *
                          state.booking.numPeople,
                    ),
                  ),
                ),
              ),

              //total paid
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: InfoTwoRow(
                    title: "Số tiền đã thanh toán",
                    content: FormatterHelper.formatCurrency(
                      state.booking.totalPrice,
                    ),
                  ),
                ),
              ),

              //money have to pay left
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: InfoTwoRow(
                    title: "Số tiền còn lại",
                    content: FormatterHelper.formatCurrency(
                      state.booking.schedule.finalPrice *
                              state.booking.numPeople -
                          state.booking.totalPrice,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Visibility(
                  visible:
                      state.booking.status.id == BookingStatus.processingId,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      QrCodeWidget(
                        qr: state.booking.qr,
                        expiredAt: state.booking.expiredAt,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),

              SliverToBoxAdapter(
                child: SizedBox(
                  child: Center(
                    child: BkButton(
                      onPressed: () async {
                        _cubit.changeSchedule();
                      },
                      title: "Đổi chuyến đi",
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 5,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  child: Center(
                    child: BkButton(
                      onPressed: () async {
                        var result = await DialogHelper.showConfirmDialog(
                          body: TextConfirmCancelSchedule(),
                        );

                        if (!result) return;

                        if (context.mounted) {
                          _cubit.deleteBooking();
                        }
                      },
                      title: "Hủy chuyến đi",
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 5,
                      ),
                      backgroundColor: AppColors.warning,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
