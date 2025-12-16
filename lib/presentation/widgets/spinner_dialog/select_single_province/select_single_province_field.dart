import 'package:booking_tour_flutter/app/booking_dialog.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/spinner_dialog.dart';
import 'package:flutter/material.dart';

class SelectSingleProvinceField extends StatefulWidget {
  final void Function(Province? province) onChange;
  final Province? initialProvince;
  final bool isDisable;
  final bool isShowError;
  final String? errorMessage;

  const SelectSingleProvinceField({
    super.key,
    required this.onChange,
    this.initialProvince,
    this.isDisable = false,
    this.isShowError = false,
    this.errorMessage,
  });

  @override
  State<SelectSingleProvinceField> createState() =>
      _SelectSingleProvinceFieldState();
}

class _SelectSingleProvinceFieldState extends State<SelectSingleProvinceField> {
  Province? _selectedProvince;

  @override
  void initState() {
    super.initState();
    _selectedProvince = widget.initialProvince;
  }

 Future<void> _chooseProvince() async {
  var province = await BookingDialog.selectSingleProvince(
    initProvince: _selectedProvince,
  );

  setState(() {
    _selectedProvince = province;
  });

  widget.onChange(province);
}


  @override
  Widget build(BuildContext context) {
    return SpinnerDialog(
      title: "Điểm đến",
      hint: "Chọn điểm đến",
      onTap: _chooseProvince,
      content: _selectedProvince?.name ?? "",
      isDisable: widget.isDisable,
      isShowError: widget.isShowError,
      errorMessage: widget.errorMessage,
    );
  }
}