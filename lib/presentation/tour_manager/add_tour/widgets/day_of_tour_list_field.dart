import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_day_of_tour.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_error_fields.dart';
import 'package:booking_tour_flutter/presentation/widgets/bk_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';

class DayOfTourListField extends StatelessWidget {
  final List<CTDayOfTour> dayOfTours;
  final int selectedDay;
  final ValueChanged<int>? onChange;

  const DayOfTourListField({
    super.key,
    required this.dayOfTours,
    required this.selectedDay,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var addTourState = context.read<AddTourCubit>().state;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dayOfTours.length,
        itemBuilder: (context, id) {
          if (id == selectedDay) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BkButton(
                onPressed: () {
                  onChange?.call(id);
                },
                title: "Ngày ${id + 1}",
                isShowError: addTourState.isValidated,
                errorMessage: addTourState.getErrorMessage(
                  sprintf(AddTourErrorFields.dayOfTour, [id]),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BkButton(
              onPressed: () {
                onChange?.call(id);
              },
              title: "Ngày ${id + 1}",
              backgroundColor: AppColors.white,
              textColor: AppColors.black,
              isShowError: addTourState.isValidated,
              errorMessage: addTourState.getErrorMessage(
                sprintf(AddTourErrorFields.dayOfTour, [id]),
              ),
            ),
          );
        },
      ),
    );
  }
}
