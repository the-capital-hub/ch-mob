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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextWidget(
                  text:
                      "You've made several changes to your $sheetDescription. Would you like to share these updates with your network?",
                  color: AppColors.grey,
                  textSize: 16,
                  maxLine: 10,
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: AppButton.primaryButton(
                            onButtonPressed: () {
                              Get.back();
                              Get.to(() => CreatePostScreen(
                                    description: postDescription,
                                  ));
                            },
                            borderRadius: 12,
                            title: "Yes, Create Post")),
                    const SizedBox(width: 12),
                    Expanded(
                        child: AppButton.outlineButton(
                            onButtonPressed: () {
                              Get.back();
                            },
                            borderRadius: 12,
                            borderColor: AppColors.whiteShade,
                            title: "No, Thanks"))
                  ],
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
