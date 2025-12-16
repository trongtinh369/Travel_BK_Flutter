import 'dart:io';

import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/nullable_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class BkImage extends StatelessWidget {
  final Either<File, String>? image;
  final double? width;
  final double? height;

  const BkImage({super.key, required this.image, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (image == null) return SizedBox();
    return image!.fold(
      (file) {
        return Image.file(
          file,
          fit: BoxFit.fill,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return emptyImage(context);
          },
        );
      },
      (url) {
        return Image.network(
          url,
          fit: BoxFit.fill,
          width: width,
          height: height,
          errorBuilder: (context, error, stackTrace) {
            return emptyImage(context);
          },
        );
      },
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
