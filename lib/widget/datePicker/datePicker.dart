import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/community_products_and_services_screen.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appcolors/app_colors.dart';

Future<DateTime?> selectDate(
    BuildContext context, DateTime selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    firstDate: DateTime(1940),
    initialDate: selectedDate,
    lastDate: DateTime(2200),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: 
          ColorScheme.light(primary: GetStoreData.getStore.read('isInvestor')? AppColors.primaryInvestor:AppColors.primary,onPrimary: AppColors.black),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor:  GetStoreData.getStore.read('isInvestor')? AppColors.primaryInvestor:AppColors.primary,
              ),
          )
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    return picked;
  }
  return null;
}

Future<DateTime?> selectOnlyDate(
    BuildContext context, DateTime selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    firstDate: DateTime(1940),
    initialDate: selectedDate,
    lastDate: DateTime(2200),
    selectableDayPredicate: (DateTime day) {
      // Only allow selection of the selectedDate, other dates are locked
      return day.isAtSameMomentAs(selectedDate);
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
    Get.to(() => const CommunityProductsAndServicesScreen());
    return picked;
  }
  return null;
}