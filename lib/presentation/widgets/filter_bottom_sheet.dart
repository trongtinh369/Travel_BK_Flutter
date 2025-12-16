import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/datepicker_and_time/date_picker.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_province/select_single_province_field.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final int? initialProvinceId;
  final String? initialProvinceName;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final int? initialStars;

  const FilterBottomSheet({
    super.key,
    this.initialProvinceId,
    this.initialProvinceName,
    this.initialStartDate,
    this.initialEndDate,
    this.initialStars,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Province? selectedProvince;
  DateTime? startDate;
  DateTime? endDate;
  int? selectedStars;

  @override
  void initState() {
    super.initState();
    if (widget.initialProvinceId != null &&
        widget.initialProvinceName != null) {
      selectedProvince = Province(
        id: widget.initialProvinceId!,
        name: widget.initialProvinceName!,
      );
    }
    startDate = widget.initialStartDate;
    endDate = widget.initialEndDate;
    selectedStars = widget.initialStars;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Bộ lọc tìm kiếm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, color: Colors.teal),
                  const SizedBox(width: 8),
                  const Text(
                    'Điểm đến',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SelectSingleProvinceField(
                onChange: (province) {
                  setState(() {
                    selectedProvince = province;
                  });
                },
                initialProvince: selectedProvince,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ngày bắt đầu',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DatePickerFieldWidget(
                          initialDateText: startDate,
                          onDateSelected: (date) {
                            setState(() {
                              startDate = date;
                              if (endDate != null && endDate!.isBefore(date)) {
                                endDate = null;
                              }
                            });
                          },
                          primaryColor: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ngày kết thúc',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DatePickerFieldWidget(
                          initialDateText: endDate,
                          onDateSelected: (date) {
                            setState(() {
                              endDate = date;
                            });
                          },
                          primaryColor: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.star_outline, color: Colors.amber),
                  const SizedBox(width: 8),
                  const Text(
                    'Đánh giá',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final star = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStars = selectedStars == star ? null : star;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        selectedStars != null && star <= selectedStars!
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 40,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedProvince = null;
                          startDate = null;
                          endDate = null;
                          selectedStars = null;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Xóa bộ lọc',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, {
                          'provinceId': selectedProvince?.id,
                          'provinceName': selectedProvince?.name,
                          'startDate': startDate,
                          'endDate': endDate,
                          'stars': selectedStars,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Áp dụng',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
