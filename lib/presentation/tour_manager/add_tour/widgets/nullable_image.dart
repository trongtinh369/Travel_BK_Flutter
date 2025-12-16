import 'dart:io';

import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/bk_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class NullableImage extends StatelessWidget {
  final bool isShowError;
  final String? errorMessage;
  final Either<File, String>? image;
  const NullableImage({super.key, this.isShowError = false, this.errorMessage, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: 250,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(children: [
              emptyImage(context),
              BkImage(image: image, width: double.infinity, height: double.infinity,),
              ]),
          ),
        ),

        Visibility(
          visible: isShowError && errorMessage != null,
          child: Text(
            errorMessage ?? "",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(color: AppColors.error),
          ),
        ),
      ],
    );
  }

  Widget emptyImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text("Empty", style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
