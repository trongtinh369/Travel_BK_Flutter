import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'pick_image_button_cubit.dart';
import 'pick_image_button_state.dart';

class PickImageButton extends StatelessWidget {
  final Function(List<Either<XFile, String>>) onImagesPicked;
  final String text;
  final bool allowMultiple;
  final int maxImages;
  final PickImageButtonCubit? cubit;

  const PickImageButton({
    super.key,
    required this.onImagesPicked,
    this.text = 'Chọn Ảnh',
    this.allowMultiple = false,
    this.maxImages = 3,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              cubit ??
              PickImageButtonCubit(
                allowMultiple: allowMultiple,
                maxImages: maxImages,
              ),
      child: BlocConsumer<PickImageButtonCubit, PickImageButtonState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error!)));
          }
          if (!state.picking && state.files.isNotEmpty) {
            onImagesPicked(state.files);
          }
        },
        builder: (context, state) {
          final cubit = context.read<PickImageButtonCubit>();
          return ElevatedButton(
            onPressed: () => cubit.pickImage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF23A892),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }
}
