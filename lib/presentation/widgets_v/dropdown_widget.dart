import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final String Function(T) itemToString;
  final ValueChanged<T?> onChanged;
  final T? value;
  final String? hintText;
  final String? Function(T?)? validator;

  const DropDownWidget({
    super.key,
    required this.title,
    required this.options,
    required this.itemToString,
    required this.onChanged,
    this.value,
    this.hintText,
    this.validator,
  });

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: AppFonts.fontSize16,
              fontWeight: AppFonts.fontWeight500,
            ),
          ),
        ),
        FormField<T>(
          validator: widget.validator,
          builder: (FormFieldState<T> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          state.hasError
                              ? Colors.red
                              : AppColors.secondary.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      dropdownColor: AppColors.white,
                      value: widget.value,
                      hint: Text(
                        widget.hintText ?? 'Chọn ${widget.title.toLowerCase()}',
                      ),
                      isExpanded: true,
                      items:
                          widget.options.map((T item) {
                            return DropdownMenuItem<T>(
                              value: item,
                              child: Text(widget.itemToString(item)),
                            );
                          }).toList(),
                      onChanged: (T? value) {
                        widget.onChanged(value);
                        state.didChange(value);
                      },
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
