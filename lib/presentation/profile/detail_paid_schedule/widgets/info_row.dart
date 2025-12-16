import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final Widget label;
  final Widget content;

  const InfoRow({super.key, required this.label, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [label, Spacer(), content],
      ),
    );
  }
}
