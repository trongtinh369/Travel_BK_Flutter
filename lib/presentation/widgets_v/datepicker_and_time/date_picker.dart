import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFieldWidget extends StatefulWidget {
  final DateTime? initialDateText;
  final Function(DateTime) onDateSelected;
  final Color primaryColor;

  const DatePickerFieldWidget({
    super.key,
    this.initialDateText,
    required this.onDateSelected,
    required this.primaryColor,
  });

  @override
  State<DatePickerFieldWidget> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerFieldWidget> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDateText;
  }

  @override
  Widget build(BuildContext context) {
    final dateText =
        selectedDate == null
            ? "Chọn ngày"
            : DateFormat('dd/MM/yyyy').format(selectedDate!);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final pickerDate = await showDatePicker(
              context: context,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2025),
              lastDate: DateTime(3000),
            );

            if (pickerDate != null) {
              setState(() => selectedDate = pickerDate);
              widget.onDateSelected(pickerDate);
            }
          },
          child: Container(
            width: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateText, style: const TextStyle(fontSize: 16)),
                Icon(Icons.calendar_today, color: Colors.red),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
