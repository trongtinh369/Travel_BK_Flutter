import 'package:flutter/material.dart';

class TextCancelScheduleSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Bạn đã hủy chuyến đi thành công, chúng tôi đã tăng số tiền trong ví của bạn tương ứng (số tiền bạn đã thanh toán - số tiền cọc)",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
