import 'package:booking_tour_flutter/app/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:booking_tour_flutter/app/dependency_injection/theme/app_color.dart';

class TimePickerFieldWidget extends StatelessWidget {
  final TimeOfDay? initialTimeText;
  final Function(TimeOfDay) onDateSelected;
  final Color primaryColor;
  final String? title;
  final TimePickerCubit _cubit = TimePickerCubit();
  final bool isShowError;
  final String? errorMessage;

  TimePickerFieldWidget({
    super.key,
    this.initialTimeText,
    required this.onDateSelected,
    required this.primaryColor,
    this.title,
    this.isShowError = false,
    this.errorMessage,
  }) {
    _cubit.setTime(initialTimeText);
  }

  @override
  Widget build(BuildContext context) {
    final isError = isShowError && errorMessage != null;
    final borderColor = isError ? AppColors.error : AppColors.lightGrey;

    return BlocConsumer<TimePickerCubit, TimePickerState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.time == null) {
          return;
        }
        onDateSelected(state.time!);
      },
      builder: (context, state) {
        final timeText =
            state.time == null
                ? "Chọn giờ"
                : DateFormat('HH:mm').format(
                  DateTime(0, 0, 0, state.time!.hour, state.time!.minute),
                );

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: title != null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? "",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),

            Row(
              children: [
                InkWell(
                  onTap: () async {
                    await _cubit.chooseTime();
                  },
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        timeText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.access_time, color: AppColors.black, size: 30),
              ],
            ),

            Text(
              errorMessage ?? "",
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(color: AppColors.error),
            ),
          ],
        );
      },
    );
  }
}

class TimePickerState {
  final TimeOfDay? time;

  TimePickerState({this.time});

  TimePickerState copyWith({TimeOfDay? time}) {
    return TimePickerState(time: time ?? this.time);
  }
}

class TimePickerCubit extends Cubit<TimePickerState> {
  TimePickerCubit() : super(TimePickerState());

  Future<void> chooseTime() async {
    FocusManager.instance.primaryFocus?.unfocus();

    await Future.delayed(const Duration(milliseconds: 50));

    if (!AppNavigator.currentContext.mounted) {
      return;
    }

    final pickerTime = await showTimePicker(
      context: AppNavigator.currentContext,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
    );

    FocusManager.instance.primaryFocus?.unfocus();

    emit(state.copyWith(time: pickerTime));
  }

  void setTime(TimeOfDay? time) {
    emit(state.copyWith(time: time));
  }
}
