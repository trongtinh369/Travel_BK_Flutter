import 'package:flutter/material.dart';

class DialogNoti {
  
  static Future<bool> confirm({
    required BuildContext context,
    required String title,
    required String message,
    List<String> highlightPhrases = const [],
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    Color colorHighlight = Colors.red,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => _ConfirmDialog(
            title: title,
            message: message,
            highlightPhrases: highlightPhrases,
            confirmText: confirmText,
            cancelText: cancelText,
            colorHighlight: colorHighlight
          ),
    );
    return result ?? false;
  }
}

class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final List<String> highlightPhrases;
  final String confirmText;
  final String cancelText;
  final Color colorHighlight;

  const _ConfirmDialog({
    required this.title,
    required this.message,
    this.highlightPhrases = const [],
    this.confirmText = 'Xác nhận',
    this.cancelText = 'Hủy',
    this.colorHighlight = Colors.red
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.25), width: 1),
        ),
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              child: _buildMessageWithHighlight(
                context: context,
                message: message,
                highlightPhrases: highlightPhrases,
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  _pillButton(
                    label: cancelText,
                    background: const Color(0xFFD64545),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  const SizedBox(width: 12),
                  _pillButton(
                    label: confirmText,
                    background: const Color(0xFF2EAD66),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pillButton({
    required String label,
    required Color background,
    required VoidCallback onPressed,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 96),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildMessageWithHighlight({
    required BuildContext context,
    required String message,
    required List<String> highlightPhrases,
  }) {
    if (highlightPhrases.isEmpty) {
      return Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        textAlign: TextAlign.left,
      );
    }

    final spans = <TextSpan>[];
    String remaining = message;

    TextStyle normal =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ) ??
        const TextStyle();
    TextStyle highlight = normal.copyWith(
      color: colorHighlight,
      fontWeight: FontWeight.w600,
    );

    while (remaining.isNotEmpty) {
      int nearestIndex = -1;
      String? nearestPhrase;

      for (final p in highlightPhrases) {
        final idx = remaining.indexOf(p);
        if (idx >= 0 && (nearestIndex == -1 || idx < nearestIndex)) {
          nearestIndex = idx;
          nearestPhrase = p;
        }
      }

      if (nearestIndex == -1) {
        spans.add(TextSpan(text: remaining, style: normal));
        break;
      } else {
        if (nearestIndex > 0) {
          spans.add(
            TextSpan(text: remaining.substring(0, nearestIndex), style: normal),
          );
        }
        spans.add(TextSpan(text: nearestPhrase, style: highlight));
        remaining = remaining.substring(
          nearestIndex + (nearestPhrase?.length ?? 0),
        );
      }
    }

    return RichText(text: TextSpan(children: spans));
  }
}
