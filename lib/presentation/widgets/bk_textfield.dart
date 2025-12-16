import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class BkTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final Color? fillColor;
  final String hint;
  final ValueChanged<String>? onChange;
  final bool isShowError;
  final String? errorMessage;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool isEnable;
  final bool isTrimOnChange;

  const BkTextfield({
    super.key,
    required this.controller,
    this.title,
    this.fillColor,
    required this.hint,
    this.onChange,
    this.isShowError = false,
    this.errorMessage,
    this.maxLength = 255,
    this.minLines = 1,
    this.maxLines = 1,
    this.isEnable = true,
    this.isTrimOnChange = true,
  });

  @override
  Widget build(BuildContext context) {
    var isError = isShowError && errorMessage != null;
    Color? borderColor = isError ? AppColors.error : null;

    var inputDecorationTheme = Theme.of(context).inputDecorationTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title ?? "", style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 4.0),
            ],
          ),
        ),

        TextField(
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          controller: controller,
          enabled: isEnable,
          decoration: const InputDecoration()
              .applyDefaults(
                Theme.of(context).inputDecorationTheme.copyWith(
                  border: inputDecorationTheme.border!.copyWith(
                    borderSide: inputDecorationTheme.border!.borderSide
                        .copyWith(color: borderColor),
                  ),
                  focusedBorder: inputDecorationTheme.focusedBorder!.copyWith(
                    borderSide: inputDecorationTheme.focusedBorder!.borderSide
                        .copyWith(color: borderColor),
                  ),
                  enabledBorder: inputDecorationTheme.enabledBorder!.copyWith(
                    borderSide: inputDecorationTheme.enabledBorder!.borderSide
                        .copyWith(color: borderColor),
                  ),
                ),
              )
              .copyWith(hintText: hint, fillColor: fillColor),
          onChanged:
              (value) => onChange?.call(isTrimOnChange ? value.trim() : value),
          onTapOutside: (_) {
            debugPrint("on tap outside");
            controller.text = controller.text.trim();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onEditingComplete: () {
            debugPrint("editing complete");
            controller.text = controller.text.trim();
          },
          buildCounter: (
            BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
            return null; // Hide the counter
          },
        ),

        Visibility(
          visible: isError,
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
}
