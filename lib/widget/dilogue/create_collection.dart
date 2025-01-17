import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/appcolors/app_colors.dart';
import '../textWidget/text_widget.dart';

Future<bool> createCollectionPopup(
    BuildContext context, int mainIndex, int page) async {
  HomeController homeController = Get.put(HomeController());
  TextEditingController collectionController = TextEditingController();
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: AppColors.blackCard,
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.primary,
                      border: Border.all(color: AppColors.white, width: 0)),
                  child: Icon(
                    Icons.bookmark_add_outlined,
                    size: 40,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextWidget(
                  text: "New Collection",
                  textSize: 20,
                  color: AppColors.white,
                  maxLine: 2,
                  fontWeight: FontWeight.w600,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: MyCustomTextField.textField(
                      borderClr: AppColors.white38,
                      hintText: "Enter Collection Name",
                      controller: collectionController),
                ),
                SizedBox(height: 8),
                Divider(
                  color: AppColors.grey3Color,
                  height: 0,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "Cancel".toUpperCase(),
                              color: Colors.white54,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 0.5,
                      color: AppColors.grey3Color,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (collectionController.text.isNotEmpty) {
                            homeController
                                .savePost(context,
                                    postID: homeController
                                        .postList[mainIndex].postId!,
                                    colelctionName: collectionController.text)
                                .then((val) {
                              if (val) {
                                homeController.getUserCollection();
                                homeController
                                    .getPublicPost(page, false)
                                    .then((val) {
                                  Get.back();
                                  Get.back();
                                  Get.back();
                                });
                              }
                            });
                          }
                        },
                        child: SizedBox(
                            height: 45,
                            child: Center(
                              child: TextWidget(
                                  text: "Done".toUpperCase(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  textSize: 14),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
}
