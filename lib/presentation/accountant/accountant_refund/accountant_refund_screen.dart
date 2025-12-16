import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/cubit/accountant_refund_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/cubit/accountant_refund_state.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_refund/widgets/accountant_refund_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantRefundScreen extends StatelessWidget {
  const AccountantRefundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountantRefundCubit, AccountantRefundState>(
      bloc: context.read<AccountantRefundCubit>(),
      builder: (context, state) {
        if (state is AccountantRefundInit) {
          return SizedBox();
        } else if (state is AccountantRefundLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AccountantRefundError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is AccountantRefundLoaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: AccountantRefundItem(user: state.users.elementAt(index)),
              );
            },
          );
        } else {
          return Center(child: Text("Unknown state"));
        }
      },
    );
  }
}
