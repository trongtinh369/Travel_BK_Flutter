import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';
import 'package:booking_tour_flutter/domain/create_tour/CT_day_of_tour.dart';
import 'package:booking_tour_flutter/domain/province.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_cubit.dart';
import 'package:booking_tour_flutter/presentation/tour_manager/add_tour/cubit/add_tour_error_fields.dart';
import 'package:booking_tour_flutter/presentation/widgets_v/datepicker_and_time/time_picker/time_picker.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_activity/select_single_activity_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_location_activity/select_single_location_activity_field.dart';
import 'package:booking_tour_flutter/presentation/widgets/spinner_dialog/select_single_place/select_single_place_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';

class CreateActivityDayField extends StatelessWidget {
  final List<Province> provinces;
  final CTDayOfTour dayOfTour;
  final ValueChanged<int> onDelete;

  const CreateActivityDayField({
    super.key,
    required this.dayOfTour,
    required this.onDelete,
    required this.provinces,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: dayOfTour.dayActivities.length,
      itemBuilder: (context, i) {
        var thisActivity = dayOfTour.dayActivities[i];
        var provinceIds = provinces.map((i) => i.id).toList();
        var addTourState = context.read<AddTourCubit>().state;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: AppColors.backgroundAppBarTheme,
                  width: 5,
                ),
              ),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Hoạt động ${i + 1}",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Spacer(),
                    Visibility(
                      visible: dayOfTour.dayActivities.length != 1,
                      child: GestureDetector(
                        onTap: () => onDelete(i),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.delete,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                TimePickerFieldWidget(
                  key: ValueKey(dayOfTour),
                  onDateSelected: (time) {
                    thisActivity.time = time;
                  },
                  primaryColor: AppColors.lightGrey,
                  title: "Giờ bắt đầu",
                  initialTimeText: thisActivity.time,
                  isShowError: addTourState.isValidated,
                  errorMessage: addTourState.getErrorMessage(
                    sprintf(AddTourErrorFields.dayActivityTime, [
                      addTourState.selectedDayOfTour,
                      i,
                    ]),
                  ),
                ),
                SelectSinglePlaceField(
                  padding: 0,
                  onChange: (place) {
                    thisActivity.place = place;
                    context.read<AddTourCubit>().correctDayActivity(
                      thisActivity,
                    );
                  },
                  place: thisActivity.place,
                  provinceIds: provinceIds,
                  isDisable: provinceIds.isEmpty,
                  isShowError: addTourState.isValidated,
                  errorMessage: addTourState.getErrorMessage(
                    sprintf(AddTourErrorFields.dayActivityPlace, [
                      addTourState.selectedDayOfTour,
                      i,
                    ]),
                  ),
                ),
                SelectSingleLocationActivityField(
                  padding: 0,
                  onChange: (locationActivity) {
                    thisActivity.locationActivity = locationActivity;
                    context.read<AddTourCubit>().correctDayActivity(
                      thisActivity,
                    );
                  },
                  locationActivity: thisActivity.locationActivity,
                  placeId: thisActivity.place?.id,
                  isDisable: thisActivity.place == null,
                  isShowError: addTourState.isValidated,
                  errorMessage: addTourState.getErrorMessage(
                    sprintf(AddTourErrorFields.dayActivityLocationActivity, [
                      addTourState.selectedDayOfTour,
                      i,
                    ]),
                  ),
                ),
                SelectSingleActivityField(
                  padding: 0,
                  onChange: (activity) {
                    thisActivity.activity = activity;
                    context.read<AddTourCubit>().correctDayActivity(
                      thisActivity,
                    );
                  },
                  activity: thisActivity.activity,
                  locationActivityId: thisActivity.locationActivity?.id,
                  isDisable: thisActivity.locationActivity == null,
                  isShowError: addTourState.isValidated,
                  errorMessage: addTourState.getErrorMessage(
                    sprintf(AddTourErrorFields.dayActivityActivity, [
                      addTourState.selectedDayOfTour,
                      i,
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
