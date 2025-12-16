import 'package:flutter/material.dart';

class DimmableImageButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const DimmableImageButton({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  _DimmableImageButtonState createState() => _DimmableImageButtonState();
}

class _DimmableImageButtonState extends State<DimmableImageButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },

      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onTap();
      },
      
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },

      
      child: AnimatedOpacity(
        duration: const Duration(
          milliseconds: 100,
        ), 
        opacity: _isPressed ? 0.5 : 1.0,

        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(widget.imagePath, width: 40, height: 40),
        ),
      ),
    );
  }
}
