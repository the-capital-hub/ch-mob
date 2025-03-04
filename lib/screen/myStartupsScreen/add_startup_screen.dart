import 'dart:convert';

import 'package:capitalhub_crm/controller/myStartupsController/my_startups_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../widget/text_field/text_field.dart';
import '../../widget/textwidget/text_widget.dart';

class AddStartupScreen extends StatefulWidget {
  bool isMyInvestment;
  bool isEdit;
  AddStartupScreen(
      {required this.isMyInvestment, required this.isEdit, super.key});

  @override
  State<AddStartupScreen> createState() => _AddStartupScreenState();
}

class _AddStartupScreenState extends State<AddStartupScreen> {
  MyStartupsController myStartupsController = Get.find();
  @override
  void initState() {
    if (!widget.isEdit) {
      myStartupsController.companyNameController.clear();
      myStartupsController.companyDescriptionController.clear();
      myStartupsController.equityController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: widget.isMyInvestment ? "My Investment" : "Past Investment",
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  onTap: () {
                    uploadBottomSheet();
                  },
                  child: Center(
                    child:
                        //  widget.isEdit && companyController.base64 == ""
                        //     ? CircleAvatar(
                        //         radius: 60,
                        //         backgroundImage:
                        //             NetworkImage(companyController.image!),
                        //       )
                        // :
                        myStartupsController.base64 != ""
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(
                                    base64Decode(myStartupsController.base64)),
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
                    controller: myStartupsController.companyNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Description",
                    lableText: "Company Description",
                    controller:
                        myStartupsController.companyDescriptionController),
                sizedTextfield,
                if (widget.isMyInvestment)
                  MyCustomTextField.textField(
                      hintText: "Enter Company Equity",
                      lableText: "Company Equity",
                      textInputType: TextInputType.number,
                      controller: myStartupsController.equityController),
                if (widget.isMyInvestment) sizedTextfield,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(onButtonPressed: () {}, title: "Done"),
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
                    myStartupsController.base64 = value;
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
