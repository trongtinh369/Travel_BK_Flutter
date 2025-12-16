import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/app/validate_helper.dart';
import 'package:booking_tour_flutter/domain/schedule_book.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/auth/auth_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/book_a_schedule/cubit/book_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/user/book_a_schedule/cubit/book_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/user/pay/cubit/pay_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_toggle_input_field_ic.dart';
import 'package:booking_tour_flutter/presentation/widgets/payment_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookScheduleScreen extends StatelessWidget {
  BookScheduleScreen({super.key});

  late final BookScheduleCubit _cubit;
  late final AuthCubit authCubit;

  final TextEditingController controllerNumPeople = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerSoDienThoai = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _cubit = context.read<BookScheduleCubit>();
    authCubit = context.read<AuthCubit>();
    controllerEmail.text = authCubit.state.email;
    controllerSoDienThoai.text = authCubit.state.phone;

    // sét giá trị lúc ban đầu

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(title: Text("Đặt chuyến đi")),
        body: SingleChildScrollView(child: Center(child: columnOfWidget())),
      ),
    );
  }

  // gom các widget lại
  Widget columnOfWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        BlocBuilder<BookScheduleCubit, BookScheduleState>(
          builder: (context, state) {
            return scheduleInfoCard(state.schedule);
          },
        ),

        SizedBox(height: 20),

        Form(
          key: _formKey,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                notToggleInputFieldNotIcon(
                  controller: controllerNumPeople,
                  title: "Số lượng người tham gia",
                  color: Colors.grey.shade100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'bạn chưa viết gì vào ô này';
                    } else if (!ValidateHelper.kiemTraSo(value)) {
                      return "bạn nên điền số vào đây";
                    }
                    return null;
                  },
                  onChange: (value) {
                    _cubit.rebuild();
                  },
                ),
                SizedBox(height: 12),
                notToggleInputFieldNotIcon(
                  controller: controllerEmail,
                  title: "Email",
                  color: Colors.grey.shade100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'bạn chưa viết gì vào ô này';
                    } else if (!ValidateHelper.isEmailValid(value)) {
                      return "Email này chưa đúng định dạng";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                notToggleInputFieldNotIcon(
                  controller: controllerSoDienThoai,
                  title: "Số điện thoại",
                  color: Colors.grey.shade100,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'bạn chưa viết gì vào ô này';
                    } else if (!ValidateHelper.kiemTraSoDienThoai(value)) {
                      return "số điện thoại chưa đúng định dạng";
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [Text("Hình thức thanh toán", style: AppFonts.text20)],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PaymentRadioGroup(
            // thay đổi hình thức
            onChangedHinhThuc: (value) {
              _cubit.setHinhThuc(hinhThuc: value);
            },
          ),
        ),

        SizedBox(height: 12),

        BlocBuilder<BookScheduleCubit, BookScheduleState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              color: Color(0xFFF6FDFF),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng số tiền: ",
                      style: AppFonts.text14.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${FormatterHelper.formatCurrency(((state.hinhThuc == HinhThuc.thanhtoantoanbo ? state.tienThanhToanHet : state.tienThanhToanCoc) * (int.tryParse(controllerNumPeople.text.trim()) ?? 1)))}",
                      style: AppFonts.text14.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        SizedBox(height: 12),

        BlocListener<BookScheduleCubit, BookScheduleState>(
          listener: (context, state) async {
            if (state.isBooking) {
              final cubit = context.read<PayScheduleCubit>();

              // đẩy id qua cubit của màn đích
              cubit.setId(
                idSchedule: state.schedule.id,
                idBooking: state.idBooking,
              );

              cubit.loadData();

              await Navigator.pushNamed(context, RouteName.paySchedule);

              _cubit.setIsBooking();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<BookScheduleCubit, BookScheduleState>(
              builder: (context, state) {
                return customButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _cubit.booking(
                        userId: authCubit.userId,
                        numPeople: int.parse(controllerNumPeople.text.trim()),
                        email: controllerEmail.text.trim(),
                        phone: controllerSoDienThoai.text.trim(),
                      );
                    }
                  },
                  text: "Thanh toán ngay",
                );
              },
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget scheduleInfoCard(ScheduleTourmanager schedule) {
    var startDate = schedule.startDate;
    var endDate = schedule.endDate;

    var locationName = schedule.tour.provinces
        .map((loc) => loc.name)
        .toSet() // Loại bỏ trùng lặp
        .join(', ');

    return Container(
      width: double.infinity,
      color: AppColors.button,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "${schedule.tour.title}",
                    style: AppFonts.text28.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Số lượng khách
          Row(
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.people, size: 30, color: Colors.red),
              const SizedBox(width: 20),
              Text(
                "số lượng tham gia: ",
                style: AppFonts.text16.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 50),
              Text(
                "${schedule.maxSlot} Người",
                style: AppFonts.text16.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.calendar_today, size: 30, color: Colors.red),

              const SizedBox(width: 20),

              Text(
                "${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}",
                style: AppFonts.text16.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Địa điểm
          Row(
            children: [
              const SizedBox(width: 10),
              const Icon(Icons.location_on, size: 30, color: Colors.red),
              const SizedBox(width: 20),
              Text(
                "Địa điểm là $locationName",
                style: AppFonts.text16.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
