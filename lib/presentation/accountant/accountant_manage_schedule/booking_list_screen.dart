import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/domain/booking.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/cubit/accountant_manage_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingListScreen extends StatelessWidget {
  final BookingStatus status;
  final List<Booking> bookings;
  final AccountantManageScheduleCubit cubit;
  BookingListScreen({
    required this.status,
    required this.bookings,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(child: Text("Danh sách trống", style: AppFonts.text18)),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child:
              status.id == BookingStatus.processingId
                  ? bookingCardNotYetPaid(bookings[index])
                  : bookingCard(bookings[index]),
        );
      },
    );
  }

  Widget bookingCardNotYetPaid(Booking booking) {
    DateTime timeNow = DateTime.now();
    bool check = timeNow.isBefore(booking.expiredAt);
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFDF9F9),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/profile.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 20),
                        Text("${booking.user.name}", style: AppFonts.text18),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: check ? Color(0xFF55E548) : Color(0xFFE61717),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        check ? "Còn hạn" : "Hết hạn",
                        style: AppFonts.text18.copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/email.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text("${booking.email}", style: AppFonts.text18)),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/phone.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Text("${booking.phone}", style: AppFonts.text18),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/group_of_people.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Text("${booking.numPeople} Người", style: AppFonts.text18),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFFFFF5F5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tổng số tiền:", style: AppFonts.text18),
                    Text(
                      "${booking.schedule.finalPrice * booking.numPeople}",
                      style: AppFonts.text18,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Số tiền cọc:", style: AppFonts.text18),
                    Text("${booking.totalPrice}", style: AppFonts.text18),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: customButton(
                  onPressed: () async {
                    var check = await DialogHelper.showConfirmDialog(
                      body: itemDialogPayDeposit(booking),
                    );

                    if (check) {
                      cubit.updateStatusBooking(
                        id: booking.id,
                        statusId: BookingStatus.depositId,
                      );
                    }
                  },
                  text: "Đặt cọc",
                  colorButton: Color(0xFFF5CD3E),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 6,
                child: customButton(
                  onPressed: () async {
                    var check = await DialogHelper.showConfirmDialog(
                      body: itemDialogPay(booking),
                    );

                    if (check) {
                      cubit.updateStatusBooking(
                        id: booking.id,
                        statusId: BookingStatus.payId,
                      );
                    }
                  },
                  text: "Thanh toán hết",
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: customButton(
                  onPressed: () async {
                    var check = await DialogHelper.showConfirmDialog(
                      body: Center(child: Text("Bạn có chắc chắn muốn xóa booking này không", style: AppFonts.text16,)),
                    );

                    if (check) {
                      cubit.deleteBooking(bookingId: booking.id);
                    }
                  },
                  text: "Xóa",
                  colorButton: Color(0xFFFA6565),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemDialogPayDeposit(Booking booking) {
    return Column(
      children: [
        Row(
          children: [
            Text("Bạn ", style: AppFonts.text18),
            Text(
              "xác nhận đã đặt cọc",
              style: AppFonts.text18.copyWith(color: Color(0xFFF5CD3E)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/profile.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20),
                      Text("${booking.user.name}", style: AppFonts.text18),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    "assets/images/email.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text("${booking.email}", style: AppFonts.text18),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    "assets/images/phone.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Text("${booking.phone}", style: AppFonts.text18),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    "assets/images/group_of_people.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Text("${booking.numPeople} Người", style: AppFonts.text18),
                ],
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF5F5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền:", style: AppFonts.text18),
                        Text("${booking.totalPrice}", style: AppFonts.text18),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget itemDialogPay(Booking booking) {
    return Column(
      children: [
        Row(
          children: [
            Text("Bạn ", style: AppFonts.text18),
            Text(
              "Xác nhận thanh toán hết",
              style: AppFonts.text18.copyWith(color: Color(0xFF3DE22E)),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/profile.png",
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20),
                      Text("${booking.user.name}", style: AppFonts.text18),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    "assets/images/email.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text("${booking.email}", style: AppFonts.text18),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    "assets/images/phone.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Text("${booking.phone}", style: AppFonts.text18),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Image.asset(
                    "assets/images/group_of_people.png",
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  Text("${booking.numPeople} Người", style: AppFonts.text18),
                ],
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF5F5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền:", style: AppFonts.text18),
                        Text("${booking.totalPrice}", style: AppFonts.text18),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bookingCard(Booking booking) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFDF9F9),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("#${booking.code}", style: AppFonts.text18),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/profile.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Text("${booking.user.name}", style: AppFonts.text18),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/email.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Expanded(child: Text("${booking.email}", style: AppFonts.text18)),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/phone.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Text("${booking.phone}", style: AppFonts.text18),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/group_of_people.png",
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Text("${booking.numPeople} người", style: AppFonts.text18),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFFFFF5F5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tổng tiền:", style: AppFonts.text18),
                    Text(
                      "${booking.schedule.finalPrice * booking.numPeople}",
                      style: AppFonts.text18,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Đã thanh toán:", style: AppFonts.text18),
                    Text("${booking.totalPrice}", style: AppFonts.text18),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Còn lại:", style: AppFonts.text18),
                    Text(
                      "${booking.schedule.finalPrice * booking.numPeople - booking.totalPrice}",
                      style: AppFonts.text18.copyWith(color: Color(0xFF730909)),
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
}
