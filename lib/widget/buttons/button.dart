import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../utils/getStore/get_store.dart';
import '../textwidget/text_widget.dart';

class AppButton {
  static Widget primaryButton({
    required void Function()? onButtonPressed,
    required String title,
    double? height,
    Color? bgColor,
    Color? textColor,
    double? borderRadius,
    double? width,
    double? fontSize,
  }) {
    return Container(
      width: width ?? Get.width,
      height: height ?? 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
        color: bgColor ??
            (GetStoreData.getStore.read('isInvestor')??false
                ? AppColors.primaryInvestor
                : AppColors.primary),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(4),
          shape: StadiumBorder(),
          backgroundColor: bgColor ??
              (GetStoreData.getStore.read('isInvestor')??false
                  ? AppColors.primaryInvestor
                  : AppColors.primary),
        ),
        onPressed: onButtonPressed,
        child: TextWidget(
          text: title,
          textSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
          color: textColor ?? (GetStoreData.getStore.read('isInvestor')??false
              ? AppColors.black
              : AppColors.white),
        ),
      ),
    );
  }

  static Widget outlineButton({
    required void Function()? onButtonPressed,
    required String title,
    double? height,
    Color? bgColor,
    Color? borderColor,
    double? borderRadius,
    double? fontSize,
    double? width,
  }) {
    return Container(
      width: width ?? Get.width,
      height: height ?? 45,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? AppColors.white54),
        borderRadius: BorderRadius.circular(borderRadius ?? 100),
        color: bgColor ?? AppColors.transparent,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(4),
          shape: StadiumBorder(),
          backgroundColor: bgColor ?? AppColors.transparent,
        ),
        onPressed: onButtonPressed,
        child: TextWidget(
          text: title,
          textSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
    );
  }
}
