import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/domain/requests/update_schedule_request.dart';
import 'package:booking_tour_flutter/domain/schedule_tourmanager.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/lich_trinh/chi_tiet_lich_trinh/cubit/chi_tiet_lich_trinh_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/datepicker_and_time/date_picker.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/datepicker_and_time/time_picker.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_icon_toggle_input_field.dart';
import 'package:flutter/material.dart';

class ChiTietTrinhScreen extends StatefulWidget {
  const ChiTietTrinhScreen({super.key});

  @override
  State<ChiTietTrinhScreen> createState() => _ChiTietTrinhScreenState();
}

class _ChiTietTrinhScreenState extends State<ChiTietTrinhScreen> {
  final TextEditingController _controllerMaLich = TextEditingController();
  final TextEditingController _controllerTour = TextEditingController();
  final TextEditingController _controllerNguoiToiDa = TextEditingController();
  final TextEditingController _controllerGia = TextEditingController();
  final TextEditingController _controllerTienCoc = TextEditingController();

  DateTime? _openDate;
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _gatheringTime;
  ScheduleTourmanager? _schedule;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (_schedule == null && args is ScheduleTourmanager) {
      _schedule = args;
      _prefillFromSchedule(args);
    }
  }

  void _prefillFromSchedule(ScheduleTourmanager s) {
    _controllerMaLich.text = s.code;
    _controllerTour.text = s.tour.title;
    _controllerNguoiToiDa.text = s.maxSlot.toString();
    _controllerGia.text = s.finalPrice.toString();
    _controllerTienCoc.text =
        (s.finalPrice * s.desposit / 100).round().toString();
    _openDate = s.openDate;
    _startDate = s.startDate;
    _endDate = s.endDate;

    if (s.gatheringTime.isNotEmpty) {
      final parts = s.gatheringTime.split(":");
      if (parts.length >= 2) {
        _gatheringTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 0,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Chi tiết lịch trình"),
        backgroundColor: AppColors.button,
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20).add(
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          ),
          child: _buildTextField(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: DeleteButtonWidget(
          onDelete: _handleSave,
          text: "Lưu",
          textColor: Colors.white,
          backgroundColor: AppColors.button,
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_schedule == null) return;

    if (_openDate == null ||
        _startDate == null ||
        _endDate == null ||
        _gatheringTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    final maxSlot = int.tryParse(_controllerNguoiToiDa.text);
    final finalPrice = int.tryParse(_controllerGia.text);
    final depositAmount = int.tryParse(_controllerTienCoc.text);

    if (finalPrice == null || finalPrice <= 0 || finalPrice > 100000000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giá phải trong (0, 100.000.000]')),
      );
      return;
    }

    if (depositAmount == null ||
        depositAmount < 0 ||
        depositAmount > finalPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tiền cọc phải <= giá tour và >= 0')),
      );
      return;
    }

    final percentDeposit = ((depositAmount / finalPrice) * 100).round();

    if (maxSlot == null || maxSlot <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số người tối đa hợp lệ')),
      );
      return;
    }

    if (_startDate!.isBefore(_openDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ngày bắt đầu không được nhỏ hơn ngày mở đăng ký'),
        ),
      );
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ngày kết thúc không được nhỏ hơn ngày bắt đầu'),
        ),
      );
      return;
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final request = UpdateScheduleRequest(
      id: _schedule!.id,
      tourId: _schedule!.tourId,
      startDate: _startDate!.toIso8601String(),
      endDate: _endDate!.toIso8601String(),
      openDate: _openDate!.toIso8601String(),
      maxSlot: maxSlot,
      finalPrice: finalPrice,
      gatheringTime:
          "${twoDigits(_gatheringTime!.hour)}:${twoDigits(_gatheringTime!.minute)}",
      code: _schedule!.code,
      desposit: percentDeposit,
    );

    final cubit = ChiTietLichTrinhCubit();
    final ok = await cubit.updateSchedule(request);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Cập nhật lịch trình thành công' : 'Cập nhật thất bại',
        ),
      ),
    );

    if (ok) {
      Navigator.pushNamed(context, RouteName.scheduleTourmanager);
    }
  }

  Widget _buildTextField() {
    return Column(
      children: [
        AbsorbPointer(
          absorbing: true,
          child: notIconToggleInputField(
            _controllerMaLich,
            "Mã lịch trình",
            "Mã lịch trình",
            AppColors.gray,
            inputBackgroundColor: AppColors.backgroundDisable,
          ),
        ),

        AbsorbPointer(
          absorbing: true,
          child: notIconToggleInputField(
            _controllerTour,
            "Mã Tour",
            "Tour",
            AppColors.gray,
            inputBackgroundColor: AppColors.backgroundDisable,
          ),
        ),

        // Ngày mở and bắt đầu
        _buildNgayMoVaBatDau(),

        notIconToggleInputField(
          _controllerNguoiToiDa,
          "Người tối đa",
          "Người tối đa",
          AppColors.white,
        ),

        notIconToggleInputField(_controllerGia, "Giá", "Giá", AppColors.white),

        notIconToggleInputField(
          _controllerTienCoc,
          "Số tiền cọc",
          "Số tiền cọc",
          AppColors.white,
        ),

        //Thời gian tập hợp
        _buildThoiGianTapHop(),
      ],
    );
  }

  Widget _buildNgayMoVaBatDau() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
              "Ngày mở đăng kí",
            ),
            DatePickerFieldWidget(
              initialDateText: _openDate,
              onDateSelected: (date) {
                setState(() {
                  _openDate = date;
                });
              },
              primaryColor: Colors.grey.shade100,
            ),
          ],
        ),

        SizedBox(width: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
              "Ngày bắt đầu",
            ),
            DatePickerFieldWidget(
              initialDateText: _startDate,
              onDateSelected: (date) {
                setState(() {
                  _startDate = date;
                });
              },
              primaryColor: AppColors.gray,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThoiGianTapHop() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
              "Thời gian tập hợp",
            ),
            TimePickerFieldWidget(
              initialTimeText: _gatheringTime,
              onDateSelected: (time) {
                setState(() {
                  _gatheringTime = time;
                });
              },
              primaryColor: AppColors.gray,
            ),
          ],
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            DatePickerFieldWidget(
              initialDateText: _endDate,
              onDateSelected: (date) {
                setState(() {
                  _endDate = date;
                });
              },
              primaryColor: AppColors.gray,
            ),
          ],
        ),
      ],
    );
  }
}
