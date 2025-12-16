import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerFieldWidget extends StatefulWidget {
  final TimeOfDay? initialTimeText;
  final Function(TimeOfDay) onDateSelected;
  final Color primaryColor;

  const TimePickerFieldWidget({
    super.key,
    this.initialTimeText,
    required this.onDateSelected,
    required this.primaryColor,
  });

  @override
  State<TimePickerFieldWidget> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerFieldWidget> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTimeText;
  }

  @override
  Widget build(BuildContext context) {
    final timeText =
        selectedTime == null
            ? "Chọn giờ"
            : DateFormat('HH:mm').format(
              DateTime(0, 0, 0, selectedTime!.hour, selectedTime!.minute),
            );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final pickerTime = await showTimePicker(
              context: context,
              initialEntryMode: TimePickerEntryMode.dial,
              initialTime: TimeOfDay.now(),
            );

            if (pickerTime != null) {
              setState(() => selectedTime = pickerTime);
              widget.onDateSelected(pickerTime);
            }
          },
          child: Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(timeText, style: const TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Icon(Icons.lock_clock, color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
