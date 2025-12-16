import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/app/dependency_injection/theme/app_font.dart';
import 'package:booking_tour_flutter/domain/activity.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/danh_sach_hoat_dong/cubit/them_hoat_dong_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/danh_sach_hoat_dong/cubit/them_hoat_dong_state.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/danh_sach_hoat_dong/widget/multi_selector.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/danh_sach_hoat_dong/widget/selection_dialog.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/text_input.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemDiaDiemHoatDongScreen extends StatefulWidget {
  const ThemDiaDiemHoatDongScreen({super.key});

  @override
  State<ThemDiaDiemHoatDongScreen> createState() =>
      _ThemDiaDiemHoatDongScreenState();
}

class _ThemDiaDiemHoatDongScreenState extends State<ThemDiaDiemHoatDongScreen> {
  final TextEditingController _tenDiaDiemController = TextEditingController();
  final TextEditingController _tinhThanhController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final int placeId;
  bool _isInitialized = false;
  List<Activity> _selectedActivities = [];
  late final ThemHoatDongCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ThemHoatDongCubit();
    _cubit.loadActivities();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      placeId = ModalRoute.of(context)!.settings.arguments as int;
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _tenDiaDiemController.dispose();
    _tinhThanhController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<ThemHoatDongCubit, ThemHoatDongState>(
        listener: (context, state) {
          if (state.status == ThemHoatDongStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Thêm địa điểm hoạt động thành công'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          }
        },
        child: BlocBuilder<ThemHoatDongCubit, ThemHoatDongState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Thêm Địa Điểm Hoạt Động',
                  style: TextStyle(color: AppColors.white),
                ),
                backgroundColor: AppColors.button,
                centerTitle: true,
              ),
              backgroundColor: AppColors.white,
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextInput(
                              controller: _tenDiaDiemController,
                              hintText: 'Nhập tên địa điểm',
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Vui lòng nhập tên địa điểm';
                                }
                                return null;
                              },
                              labelText: 'Tên địa điểm hoạt động',
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Danh sách hoạt động',
                              style: TextStyle(
                                fontSize: AppFonts.fontSize16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            MultiSelector<Activity>(
                              selectedItems: _selectedActivities,
                              onItemsChanged: (activities) {
                                setState(() {
                                  _selectedActivities = activities;
                                });
                              },
                              itemDisplayText: (activity) => activity.action,
                              dialogBuilder: (
                                context,
                                selectedItems,
                                onItemsChanged,
                              ) {
                                return BlocProvider.value(
                                  value: _cubit,
                                  child: SelectionDialog<Activity>(
                                    allItems: state.activities,
                                    selectedItems: selectedItems,
                                    onItemsChanged: onItemsChanged,
                                    itemDisplayText:
                                        (activity) => activity.action,
                                    title: 'Chọn hoạt động',
                                    searchHint: 'Tìm kiếm hoạt động...',
                                  ),
                                );
                              },
                              hintText: 'Chọn các hoạt động',
                              enabled:
                                  state.status != ThemHoatDongStatus.loading,
                            ),
                          ],
                        ),

                        Center(
                          child: BkButton(
                            onPressed: () {
                              if (state.status ==
                                  ThemHoatDongStatus.loadingAdd) {
                                return;
                              }
                              _handleAdd();
                            },
                            title: 'Thêm',
                            backgroundColor: AppColors.button,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            borderRadius: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleAdd() {
    if (_formKey.currentState!.validate()) {
      if (_selectedActivities.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vui lòng chọn ít nhất một hoạt động'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _cubit.themHoatDong(
        _tenDiaDiemController.text.trim(),
        placeId,
        _selectedActivities,
      );
    }
  }
}
