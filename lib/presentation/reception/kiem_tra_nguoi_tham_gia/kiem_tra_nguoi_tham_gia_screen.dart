import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/presentation/reception/kiem_tra_nguoi_tham_gia/cubit/kiem_tra_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/kiem_tra_nguoi_tham_gia/cubit/kiem_tra_nguoi_tham_gia_state.dart';
import 'package:booking_tour_flutter/presentation/reception/xac_nhan_so_nguoi_tham_gia/cubit/xac_nhan_so_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/dialog_noti.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/loading_dialog.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KiemTraNguoiThamGiaScreen extends StatelessWidget {
  KiemTraNguoiThamGiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<KiemTraNguoiThamGiaCubit>();

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text("Kiểm tra người tham gia")),
        body: BlocBuilder<KiemTraNguoiThamGiaCubit, KiemTraNguoiThamGiaState>(
          builder: (context, state) {
            if (state.isLoading == true) {
              return Center(child: LoadingDialog());
            }
            return buildListPeople(_cubit, state.booking);
          },
        ),
        backgroundColor: AppColors.secondary,
      ),
    );
  }

  Widget buildListPeople(
    KiemTraNguoiThamGiaCubit cubit,
    List<Booking> booking,
  ) {
    return ListView.builder(
      itemCount: booking.length,
      itemBuilder: (context, index) {
        final bookings = booking[index];
        if (bookings.status.id != 1) {
          return buildCard(cubit, context, bookings);
        }
      },
    );
  }

  Widget buildCard(
    KiemTraNguoiThamGiaCubit cubit,
    BuildContext context,
    Booking bookings,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (bookings.status.id == 2) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "${bookings.status.name}",
                        style: AppFonts.text14.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                if (bookings.status.id == 3) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "${bookings.status.name}",
                        style: AppFonts.text14.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: Image.network(
                      bookings.user.avatarPath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.black);
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tên: ",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bookings.user.name,
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Số tiền phải trả: ",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          bookings.status.id == 2
                              ? "${(bookings.schedule.finalPrice * bookings.numPeople) - ((bookings.schedule.finalPrice * bookings.numPeople) * (bookings.schedule.desposit / 100))}"
                              : "0",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          " vnd",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Số người tham gia: ",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${bookings.numPeople}",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " người",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "SĐT: ",
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bookings.phone,
                          style: AppFonts.text14.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (cubit.isUserParticipated(bookings.id)) ...[
                  DeleteButtonWidget(
                    onDelete: () async {
                      String text = "huỷ tham gia";
                      final confirm = await DialogNoti.confirm(
                        context: context,
                        title: "Thông báo huỷ tham gia",
                        message:
                            "Xác nhận khách hàng ${bookings.user.name} \n ${text} chuyến đi.",
                        highlightPhrases: [text],
                      );
                      if (!confirm) return;
                      await cubit.deleteUserCompletedSchedule(bookings.id);
                      cubit.syncBooking(bookings.schedule.id);
                    },
                    text: "Xác nhận chưa tham gia",
                    backgroundColor: AppColors.delete,
                  ),
                ],
                if (!cubit.isUserParticipated(bookings.id)) ...[
                  DeleteButtonWidget(
                    onDelete: () async {
                      context
                          .read<XacNhanSoNguoiThamGiaCubit>()
                          .setUserCompletedSchedule(bookings);
                      await Navigator.pushNamed(
                        AppNavigator.currentContext,
                        RouteName.xacNhanSoNguoiThamGia,
                      );
                    },
                    text: "Xác nhận tham gia",
                    backgroundColor: AppColors.button,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
