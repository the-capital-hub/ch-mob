import 'package:flutter/material.dart';
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
          colorScheme: ColorScheme.light(primary: AppColors.primary),
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
