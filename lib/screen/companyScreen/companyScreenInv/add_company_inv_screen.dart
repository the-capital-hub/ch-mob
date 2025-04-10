import 'dart:convert';

import 'package:capitalhub_crm/controller/exploreController/explore_filter_data.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/companyController/company_inv_controller.dart';
import '../../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../../widget/textwidget/text_widget.dart';

class AddCompanyInvScreen extends StatefulWidget {
  bool isEdit = false;
  AddCompanyInvScreen({super.key, required this.isEdit});

  @override
  State<AddCompanyInvScreen> createState() => _AddCompanyInvScreenState();
}

class _AddCompanyInvScreenState extends State<AddCompanyInvScreen> {
  CompanyInvController companyInvController = Get.find();
  @override
  void initState() {
    if (widget.isEdit == false) {
      if (companyInvController.coreTeamList.isEmpty) {
        companyInvController.coreTeamList.add(CoreTeamModel(
            image: TextEditingController(text: ""),
            name: TextEditingController(text: ""),
            designaiton: TextEditingController(text: "")));
        setState(() {});
      }
    } else {
      companyInvController.fillData();
    }
    super.initState();
  }

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: "Personal Information"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      splashColor: AppColors.transparent,
                      highlightColor: AppColors.transparent,
                      onTap: () {
                        uploadBottomSheet();
                      },
                      child: Center(
                        child: widget.isEdit &&
                                companyInvController.base64 == ""
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(companyInvController.image!),
                              )
                            : companyInvController.base64 != ""
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: MemoryImage(base64Decode(
                                        companyInvController.base64)),
                                  )
                                : const CircleAvatar(
                                    radius: 60,
                                    child: Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 40)),
                      ),
                    ),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter company name",
                        hintText: "Enter Company Name",
                        lableText: "Company Name",
                        controller: companyInvController.companyNameController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter company tagline",
                        hintText: "Enter Company Tagline",
                        lableText: "Company Tagline",
                        controller:
                            companyInvController.companyTaglineController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter location",
                        hintText: "Enter Location",
                        lableText: "Location",
                        controller:
                            companyInvController.companyLocationController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter established date",
                        hintText: "Enter Established Date",
                        readonly: true,
                        lableText: "Established Date",
                        onTap: () async {
                          final selectedDate =
                              await selectDate(context, DateTime.now());

                          if (selectedDate != null) {
                            companyInvController
                                    .establishedDateController.text =
                                Helper.formatDatePost(selectedDate.toString());
                            setState(() {});
                          }
                        },
                        controller:
                            companyInvController.establishedDateController),
                    sizedTextfield,
                    DropDownWidget(
                        status: companyInvController.selectedSector ?? "Sector",
                        lable: "Sector",
                        statusList: ExploreFliterData.sectorList,
                        onChanged: (val) {
                          companyInvController.selectedSector = val!;
                          setState(() {});
                        }),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter no. of employees",
                        hintText: "Enter No. of Employees",
                        lableText: "No. of Employees",
                        textInputType: TextInputType.number,
                        controller: companyInvController.numOfEmpController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter vision",
                        hintText: "Enter Vision",
                        lableText: "Vision",
                        controller: companyInvController.visionController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter mission",
                        hintText: "Enter Mission",
                        lableText: "Mission",
                        controller: companyInvController.missionController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter key focus",
                        hintText: "Enter Key Focus",
                        lableText: "Key Focus",
                        controller: companyInvController.keyFocusController),
                    sizedTextfield,
                    DropDownWidget(
                        status: companyInvController.selectedInvestmentStage ??
                            "Investment Stage",
                        lable: "Investment Stage",
                        statusList: ExploreFliterData.investmentStageOptions,
                        onChanged: (val) {
                          companyInvController.selectedInvestmentStage = val!;
                          setState(() {});
                        }),
                    sizedTextfield,
                    DropDownWidget(
                        status: companyInvController.selectedProductStage ??
                            "Product Stage",
                        lable: "Product Stage",
                        statusList: ExploreFliterData.startupStageOptions,
                        onChanged: (val) {
                          companyInvController.selectedProductStage = val!;
                          setState(() {});
                        }),
                    sizedTextfield,
                    const TextWidget(
                        text: "Public Links",
                        textSize: 16,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 8),
                    MyCustomTextField.textField(
                      valText: "Please enter website link",
                        lableText: "Website Link",
                        hintText: "Enter Website Link",
                        controller: companyInvController.websiteUrlController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter linkedin link",
                        lableText: "Linkedin",
                        hintText: "Enter Linkedin Link",
                        controller:
                            companyInvController.linkedInLinkController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter twitter link",
                        lableText: "Twitter",
                        hintText: "Enter Twitter Link",
                        controller: companyInvController.twitterLinkController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                      valText: "Please enter instagram link",
                        lableText: "Instagram",
                        hintText: "Enter Instagram Link",
                        controller:
                            companyInvController.instagramLinkController),
                    sizedTextfield,
                    const TextWidget(
                        text: "Company Description",
                        textSize: 16,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 8),
                    MyCustomTextField.textField(
                      valText: "Please enter company description",
                        lableText: "Company Description",
                        hintText: "Enter Company Description",
                        maxLine: 6,
                        controller:
                            companyInvController.companyDescriptionController),
                    sizedTextfield,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                            text: "Core Team",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                        InkWell(
                          onTap: () {
                            companyInvController.coreTeamList.add(CoreTeamModel(
                                image: TextEditingController(text: ""),
                                name: TextEditingController(text: ""),
                                designaiton: TextEditingController(text: "")));
                            setState(() {});
                          },
                          child: const TextWidget(
                            text: "Add New +",
                            textSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryInvestor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                        height: 230,
                        child: companyInvController.coreTeamList.isEmpty
                            ? const Center(
                                child: TextWidget(
                                    text: "No Members Added", textSize: 14))
                            : ListView.separated(
                                itemCount:
                                    companyInvController.coreTeamList.length,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(width: 8);
                                },
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 230,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: Get.width / 1.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white10),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const TextWidget(
                                              text: "Add Team Member",
                                              textSize: 14,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                companyInvController
                                                    .coreTeamList
                                                    .removeAt(index);
                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: AppColors.redColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        MyCustomTextField.textField(
                                          valText: "Please enter image url",
                                            // lableText: "Image",
                                            hintText: "Enter Image Url",
                                            controller: companyInvController
                                                .coreTeamList[index].image!),
                                        sizedTextfield,
                                        MyCustomTextField.textField(
                                          valText: "Please enter name",
                                            // lableText: "Name",
                                            hintText: "Enter Name",
                                            controller: companyInvController
                                                .coreTeamList[index].name!),
                                        sizedTextfield,
                                        MyCustomTextField.textField(
                                          valText: "Please enter description",
                                            // lableText: "Designation",
                                            hintText: "Enter Designation",
                                            controller: companyInvController
                                                .coreTeamList[index]
                                                .designaiton!),
                                        sizedTextfield,
                                      ],
                                    ),
                                  );
                                },
                              )),
                    sizedTextfield,
                    sizedTextfield,
                    AppButton.primaryButton(
                        onButtonPressed: () {
                          if (formkey.currentState!.validate()) {
                            Helper.loader(context);
                            companyInvController.createCompany().then((val) {
                              setState(() {});
                            });
                          }
                        },
                        title: "Submit")
                  ],
                ),
              ),
            ),
          ),
        ));
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
                    companyInvController.base64 = value;
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
