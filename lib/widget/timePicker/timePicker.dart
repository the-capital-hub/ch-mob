import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<DateTime?> selectTime(BuildContext context, bool isMinutes) async {
  CommunityMeetingsController communityMeetings =
      Get.put(CommunityMeetingsController());
  final currentTime = DateTime.now();

  // Set the initial time to one minute ahead if not selecting minutes
  TimeOfDay initialTime = isMinutes
      ? const TimeOfDay(hour: 0, minute: 0) // For minutes, start at 00:00
      : TimeOfDay(
          hour: currentTime.hour,
          minute:
              currentTime.minute + 1); // One minute ahead for the current time

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
              dayPeriodColor: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.primaryInvestor
                  : AppColors.primary,
              dayPeriodTextColor: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.black
                  : AppColors.white,
              dialHandColor: AppColors.blackCard,
              dialTextColor: AppColors.white,
              backgroundColor: AppColors.blackCard,
              hourMinuteTextColor: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.black
                  : AppColors.white,
              hourMinuteColor: MaterialStateColor.resolveWith(
                  (states) => states.contains(MaterialState.selected)
                      ? GetStoreData.getStore.read('isInvestor')
                          ? AppColors.primaryInvestor
                          : AppColors.primary
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
    // Create a DateTime object for the picked time
    final selectedTime = DateTime(currentTime.year, currentTime.month,
        currentTime.day, pickedTime.hour, pickedTime.minute);

    // If the selected time is before the current time, prevent selecting a past time for today
    if (selectedTime.isBefore(currentTime) &&
        communityMeetings.dateSelected.day == selectedTime.day) {
      HelperSnackBar.snackBar("Error", "Past time cannot be selected");
      return null;
    }

    // If it's a minutes-only picker, return only the minutes in a specific format
    if (isMinutes) {
      return DateTime(2022, 1, 1, 0, pickedTime.minute);
    } else {
      return DateTime(2022, 1, 1, pickedTime.hour, pickedTime.minute);
    }
  }

  return null;
}
