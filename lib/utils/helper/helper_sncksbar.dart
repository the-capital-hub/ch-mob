import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../appcolors/app_colors.dart';

class HelperSnackBar {
  static SnackbarController snackBar(String title, String subtitle) {
    if (title == "Success") {
      return Get.snackbar(
        'Success',
        subtitle,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else if (title == "Error") {
      return Get.snackbar(
        'Error',
        subtitle,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.redColor,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    } else {
      return Get.snackbar(
        'Info',
        subtitle,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.cyan.shade700,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
    }
  }
}
