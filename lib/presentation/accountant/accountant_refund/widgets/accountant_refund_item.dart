import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/app/formatter_helper.dart';
import 'package:booking_tour_flutter/domain/user.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/cubit/accountant_refund_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/widgets/accountant_user_item.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantRefundItem extends StatelessWidget {
  final User user;
  const AccountantRefundItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    var imageLink = user.avatarPath;
    String name = user.name;
    String bank = user.bank;
    String bankBranch = user.bankBranch;
    String cardNum = user.bankNumber;
    int money = user.money;
    String email = user.email;
    String phone = user.phone;

    return Container(
      padding: EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.lightRed,
      ),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  _listTile(
                    leading: _itemIcon("assets/images/profile.png"),
                    title: _text(context, name),
                  ),
                  _listTile(
                    leading: _itemIcon("assets/images/bank.png"),
                    title: _text(context, bank),
                  ),
                  _listTile(
                    leading: _itemIcon("assets/images/bank.png"),
                    title: _text(context, bankBranch),
                  ),
                  _listTile(
                    leading: _itemIcon("assets/images/credit_card.png"),
                    title: _text(context, cardNum),
                  ),
                  _listTile(
                    leading: _itemIcon("assets/images/money.png"),
                    title: _text(
                      context,
                      FormatterHelper.formatCurrency(money),
                    ),
                  ),
                  _listTile(
                    leading: _itemIcon("assets/images/email.png"),
                    title: _text(context, email),
                  ),
                  _listTile(
                    leading: _itemIcon("assets/images/phone.png"),
                    title: _text(context, phone),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BkButton(
                        onPressed: () async {
                          var isSubmit = await DialogHelper.showConfirmDialog(
                            body: _bodyDialogDeleteRefund(context),
                          );

                          if (isSubmit && context.mounted) {
                            await context
                                .read<AccountantRefundCubit>()
                                .submitRefund(user.id);
                          }
                        },
                        title: "Xóa",
                        backgroundColor: AppColors.delete,
                      ),
                      SizedBox(width: 10),
                      BkButton(
                        onPressed: () async {
                          var isSubmit = await DialogHelper.showConfirmDialog(
                            body: _bodyDialogSubmitRefund(context),
                          );

                          if (isSubmit && context.mounted) {
                            await context
                                .read<AccountantRefundCubit>()
                                .submitRefund(user.id);
                          }
                        },
                        title: "Đã thanh toán",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyDialogDeleteRefund(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            text: "Bạn có chắc muốn ",
            children: [
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.delete,
                  fontWeight: FontWeight.bold,
                ),
                text: "xóa yêu cầu thanh toán hoàn tiền ",
              ),
              TextSpan(
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                text: "của",
              ),
            ],
          ),
        ),
        AccountantUserItem(user: user),
      ],
    );
  }

  Widget _bodyDialogSubmitRefund(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge,
            text: "Bạn có chắc muốn ",
            children: [
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.backgroundAppBarTheme,
                ),
                text: "xác nhận đã thanh toán ",
              ),
              TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                text: "cho",
              ),
            ],
          ),
        ),
        AccountantUserItem(user: user),
      ],
    );
  }

  Widget _itemIcon(String asset) {
    return Container(width: 30, height: 30, child: Image.asset(asset));
  }

  Widget _text(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _listTile({required Widget leading, required Widget title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [leading, SizedBox(width: 10), Expanded(child: title)],
      ),
    );
  }
}
