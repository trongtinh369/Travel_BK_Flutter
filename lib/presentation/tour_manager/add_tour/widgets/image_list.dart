import 'dart:io';

import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/bk_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';

class ImageList extends StatelessWidget {
  final List<Either<File, String>> images;
  final Function(int i) onImageDelete;

  const ImageList({
    super.key,
    required this.images,
    required this.onImageDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Quản lý ảnh (${images.length}/5)"),
        Visibility(visible: images.isEmpty, child: SizedBox(height: 20)),
        Visibility(visible: images.isNotEmpty, child: SizedBox(height: 10)),
        Visibility(
          visible: images.isNotEmpty,
          child: SizedBox(
            height: 90,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      BkImage(image: images[i], width: 100, height: 80),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () => onImageDelete(i),
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/close.png",
                              width: 10,
                              height: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: images.length,
            ),
          ),
        ),
      ],
    );
  }
}
