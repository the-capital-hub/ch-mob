import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showPostUpdateBottomSheet(
    {required String postDescription, required String sheetDescription}) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: AppColors.blackCard,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: GetStoreData.getStore.read('isInvestor')
                  ? AppColors.primaryInvestor
                  : AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.blackCard
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(Icons.sync_alt,
                      size: 25,
                      color: GetStoreData.getStore.read('isInvestor')
                          ? AppColors.primaryInvestor
                          : AppColors.primary),
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text: "Share Your Updates",
                  textSize: 18,
                  fontWeight: FontWeight.w500,
                  color: GetStoreData.getStore.read('isInvestor')
                      ? AppColors.blackCard
                      : AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
  );
}
