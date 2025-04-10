import 'dart:convert';

import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/controller/exploreController/explore_filter_data.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../widget/textwidget/text_widget.dart';
import 'add_core_team_screen.dart';

class AddCompanyScreen extends StatefulWidget {
  bool isEdit = false;
  AddCompanyScreen({super.key, required this.isEdit});

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  CompanyController companyController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isEdit == false) {
        companyController.clearData();
      } else {
        companyController.fillData().then((v) {
          setState(() {});
        });
        companyController.getTeamMember();
      }
    });
    super.initState();
  }

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
                        child: widget.isEdit && companyController.base64 == ""
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(companyController.image!),
                              )
                            : companyController.base64 != ""
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: MemoryImage(
                                        base64Decode(companyController.base64)),
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
                        controller: companyController.companyNameController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter company tagline",
                        hintText: "Enter Company Tagline",
                        lableText: "Company Tagline",
                        controller: companyController.companyTaglineController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter location",
                        hintText: "Enter Location",
                        lableText: "Location",
                        controller:
                            companyController.companyLocationController),
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
                            companyController.establishedDateController.text =
                                Helper.formatDatePost(selectedDate.toString());
                            setState(() {});
                          }
                        },
                        controller:
                            companyController.establishedDateController),
                    sizedTextfield,
                    DropDownWidget(
                        status: companyController.selectedSector ?? "Sector",
                        lable: "Sector",
                        statusList: ExploreFliterData.sectorList,
                        onChanged: (val) {
                          companyController.selectedSector = val!;
                          setState(() {});
                        }),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter no. of employees",
                        hintText: "Enter No. of Employees",
                        lableText: "No. of Employees",
                        textInputType: TextInputType.number,
                        controller: companyController.numOfEmpController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter vision",
                        hintText: "Enter Vision",
                        lableText: "Vision",
                        controller: companyController.visionController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter mission",
                        hintText: "Enter Mission",
                        lableText: "Mission",
                        controller: companyController.missionController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter key focus",
                        hintText: "Enter Key Focus",
                        lableText: "Key Focus",
                        controller: companyController.keyFocusController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter TAM",
                        lableText: "TAM",
                        hintText: "Enter TAM",
                        textInputType: TextInputType.number,
                        controller: companyController.tamController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter SAM",
                        lableText: "SAM",
                        hintText: "Enter SAM",
                        textInputType: TextInputType.number,
                        controller: companyController.samController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter SOM",
                        lableText: "SOM",
                        hintText: "Enter SOM",
                        textInputType: TextInputType.number,
                        controller: companyController.somController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter last funding",
                        hintText: "Enter Last funding",
                        lableText: "Last funding",
                        onChange: (val) {},
                        readonly: true,
                        onTap: () async {
                          final selectedDate =
                              await selectDate(context, DateTime.now());

                          if (selectedDate != null) {
                            companyController.lastFundingDateController.text =
                                Helper.formatDatePost(selectedDate.toString());
                            setState(() {});
                          }
                        },
                        controller:
                            companyController.lastFundingDateController),
                    sizedTextfield,
                    DropDownWidget(
                        status: companyController.selectedInvestmentStage ??
                            "Investment Stage",
                        lable: "Investment Stage",
                        statusList: ExploreFliterData.investmentStageOptions,
                        onChanged: (val) {
                          companyController.selectedInvestmentStage = val!;
                          setState(() {});
                        }),
                    sizedTextfield,
                    DropDownWidget(
                        status: companyController.selectedProductStage ??
                            "Product Stage",
                        lable: "Product Stage",
                        statusList: ExploreFliterData.startupStageOptions,
                        onChanged: (val) {
                          companyController.selectedProductStage = val!;
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
                        controller: companyController.websiteUrlController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter linked link",
                        lableText: "Linkedin",
                        hintText: "Enter Linkedin Link",
                        controller: companyController.linkedInLinkController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter twitter link",
                        lableText: "Twitter",
                        hintText: "Enter Twitter Link",
                        controller: companyController.twitterLinkController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter instagram link",
                        lableText: "Instagram",
                        hintText: "Enter Instagram Link",
                        controller: companyController.instagramLinkController),
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
                            companyController.companyDescriptionController),
                    if (widget.isEdit) sizedTextfield,
                    if (widget.isEdit)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                              text: "Core Team",
                              textSize: 16,
                              fontWeight: FontWeight.w500),
                          InkWell(
                            onTap: () {
                              Get.to(const AddCoreTeamScreen());
                            },
                            child: const TextWidget(
                              text: "Add New +",
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                    if (widget.isEdit) const SizedBox(height: 8),
                    if (widget.isEdit)
                      Obx(
                        () => SizedBox(
                            height: 200,
                            child: companyController.isTeamLoading.value
                                ? Helper.pageLoading()
                                : companyController.teamMember.isEmpty
                                    ? const Center(
                                        child: TextWidget(
                                            text: "No Members Added",
                                            textSize: 14))
                                    : ListView.separated(
                                        itemCount:
                                            companyController.teamMember.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(width: 8);
                                        },
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            height: 200,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: Get.width / 2,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.white10),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Helper.loader(context);
                                                        companyController
                                                            .removeTeamMember(
                                                                userId: companyController
                                                                    .teamMember[
                                                                        index]
                                                                    .userId!)
                                                            .then((v) {
                                                          companyController
                                                              .teamMember
                                                              .removeAt(index);
                                                          setState(() {});
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      companyController
                                                          .teamMember[index]
                                                          .image!),
                                                  radius: 40,
                                                ),
                                                sizedTextfield,
                                                TextWidget(
                                                  text: companyController
                                                      .teamMember[index].name!,
                                                  textSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  maxLine: 2,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                TextWidget(
                                                  text: companyController
                                                      .teamMember[index]
                                                      .designation!,
                                                  textSize: 14,
                                                  maxLine: 2,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                      ),
                    sizedTextfield,
                    const TextWidget(
                        text: "Previous Funding Round",
                        textSize: 16,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 8),
                    MyCustomTextField.textField(
                        valText: "Please enter total investment",
                        lableText: "Total Investment",
                        textInputType: TextInputType.number,
                        hintText: "Enter Total Investment",
                        controller:
                            companyController.totalInvestmentController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "please enter no.of investors",
                        lableText: "No.of Investers",
                        hintText: "Enter No.of Investers",
                        textInputType: TextInputType.number,
                        controller: companyController.noOfInvestorController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter valuation",
                        lableText: "Valuation",
                        hintText: "Enter Valuation",
                        textInputType: TextInputType.number,
                        controller: companyController.valuationController),
                    sizedTextfield,
                    const TextWidget(
                        text: "Current Funding Round",
                        textSize: 16,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 8),
                    MyCustomTextField.textField(
                        valText: "Please enter fund ask",
                        lableText: "Fund Ask",
                        textInputType: TextInputType.number,
                        hintText: "Enter Fund Ask",
                        controller: companyController.fundAskController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter valuation",
                        lableText: "Valuation",
                        textInputType: TextInputType.number,
                        hintText: "Enter Valuation",
                        controller:
                            companyController.currentValuationController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter funds raised",
                        lableText: "Funds Raised",
                        textInputType: TextInputType.number,
                        hintText: "Enter Funds Raised",
                        controller: companyController.fundRaisedController),
                    sizedTextfield,
                    const TextWidget(
                        text: "Revenue Statistics",
                        textSize: 16,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 8),
                    MyCustomTextField.textField(
                        valText: "Please enter last year revenue",
                        lableText: "Last Year Revenue",
                        textInputType: TextInputType.number,
                        hintText: "Enter Last Year Revenue",
                        controller:
                            companyController.lastYearRevenueController),
                    sizedTextfield,
                    MyCustomTextField.textField(
                        valText: "Please enter target revenue",
                        lableText: "Target",
                        textInputType: TextInputType.number,
                        hintText: "Enter Target Revenue",
                        controller: companyController.targetController),
                    sizedTextfield,
                    sizedTextfield,
                    AppButton.primaryButton(
                        onButtonPressed: () {
                          if (formkey.currentState!.validate()) {
                            if (!widget.isEdit && base64 == "") {
                              HelperSnackBar.snackBar(
                                  "Error", "Upload an Image for the Company.");
                            }
                            Helper.loader(context);
                            companyController.createCompany().then((val) {
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
                    companyController.base64 = value;
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
