import 'dart:convert';
import 'package:capitalhub_crm/controller/loginController/login_controller.dart';
import 'package:capitalhub_crm/model/mystartupModel/my_startup_model.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../../../widget/text_field/text_field.dart';
import '../../../../widget/textwidget/text_widget.dart';

class SignupAddStartupScreen extends StatefulWidget {
  bool isEdit;
  int? index;
  SignupAddStartupScreen({required this.isEdit, this.index, super.key});

  @override
  State<SignupAddStartupScreen> createState() => _SignupAddStartupScreenState();
}

class _SignupAddStartupScreenState extends State<SignupAddStartupScreen> {
  LoginController loginController = Get.find();
  @override
  void initState() {
    if (!widget.isEdit) {
      loginController.myInvbase64 = null;
      loginController.myinvcompanyNameController.clear();
      loginController.myInvcompanyDescriptionController.clear();
      loginController.myInvequityController.clear();
    } else {
      loginController.myinvcompanyNameController.text =
          loginController.myInvestments[widget.index!].name!;
      loginController.myInvcompanyDescriptionController.text =
          loginController.myInvestments[widget.index!].description!;
      loginController.myInvequityController.text =
          loginController.myInvestments[widget.index!].investedEquity!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "My Investment"),
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
                    child: widget.isEdit
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(base64Decode(
                                loginController
                                    .myInvestments[widget.index!].logo!)),
                          )
                        : loginController.myInvbase64 != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(
                                    base64Decode(loginController.myInvbase64!)),
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
                    controller: loginController.myinvcompanyNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Description",
                    lableText: "Company Description",
                    maxLine: 3,
                    controller:
                        loginController.myInvcompanyDescriptionController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Equity",
                    lableText: "Company Equity",
                    textInputType: TextInputType.number,
                    controller: loginController.myInvequityController),
                sizedTextfield,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                loginController.myInvestments.add(MyInvestment(
                    description:
                        loginController.myInvcompanyDescriptionController.text,
                    investedEquity: loginController.myInvequityController.text,
                    logo: loginController.myInvbase64,
                    name: loginController.myinvcompanyNameController.text));
                Get.back();
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
                    loginController.myInvbase64 = value;
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
