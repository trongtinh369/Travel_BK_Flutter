import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class DialogHoatDong extends StatefulWidget {
  final String title;
  final String? cancelText;
  final String? confirmText;
  final ValueChanged<String>? onConfirm;
  final VoidCallback? onCancel;
  final Color? confirmButtonColor;
  final bool showCancelButton;
  final bool showInput;
  final String? hintText;
  final String? initialValue;

  const DialogHoatDong({
    super.key,
    required this.title,
    this.cancelText,
    this.confirmText,
    this.onCancel,
    this.onConfirm,
    this.confirmButtonColor,
    this.showCancelButton = true,
    this.showInput = false,
    this.hintText,
    this.initialValue,
  });

  @override
  State<DialogHoatDong> createState() => _DialogHoatDongState();

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    ValueChanged<String>? onConfirm,
    Color? confirmButtonColor,
    IconData? icon,
    Color? iconColor,
    bool showCancelButton = true,
    bool showInput = false,
    String? hintText,
    String? initialValue,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => DialogHoatDong(
            title: title,
            cancelText: cancelText,
            confirmText: confirmText,
            onCancel: onCancel,
            onConfirm: onConfirm,
            confirmButtonColor: confirmButtonColor,
            showCancelButton: showCancelButton,
            showInput: showInput,
            hintText: hintText,
            initialValue: initialValue,
          ),
    );
  }
}

class _DialogHoatDongState extends State<DialogHoatDong> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.showInput) ...[
              const SizedBox(height: 12),
              TextField(
                controller: _controller,  
                maxLength: 255,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Hoạt động',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (widget.showCancelButton)
            TextButton(
              onPressed:
                  widget.onCancel ?? () => Navigator.of(context).pop(false),
              child: Text(
                widget.cancelText ?? 'Hủy',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              final text = _controller.text.trim();
              widget.onConfirm?.call(text);
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.button,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.confirmText ?? 'Xác nhận',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
