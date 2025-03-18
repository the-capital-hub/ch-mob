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
  const AddNewStartupScreen({super.key});

  @override
  State<AddNewStartupScreen> createState() => _AddNewStartupScreenState();
}

class _AddNewStartupScreenState extends State<AddNewStartupScreen> {
  TextEditingController firstNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        appBar: HelperAppBar.appbarHelper(
            title: "Add New Startup",),
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedTextfield,
                CircleAvatar(
                                    radius: 60,
                                    // backgroundImage:
                                    //      NetworkImage(widget.isMyInvestment
                                    //         ? myStartupsController.startupData
                                    //             .myInvestments![widget.index!].logo!
                                    //         : myStartupsController.startupData
                                    //             .pastInvestments![widget.index!].logo!),
                                    //   )
                                    // : myStartupsController.base64 != null
                                    //     ? CircleAvatar(
                                    //         radius: 60,
                                    //         backgroundImage: MemoryImage(
                                    //             base64Decode(myStartupsController.base64!)),
                                    //       )
                                    //     : const CircleAvatar(
                                    //         radius: 60,
                                    //         child: Icon(Icons.add_photo_alternate_outlined,
                                    //             size: 40)),
                                  ),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Company Name",
                    lableText: "Company Name",
                    textInputType: TextInputType.number,
                    controller: firstNameController),
sizedTextfield,
                // if (widget.isMyInvestment) sizedTextfield,
                 MyCustomTextField.textField(
                    hintText: "Enter Company Description",
                    lableText: "Company Description",
                    textInputType: TextInputType.number,
                    controller: firstNameController),
sizedTextfield,
                     MyCustomTextField.textField(
                    hintText: "Enter Company Equity",
                    lableText: "Company Equity",
                    textInputType: TextInputType.number,
                    controller: firstNameController),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                // if (widget.isMyInvestment) {
                //   Helper.loader(context);
                // myStartupsController.addEditMyInvestment(
                //     userId: widget.isEdit
                //         ? myStartupsController
                //             .startupData.myInvestments![widget.index!].id
                //         : null,
                //     isEdit: widget.isEdit);
                // } else {
                //   Helper.loader(context);
                // myStartupsController.addPastInvestment(
                //     userId: widget.isEdit
                //         ? myStartupsController.startupData
                //             .pastInvestments![widget.index!].investmentId
                //         : null,
                //     isEdit: widget.isEdit);
                // }
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
                    // myStartupsController.base64 = value;
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
