import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

Future<DateTime?> selectTime(BuildContext context, bool isMinutes) async {
  // Initialize the time picker with 0 hours and the current selected minutes (0 if isMinutes)
  TimeOfDay initialTime = isMinutes
      ? TimeOfDay(hour: 0, minute: 0) // For minutes picker (starting at 00:00)
      : TimeOfDay(hour: 9, minute: 0); // Default full time picker (starting at 09:00)

  // Show the time picker
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


  // If the user selected a time
  if (pickedTime != null) {
    // Return DateTime based on isMinutes flag
    if (isMinutes) {
      // Return a DateTime object with only minutes set (hour set to 0 for midnight)
      return DateTime(2022, 1, 1, 0, pickedTime.minute);
    } else {
      // Return a DateTime object with both hour and minute set
      return DateTime(2022, 1, 1, pickedTime.hour, pickedTime.minute);
    }
  }

  return null; // Return null if the user didn't select a time
}