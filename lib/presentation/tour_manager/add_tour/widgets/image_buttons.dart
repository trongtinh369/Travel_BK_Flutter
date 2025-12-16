import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';

class ImageButtons extends StatelessWidget {
  final PickImageButtonCubit pickImageCubit;
  final VoidCallback onDeleteAllPressed;

  const ImageButtons({
    super.key,
    required this.pickImageCubit,
    required this.onDeleteAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PickImageButton(onImagesPicked: (_) {}, cubit: pickImageCubit),
        BkButton(
          onPressed: onDeleteAllPressed,
          title: "Xóa tất cả ảnh",
          backgroundColor: AppColors.delete,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
      ],
    );
  }
}
