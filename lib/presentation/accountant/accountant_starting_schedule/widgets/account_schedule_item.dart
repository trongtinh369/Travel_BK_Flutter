
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/domain/schedule_user_completed.dart';
import 'package:flutter/material.dart';

class AccountantScheduleItem extends StatelessWidget {
  final double _horizontalPadding = 10;
  final ScheduleTourmanager schedule;

  const AccountantScheduleItem({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    var imageLink = schedule.tour.tourImages.first;
    var code = schedule.code;
    var name = schedule.tour.title;
    int processing = schedule.processingBooking;
    int deposit = schedule.depositBooking;
    int paid = schedule.paidBooking;
    DateTime startDate = schedule.startDate;
    DateTime endDate = schedule.endDate;
    int maxSlot = schedule.maxSlot;
    String provinces = schedule.tour.provinces.map((p) => p.name).toList().join(", ");
    int days = schedule.tour.day;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
            color: Colors.grey.shade400,
            offset: Offset(3, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.network(imageLink, fit: BoxFit.fill),
            ),
            Text(" # $code", style: Theme.of(context).textTheme.headlineMedium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Text(
                name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Text(
                "Tình trạng thanh toán",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          processing.toString(),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text("Chờ xử lý"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          deposit.toString(),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text("Đã đặt cọc"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          paid.toString(),
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text("Đã thanh toán"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${FormatterHelper.formatDate(startDate)} - ${FormatterHelper.formatDate(endDate)}",

                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "$maxSlot Khách",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(provinces, style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis,),
                  Text(
                    "$days Ngày",

                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
