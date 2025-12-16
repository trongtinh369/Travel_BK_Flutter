import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:flutter/material.dart';

class InfoTwoRow extends StatelessWidget {
  final String title;
  final String content;

  const InfoTwoRow({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 10),
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
