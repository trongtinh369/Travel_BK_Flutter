import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/add_tour_screen.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealAddTourScreen extends StatelessWidget {
  const RealAddTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pickImageCubit = PickImageButtonCubit(
      allowMultiple: true,
      maxImages: 5,
    );

    return BlocProvider(
      create: (_) => pickImageCubit,
      child: AddTourScreen(
        title: "Thêm chuyến đi",
        onSave: () async {
          await DialogHelper.showLoadingDialog();
          var isAdded = await context.read<AddTourCubit>().add();
          DialogHelper.dismissDialog();
          if (isAdded) {
            Navigator.pop(AppNavigator.currentContext);
          }
          else {
            DialogHelper.showInformDialog(Text("Thêm chuyến đi thất bại"));
          }
        },
        addTourCubit: context.read<AddTourCubit>()..resetState(),
        isAllowChangeAmountDays: true,
      ),
    );
  }
}
