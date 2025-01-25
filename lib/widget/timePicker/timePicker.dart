import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

Future<DateTime?> selectTime(BuildContext context, bool isMinutes) async {
  TimeOfDay initialTime = isMinutes
      ? const TimeOfDay(hour: 0, minute: 0)
      : const TimeOfDay(hour: 9, minute: 0);

  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.dark().copyWith(
            primaryColor: AppColors.blackCard,
            hintColor: AppColors.blackCard,
            focusColor: AppColors.white,
            buttonTheme: ButtonThemeData(
              buttonColor: AppColors.blackCard,
            ),
            timePickerTheme: TimePickerThemeData(
              dayPeriodColor: AppColors.primary,
              dayPeriodTextColor: AppColors.white,
              dialHandColor: AppColors.blackCard,
              dialTextColor: AppColors.white,
              backgroundColor: AppColors.blackCard,
              hourMinuteTextColor: AppColors.white,
              hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? AppColors.primary
                      : AppColors.white.withOpacity(0.1)),
            ),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => AppColors.white),
            ))),
        child: child!,
      );
    },
  );

  if (pickedTime != null) {
    if (isMinutes) {
      return DateTime(2022, 1, 1, 0, pickedTime.minute);
    } else {
      return DateTime(2022, 1, 1, pickedTime.hour, pickedTime.minute);
    }
  }

  return null;
}
