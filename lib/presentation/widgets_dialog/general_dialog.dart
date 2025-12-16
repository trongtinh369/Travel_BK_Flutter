import 'package:flutter/material.dart';

class GeneralDialog extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget footer;

  const GeneralDialog({
    super.key,
    required this.title,
    required this.body,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.25), width: 1),
        ),
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Divider(height: 1),

            //body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: body,
            ),
            const Divider(height: 1),

            //footer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: footer,
            ),
          ],
        ),
      ),
    );
  }
}
