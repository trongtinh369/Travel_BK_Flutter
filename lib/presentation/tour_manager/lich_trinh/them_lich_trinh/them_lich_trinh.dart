import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/app/route_manager.dart';
import 'package:booking_tour_flutter/app/dialog_helper.dart';
import 'package:booking_tour_flutter/domain/tour_option.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/datepicker_and_time/date_picker.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/datepicker_and_time/time_picker.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/delete_button_widget.dart';
import 'package:booking_tour_flutter/presentation/widgets/not_icon_toggle_input_field.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/lich_trinh/them_lich_trinh/cubit/them_lich_trinh_cubit.dart';
import 'package:booking_tour_flutter/domain/requests/add_schedule_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemLichTrinhScreen extends StatefulWidget {
  const ThemLichTrinhScreen({super.key});

  @override
  State<ThemLichTrinhScreen> createState() => _ThemLichTrinhScreenState();
}

class _ThemLichTrinhScreenState extends State<ThemLichTrinhScreen> {
  final TextEditingController _controllerNguoiToiDa = TextEditingController();
  final TextEditingController _controllerGia = TextEditingController();
  final TextEditingController _controllerTienCoc = TextEditingController();

  DateTime? _openDate;
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _gatheringTime;
  final ThemLichTrinhCubit _cubit = ThemLichTrinhCubit();
  int? _selectedTourId;
  List<TourOption> _tourOptions = const [];

  @override
  void initState() {
    super.initState();
    _openDate = DateTime.now();
    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is List && _tourOptions.isEmpty) {
      setState(() {
        _tourOptions = TourOption.fromTrips(args);
      });
    }
  }

  Future<void> _handleSave() async {
    if (_openDate == null ||
        _startDate == null ||
        _endDate == null ||
        _gatheringTime == null ||
        _selectedTourId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }
    final maxSlot = int.tryParse(_controllerNguoiToiDa.text);
    final finalPrice = int.tryParse(_controllerGia.text);
    final desposit = int.tryParse(_controllerTienCoc.text) ?? 0;

    if (finalPrice == null || finalPrice <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng nhập giá hợp lệ')));
      return;
    }
    final percentDeposit = (desposit / finalPrice * 100).round();

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

    if (percentDeposit < 0 || percentDeposit > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số tiền cọc hợp lệ')),
      );
      return;
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final request = AddScheduleRequest(
      tourId: _selectedTourId!,
      startDate: _startDate!.toIso8601String(),
      endDate: _endDate!.toIso8601String(),
      openDate: _openDate!.toIso8601String(),
      maxSlot: maxSlot,
      finalPrice: finalPrice,
      gatheringTime:
          "${twoDigits(_gatheringTime!.hour)}:${twoDigits(_gatheringTime!.minute)}",
      code: "string",
      desposit: percentDeposit,
    );

    try {
      await _cubit.createSchedule(request);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tạo lịch trình thành công')),
      );
      Navigator.pushNamed(context, RouteName.scheduleTourmanager);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tạo lịch trình thất bại: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Thêm lịch trình",
            style: AppFonts.textWhite.copyWith(fontWeight: FontWeight.bold),
          ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [_buildTextField(), const SizedBox(height: 24)],
            ),
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
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
      children: [
        _buildTour(),
        _buildNgayMoVaBatDau(),
        notIconToggleInputField(
          _controllerNguoiToiDa,
          "Người tối đa",
          "Người tối đa",
          AppColors.gray,
        ),
        notIconToggleInputField(_controllerGia, "Giá", "Giá", AppColors.gray),
        notIconToggleInputField(
          _controllerTienCoc,
          "Số tiền cọc",
          "Số tiền cọc",
          AppColors.gray,
        ),
        _buildThoiGianTapHop(),
      ],
    );
  }

  Widget _buildTour() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tour",
            style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          InkWell(
            onTap: () async {
              if (_tourOptions.isEmpty) return;

              final selected = await DialogHelper.selectOne<TourOption>(
                context: context,
                title: "Chọn tour",
                items: _tourOptions,
                display: (item) => item.title,
                searchHint: "Tìm kiếm tour...",
                initial: _tourOptions.firstWhere(
                  (e) => e.id == _selectedTourId,
                  orElse:
                      () => TourOption(
                        id: 0,
                        title: "Chọn tour",
                        price: 0,
                        percentDeposit: 0,
                      ),
                ),
              );

              if (selected != null) {
                setState(() {
                  _selectedTourId = selected.id;
                  _controllerGia.text = selected.price.toString();
                  _controllerTienCoc.text =
                      ((selected.price * selected.percentDeposit) / 100)
                          .round()
                          .toString();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _tourOptions
                          .firstWhere(
                            (e) => e.id == _selectedTourId,
                            orElse:
                                () => TourOption(
                                  id: 0,
                                  title: "Chọn tour",
                                  price: 0,
                                  percentDeposit: 0,
                                ),
                          )
                          .title,
                      style: TextStyle(
                        color:
                            _selectedTourId != null
                                ? Colors.black
                                : Colors.grey[600],
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNgayMoVaBatDau() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ngày mở đăng kí",
                style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
              ),
              DatePickerFieldWidget(
                initialDateText: DateTime.now(),
                onDateSelected: (date) {
                  setState(() {
                    _openDate = date;
                  });
                },
                primaryColor: AppColors.gray,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ngày bắt đầu",
                style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
              ),
              DatePickerFieldWidget(
                initialDateText: DateTime.now(),
                onDateSelected: (date) {
                  setState(() {
                    _startDate = date;
                  });
                },
                primaryColor: AppColors.gray,
              ),
            ],
          ),
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
              "Thời gian tập hợp",
              style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
            ),
            TimePickerFieldWidget(
              onDateSelected: (time) {
                setState(() {
                  _gatheringTime = time;
                });
              },
              primaryColor: AppColors.gray,
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ngày kết thúc",
              style: AppFonts.text14.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            DatePickerFieldWidget(
              initialDateText: DateTime.now(),
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
