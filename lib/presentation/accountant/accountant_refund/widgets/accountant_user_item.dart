import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:flutter/material.dart';

class AccountantUserItem extends StatelessWidget {
  final User user;
  const AccountantUserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var imageLink = user.avatarPath;
    String name = user.name;
    String bank = user.bank;
    String cardNum = user.bankNumber;
    int money = user.money;
    String email = user.email;
    String phone = user.phone;

    return Container(
      padding: EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              imageLink,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/profile.png");
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name, style: Theme.of(context).textTheme.headlineMedium),
                  Text("Email: $email"),
                  Text("Số điện thoại: $phone"),
                  Text("STK: $cardNum"),
                  Text("Ngân hàng: $bank"),
                  Text("Số tiền: ${FormatterHelper.formatCurrency(money)}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
