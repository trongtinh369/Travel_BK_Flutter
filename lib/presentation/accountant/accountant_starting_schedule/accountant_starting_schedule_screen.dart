import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/booking_status.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_manage_schedule/cubit/accountant_manage_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/cubit/accountant_starting_schedule_cubit.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/cubit/accountant_starting_schedule_state.dart';
import 'package:booking_tour_flutter/presentation/accountant/accountant_starting_schedule/widgets/account_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountantStartingScheduleScreen extends StatelessWidget {
  const AccountantStartingScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      AccountantStartingScheduleCubit,
      AccountantStartingScheduleState
    >(
      bloc: context.read<AccountantStartingScheduleCubit>(),
      builder: (context, state) {
        if (state is AccountantStartingScheduleInit) {
          return SizedBox();
        } else if (state is AccountantStartingScheduleLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AccountantStartingScheduleError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is AccountantStartingScheduleLoaded) {
          return ListView.builder(
            itemCount: state.schedules.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: InkWell(
                  onTap: () async {
                    var accountManagementScheduleCubit = context.read<AccountantManageScheduleCubit>();
                    accountManagementScheduleCubit.setBooking(state.schedules[index]);

                    await accountManagementScheduleCubit.loadData();
                    accountManagementScheduleCubit.setStatus(status: BookingStatus(id: 1, name: ""));


                    await Navigator.pushNamed(context, RouteName.accountantManageScheduleScreen);
                  },
                  child: AccountantScheduleItem(
                    schedule: state.schedules.elementAt(index),
                  ),
                ),
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
