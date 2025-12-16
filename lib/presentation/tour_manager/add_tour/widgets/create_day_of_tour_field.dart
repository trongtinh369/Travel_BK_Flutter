import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_day_of_tour.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_error_fields.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/widgets/day_of_tour_list_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';

class CreateDayOfTourField extends StatelessWidget {
  final String? Function(String) getError;
  final bool isValidated;
  final List<CTDayOfTour> dayOfTours;
  final int selectedDay;
  final bool isAllowChangeAmountDay;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  CreateDayOfTourField({
    super.key,
    this.isAllowChangeAmountDay = true,
    required this.dayOfTours,
    required this.selectedDay,
    required this.getError,
    required this.isValidated,
  }) {
    var dayOfTour = dayOfTours[selectedDay];
    _titleController.text = dayOfTour.title;
    _descriptionController.text = dayOfTour.description;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 5, color: AppColors.backgroundAppBarTheme),
        ),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: [
          //title
          Row(
            children: [
              Text(
                "Lịch trình theo ngày",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Spacer(),
              Visibility(
                visible: isAllowChangeAmountDay,
                child: BkButton(
                  onPressed: () {
                    context.read<AddTourCubit>().addDayOfTour();
                  },
                  title: "Thêm ngày",
                ),
              ),
              Visibility(
                visible: isAllowChangeAmountDay && dayOfTours.length > 1,
                child: BkButton(
                  onPressed: () {
                    context.read<AddTourCubit>().removeDayOfTour();
                  },
                  title: "Xóa ngày",
                  backgroundColor: AppColors.delete,
                ),
              ),
            ],
          ),

          //buttons day
          DayOfTourListField(
            dayOfTours: dayOfTours,
            selectedDay: selectedDay,
            onChange: context.read<AddTourCubit>().changeSelectedDay,
          ),
          BkTextfield(
            controller: _titleController,
            title: "Tiêu đề",
            hint: "Nhập tiêu đề của ngày",
            onChange: (value) => dayOfTours[selectedDay].title = value,
            isShowError: isValidated,
            errorMessage: getError(
              sprintf(AddTourErrorFields.dayOfTourTitle, [selectedDay]),
            ),
          ),
          SizedBox(height: 10),
          BkTextfield(
            controller: _descriptionController,
            title: "Mô tả",
            hint: "Nhập mô tả của ngày",
            onChange: (value) => dayOfTours[selectedDay].description = value,
            isShowError: isValidated,
            errorMessage: getError(
              sprintf(AddTourErrorFields.dayOfTourDescription, [selectedDay]),
            ),
            maxLines: 10,
            maxLength: 10000,
          ),

          //more day activity
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                "Hoạt động trong ngày",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Spacer(),
              BkButton(
                onPressed: () => context.read<AddTourCubit>().addActivity(),
                title: "Thêm hoạt động",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
