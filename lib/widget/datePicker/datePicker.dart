import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/community_products_and_services_screen.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appcolors/app_colors.dart';

Future<DateTime?> selectDate(
    BuildContext context, DateTime selectedDate) async {
  // Get current date with no time component (e.g., 2025-04-02)
  final DateTime currentDate = DateTime.now();
  final DateTime currentDateNoTime =
      DateTime(currentDate.year, currentDate.month, currentDate.day);

  final DateTime? picked = await showDatePicker(
    context: context,
    firstDate: currentDateNoTime, // Set the first selectable date to today
    initialDate: selectedDate,
    lastDate: DateTime(2200),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: GetStoreData.getStore.read('isInvestor')
                ? AppColors.primaryInvestor
                : AppColors.primary,
            onPrimary: AppColors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.primaryInvestor
                  : AppColors.primary,
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    // If the selected date is earlier than today, return null
    final DateTime pickedDateNoTime =
        DateTime(picked.year, picked.month, picked.day);
    if (pickedDateNoTime.isBefore(currentDateNoTime)) {
      return null; // Don't allow past dates
    }
    return picked;
  }
  return null;
}

Future<DateTime?> selectOnlyDate(
    BuildContext context, DateTime selectedDate) async {
  // Get current date with no time component (e.g., 2025-04-02)
  final DateTime currentDate = DateTime.now();
  final DateTime currentDateNoTime =
      DateTime(currentDate.year, currentDate.month, currentDate.day);

  final DateTime? picked = await showDatePicker(
    context: context,
    firstDate: currentDateNoTime, // Set the first selectable date to today
    initialDate: selectedDate,
    lastDate: DateTime(2200),
    selectableDayPredicate: (DateTime day) {
      // Only allow selection of the selectedDate and ensure it's today or later
      final DateTime dayNoTime = DateTime(day.year, day.month, day.day);
      return dayNoTime.isAtSameMomentAs(selectedDate) &&
          !dayNoTime.isBefore(currentDateNoTime);
    },
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: GetStoreData.getStore.read('isInvestor')
                ? AppColors.primaryInvestor
                : AppColors.primary,
            onPrimary: AppColors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.primaryInvestor
                  : AppColors.primary,
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    // After picking a date, if it's valid, navigate to the next screen
    final DateTime pickedDateNoTime =
        DateTime(picked.year, picked.month, picked.day);
    if (!pickedDateNoTime.isBefore(currentDateNoTime)) {
      Get.to(() => const CommunityProductsAndServicesScreen());
    } else {
      HelperSnackBar.snackBar("Error", "Past date cannot be selected");
      return null;
    }
    return picked;
  }
}
