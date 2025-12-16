import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/user_completed_schedule.dart';
import 'package:booking_tour_flutter/presentation/reception/kiem_tra_nguoi_tham_gia/cubit/kiem_tra_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/lich_trinh_chua_hoan_thanh/cubit/lich_trinh_chua_hoan_thanh_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/xac_nhan_so_nguoi_tham_gia/cubit/xac_nhan_so_nguoi_tham_gia_cubit.dart';
import 'package:booking_tour_flutter/presentation/reception/xac_nhan_so_nguoi_tham_gia/cubit/xac_nhan_so_nguoi_tham_gia_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_icon_toggle_input_field.dart';
import 'package:booking_tour_flutter/presentation/widgets_dialog/dialog_noti.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class XacNhanSoNguoiThamGiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _cubit = context.read<XacNhanSoNguoiThamGiaCubit>();
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Xác nhận số người tham gia")),
      body: BlocBuilder<XacNhanSoNguoiThamGiaCubit, XacNhanSoNguoiThamGiaState>(
        builder: (context, state) {
          return Column(
            children: [
              buildInf(controller, state.booking),

              SizedBox(height: 50),
              DeleteButtonWidget(
                onDelete: () async {
                  final input = controller.text.trim();
                  if (!input.isEmpty && int.parse(controller.text) <= state.booking.numPeople) {
                    String text = "đã tham gia";
                      final confirm = await DialogNoti.confirm(
                        context: context,
                        title: "Thông báo",
                        message:
                            "Xác nhận khách hàng ${state.booking.user.name} \n ${text} chuyến đi.",
                        highlightPhrases: [text],
                        colorHighlight: Colors.green,
                      );
                      if (!confirm) return;

                      await _cubit.createUserCompletedSchedule(state.booking.id, int.parse(controller.text));
                      await context.read<KiemTraNguoiThamGiaCubit>().syncBooking(state.booking.schedule.id);
                      Navigator.pop(context);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vui lòng nhập đúng số người tham gia!")));
                  }
                },
                backgroundColor: AppColors.button,
                text: "Xác nhận",
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildInf(
    TextEditingController controller,
    Booking booking,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (booking.status.id == 2) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text("${booking.status.name}"),
                  ),
                ),
              ],
            ),
          ],

          if (booking.status.id == 3) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text("${booking.status.name}"),
                  ),
                ),
              ],
            ),
          ],

          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                child: ClipOval(
                  child: Image.network(
                    booking.user.avatarPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.black);
                    },
                  ),
                ),
              ),
              SizedBox(width: 20),
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
                        booking.user.name,
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
                        booking.status.id == 2
                              ? "${(booking.schedule.finalPrice * booking.numPeople) - ((booking.schedule.finalPrice * booking.numPeople) * (booking.schedule.desposit / 100))}"
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
                        "${booking.numPeople}",
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
                        "${booking.phone}",
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

          SizedBox(height: 20),
          notIconToggleInputField(
            controller,
            "Số người tham gia",
            "0",
            Colors.grey.shade200,
            isNumber: true
          ),
        ],
      ),
    );
  }
}
