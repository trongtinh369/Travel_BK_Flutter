import 'dart:io';

import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_error_fields.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_state.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/create_activity_day_field.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/create_day_of_tour_field.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/image_buttons.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/image_list.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/nullable_image.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_mul_province/select_mul_province_field.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button_cubit.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/pick_image_button/pick_image_button_state.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_textfield.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTourScreen extends StatelessWidget {
  late final AddTourCubit _addTourCubit;
  final VoidCallback onSave;
  final TextEditingController _tourNameController = TextEditingController();
  final TextEditingController _tourDescController = TextEditingController();
  final TextEditingController _tourPriceController = TextEditingController();
  final TextEditingController _tourPercentController = TextEditingController();
  final bool isAllowChangeAmountDays;
  final String title;

  AddTourScreen({
    super.key,
    this.isAllowChangeAmountDays = true,
    required this.title,
    required this.onSave,
    required AddTourCubit addTourCubit,
  }) {
    _addTourCubit = addTourCubit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AddTourCubit>.value(
        value: _addTourCubit,
        child: BlocBuilder<AddTourCubit, AddTourState>(
          builder: (context, state) {
            _tourNameController.text = state.tour.tourName;
            _tourDescController.text = state.tour.description;
            _tourPriceController.text = state.tour.price;
            _tourPercentController.text = state.tour.percent;

            return CustomScrollView(
              slivers: [
                SliverAppBar(title: Text(title)),
                SliverToBoxAdapter(
                  child: NullableImage(
                    isShowError: state.isValidated,
                    errorMessage: state.getErrorMessage(
                      AddTourErrorFields.tourImages,
                    ),
                    image: state.images.firstOrNull,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: BlocListener<
                      PickImageButtonCubit,
                      PickImageButtonState
                    >(
                      bloc: context.read<PickImageButtonCubit>(),
                      listener: (context, state) {
                        List<Either<File, String>> files =
                            state.files
                                .map<Either<File, String>>(
                                  (i) => i.fold(
                                    (file) =>
                                        left<File, String>(File(file.path)),
                                    (url) => right<File, String>(url),
                                  ),
                                )
                                .toList();
                        _addTourCubit.setImages(files);
                      },
                      child: ImageButtons(
                        pickImageCubit: context.read<PickImageButtonCubit>(),
                        onDeleteAllPressed: () {
                          context.read<PickImageButtonCubit>().clearAllImages();
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ImageList(
                      onImageDelete:
                          (i) => context
                              .read<PickImageButtonCubit>()
                              .removeImage(i),
                      images: state.images,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: BkTextfield(
                      controller: _tourNameController,
                      title: "Tên chuyến đi",
                      hint: "Nhập tên chuyến đi",
                      onChange: (value) {
                        _addTourCubit.state.tour.tourName = value;
                      },
                      isShowError: state.isValidated,
                      errorMessage: state.getErrorMessage(
                        AddTourErrorFields.tourName,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: BkTextfield(
                      controller: _tourDescController,
                      title: "Mô tả",
                      hint: "Nhập mô tả",
                      onChange: (value) {
                        _addTourCubit.state.tour.description = value;
                      },
                      isShowError: state.isValidated,
                      errorMessage: state.getErrorMessage(
                        AddTourErrorFields.tourDescription,
                      ),
                      maxLength: 10000,
                      maxLines: 10,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: BkTextfield(
                      controller: _tourPriceController,
                      title: "Giá",
                      hint: "Nhập giá tiền",
                      onChange: (value) {
                        _addTourCubit.state.tour.price = value;
                      },
                      isShowError: state.isValidated,
                      errorMessage: state.getErrorMessage(
                        AddTourErrorFields.tourPrice,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: BkTextfield(
                      controller: _tourPercentController,
                      title: "Phần trăm tiền đặt cọc",
                      hint: "Nhập phần trăm tiền đặt cọc",
                      onChange: (value) {
                        _addTourCubit.state.tour.percent = value;
                      },
                      isShowError: state.isValidated,
                      errorMessage: state.getErrorMessage(
                        AddTourErrorFields.tourPercent,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SelectMulProvinceField(
                    provinces: state.provinces,
                    onChange: (provinces) {
                      _addTourCubit.setProvinces(provinces);
                    },
                    isShowError: state.isValidated,
                    errorMessage: state.getErrorMessage(
                      AddTourErrorFields.province,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: CreateDayOfTourField(
                      isAllowChangeAmountDay: isAllowChangeAmountDays,
                      isValidated: state.isValidated,
                      getError: state.getErrorMessage,
                      dayOfTours: state.daysOfTour,
                      selectedDay: state.selectedDayOfTour,
                    ),
                  ),
                ),
                CreateActivityDayField(
                  dayOfTour: state.daysOfTour[state.selectedDayOfTour],
                  onDelete: (index) => _addTourCubit.removeActivity(index),
                  provinces: state.provinces,
                ),
                SliverToBoxAdapter(child: SizedBox(height: 50)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: BkButton(onPressed: onSave, title: "Lưu"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
