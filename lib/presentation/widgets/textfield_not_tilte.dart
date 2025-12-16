import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:flutter/material.dart';

class TextfieldNotTilte extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final VoidCallback? onTap;

  const TextfieldNotTilte({super.key, required this.label, required this.value, this.icon, this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300,
      ),
  
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text("$label:   $value", style: AppFonts.text18,overflow: TextOverflow.ellipsis,),),
        
        if(icon != null)
        GestureDetector(
          onTap: onTap,
          child: Icon(icon, size: 20,),
        )
      ],
    ),
  );
  }
}
