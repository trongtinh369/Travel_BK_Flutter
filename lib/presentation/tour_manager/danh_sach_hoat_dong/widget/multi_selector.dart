import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:flutter/material.dart';

class MultiSelector<T> extends StatelessWidget {
  final List<T> selectedItems;
  final String hintText;
  final Function(List<T>) onItemsChanged;
  final bool enabled;
  final String Function(T) itemDisplayText;
  final Widget Function(BuildContext, List<T>, Function(List<T>)) dialogBuilder;

  const MultiSelector({
    super.key,
    required this.selectedItems,
    required this.onItemsChanged,
    required this.itemDisplayText,
    required this.dialogBuilder,
    this.hintText = 'Chọn mục',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? () => _showSelectionDialog(context) : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
          color:
              enabled ? AppColors.white : AppColors.secondary.withOpacity(0.1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _buildContent()),
                Icon(
                  Icons.arrow_drop_down,
                  color:
                      enabled
                          ? AppColors.secondary
                          : AppColors.secondary.withOpacity(0.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (selectedItems.isEmpty) {
      return Text(
        hintText,
        style: TextStyle(
          color: AppColors.secondary.withOpacity(0.7),
          fontSize: AppFonts.fontSize16,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children:
          selectedItems.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.black),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      itemDisplayText(item),
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: AppFonts.fontSize14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  void _showSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => dialogBuilder(context, selectedItems, onItemsChanged),
    );
  }
}
