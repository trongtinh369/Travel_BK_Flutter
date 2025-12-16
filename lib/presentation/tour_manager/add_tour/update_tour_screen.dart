import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/add_tour_screen.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateTourScreen extends StatelessWidget {
  const UpdateTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pickImageCubit = PickImageButtonCubit(
      allowMultiple: true,
      maxImages: 5,
    );
    var images =
        context
            .read<AddTourCubit>()
            .state
            .images
            .where((i) => i.isRight())
            .map((either) => either.fold((_) {}, (url) => url))
            .whereType<String>()
            .toList();
    var imagesOfCubit = images.map((i) => right<XFile, String>(i)).toList();
    pickImageCubit.setImages(imagesOfCubit);

    return BlocProvider(
      create: (_) => pickImageCubit,
      child: AddTourScreen(
        title: "Sửa chuyến đi",
        onSave: () async {
          await DialogHelper.showLoadingDialog();
          var isUpdated = await context.read<AddTourCubit>().update();
          DialogHelper.dismissDialog();
          if (isUpdated) {
            Navigator.pop(AppNavigator.currentContext);
          } else {
            DialogHelper.showInformDialog(Text("Sửa chuyến đi thất bại"));
          }
        },
        addTourCubit: context.read<AddTourCubit>(),
        isAllowChangeAmountDays: false,
      ),
    );
  }
}
