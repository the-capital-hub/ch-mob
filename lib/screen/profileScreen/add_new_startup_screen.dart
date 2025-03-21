import 'dart:convert';

import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewStartupScreen extends StatefulWidget {
  bool isEdit;
  int? index;
  AddNewStartupScreen({super.key, required this.isEdit, this.index});

  @override
  State<AddNewStartupScreen> createState() => _AddNewStartupScreenState();
}

class _AddNewStartupScreenState extends State<AddNewStartupScreen> {
  ProfileController profileController = Get.find();
  @override
  void initState() {
    if (!widget.isEdit) {
      profileController.startupBase64 = null;
      profileController.startupCompanyNameController.clear();
      profileController.startupCompanyDescriptionController.clear();
      profileController.startupEquityController.clear();
    } else {
      profileController.startupCompanyNameController.text = profileController
          .profileData.user!.startupsInvested![widget.index!].name!;
      profileController.startupCompanyDescriptionController.text =
          profileController
              .profileData.user!.startupsInvested![widget.index!].name!;
      profileController.startupEquityController.text = profileController
          .profileData.user!.startupsInvested![widget.index!].name!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        appBar: HelperAppBar.appbarHelper(title: "Add New Startup", action: [
          if (widget.isEdit)
            IconButton(
                onPressed: () {
                  Helper.loader(context);
                  profileController.delMyInvestment(profileController
                      .profileData.user!.startupsInvested![widget.index!].id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.redColor,
                ))
        ]),
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedTextfield,
                InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    uploadBottomSheet();
                  },
                  child: Center(
                    child: widget.isEdit &&
                            profileController.startupBase64 == null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(profileController
                                .profileData
                                .user!
                                .startupsInvested![widget.index!]
                                .logo!),
                          )
                        : profileController.startupBase64 != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(base64Decode(
                                    profileController.startupBase64!)),
                              )
                            : const CircleAvatar(
                                radius: 60,
                                child: Icon(Icons.add_photo_alternate_outlined,
                                    size: 40)),
                  ),
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Name",
                    lableText: "Company Name",
                    controller: profileController.startupCompanyNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Description",
                    lableText: "Company Description",
                    controller:
                        profileController.startupCompanyDescriptionController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Equity",
                    lableText: "Company Equity",
                    textInputType: TextInputType.number,
                    controller: profileController.startupEquityController),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Helper.loader(context);
                profileController.addEditMyInvestment(
                    isEdit: widget.isEdit,
                    userId: widget.isEdit
                        ? profileController.profileData.user!
                            .startupsInvested![widget.index!].id
                        : null);
              },
              title: "Done"),
        ),
      ),
    );
  }

  uploadBottomSheet() {
    return Get.bottomSheet(
        Container(
          height: 250,
          padding: const EdgeInsets.all(12),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedTextfield,
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: AppColors.white,
                ),
              ),
              sizedTextfield,
              const TextWidget(
                  text: "Add picture",
                  textSize: 20,
                  fontWeight: FontWeight.w500),
              sizedTextfield,
              InkWell(
                onTap: () {
                  ImagePickerWidget imagePickerWidget = ImagePickerWidget();
                  imagePickerWidget.getImage(false).then((value) {
                    Get.back();
                    profileController.startupBase64 = value;
                    setState(() {});
                  });
                },
                child: Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.white12,
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextWidget(
                      text: "Choose from Gallery", textSize: 15),
                ),
              ),
              // sizedTextfield,
              // InkWell(
              //   onTap: () {
              //     getImage(true).then((value) {
              //       Get.back();
              //       setState(() {});
              //     });
              //   },
              //   child: Container(
              //     width: Get.width,
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              //     decoration: BoxDecoration(
              //         color: AppColors.white12,
              //         borderRadius: BorderRadius.circular(12)),
              //     child: const TextWidget(text: "Take Photo", textSize: 15),
              //   ),
              // ),
            ],
          ),
        ),
        backgroundColor: AppColors.blackCard);
  }
}
