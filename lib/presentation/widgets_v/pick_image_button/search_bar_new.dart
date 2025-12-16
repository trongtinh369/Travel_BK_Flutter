import 'package:flutter/material.dart';

class SearchBarNewWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onClear;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchBarNewWidget({
    super.key,
    required this.controller,
    required this.onClear,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<SearchBarNewWidget> createState() => _SearchBarNewWidgetState();
}

class _SearchBarNewWidgetState extends State<SearchBarNewWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {}); // rebuild mỗi khi text thay đổi
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: widget.onChanged,
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                widget.onClear();
                widget.onChanged?.call('');
              },
              child: const Icon(Icons.clear, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
