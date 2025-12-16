import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class TextConfirmCancelSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Bạn có chắc muốn ",
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(
            text: "hủy chuyến đi. ",
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: AppColors.error),
          ),
          TextSpan(
            text:
                "Nếu bạn đã thanh toán toàn bộ, và bạn hủy chuyến đi, chúng tôi sẽ tăng số tiền trong ví của bạn lên tương ứng (số tiền thanh toán toàn bộ - số tiền cọc)",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
