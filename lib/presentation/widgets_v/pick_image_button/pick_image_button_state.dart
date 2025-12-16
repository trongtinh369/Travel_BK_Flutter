import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class PickImageButtonState {
  final bool picking;
  final List<Either<XFile, String>> files;
  final String? error;
  final bool allowMultiple;
  final int maxImages;

  const PickImageButtonState({
    this.picking = false,
    this.files = const [],
    this.error,
    this.allowMultiple = false,
    this.maxImages = 3,
  });

  PickImageButtonState copyWith({
    bool? picking,
    List<Either<XFile, String>>? files,
    String? error,
    bool? allowMultiple,
    int? maxImages,
    bool clearFiles = false,
  }) {
    return PickImageButtonState(
      picking: picking ?? this.picking,
      files: clearFiles ? [] : (files ?? this.files),
      error: error,
      allowMultiple: allowMultiple ?? this.allowMultiple,
      maxImages: maxImages ?? this.maxImages,
    );
  }
}
