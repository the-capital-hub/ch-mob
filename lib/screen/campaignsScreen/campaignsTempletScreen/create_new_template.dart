import 'dart:developer';

import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewTemplate extends StatefulWidget {
  bool isEdit;
  int? index;
  CreateNewTemplate({super.key, required this.isEdit, this.index});

  @override
  State<CreateNewTemplate> createState() => _CreateNewTemplateState();
}

class _CreateNewTemplateState extends State<CreateNewTemplate> {
  CampaignsController campaignsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    if (widget.isEdit) {
      campaignsController.templateNameController.text =
          campaignsController.templateList[widget.index!].templateName!;
      campaignsController.templateSubjectController.text =
          campaignsController.templateList[widget.index!].templateSubject!;

      campaignsController.templateFolder =
          campaignsController.templateList[widget.index!].folder!;
      campaignsController.templateFreeOrPaid =
          campaignsController.templateList[widget.index!].pricingType!;
      campaignsController.templateVisibility =
          campaignsController.templateList[widget.index!].visibility!;
      campaignsController.templateAmountController.text =
          campaignsController.templateList[widget.index!].price!;
    } else {
      campaignsController.templateNameController.clear();
      campaignsController.templateSubjectController.clear();
      campaignsController.templateBodyController.clear();
      campaignsController.templateFolder = "Capitalhub";
      campaignsController.templateFreeOrPaid = "Free";
      campaignsController.templateVisibility = "Only you";
      campaignsController.templateAmountController.clear();
    }
    super.initState();
  }

  addEmailBody() async {
    await campaignsController.templateBodyController
        .setText(campaignsController.templateList[widget.index!].emailBody!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Create New Template"),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomTextField.textField(
                    valText: "Please enter template name",
                    hintText: "Enter Template Name",
                    lableText: "Template Name",
                    controller: campaignsController.templateNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    valText: "Please enter email subject",
                    hintText: "Enter Email Subject",
                    lableText: "Email Subject",
                    controller: campaignsController.templateSubjectController),
                sizedTextfield,
                MyCustomTextField.htmlTextField(
                    hintText: "Enter Email Body",
                    lableText: "Email Body",
                    onEditorCreated: () async {
                      if (widget.isEdit) {
                        addEmailBody();
                      }
                    },
                    controller: campaignsController.templateBodyController),
                sizedTextfield,
                DropDownWidget(
                    status: campaignsController.templateFolder,
                    lable: "Folder",
                    statusList: const [
                      "Capitalhub",
                      "Marketing",
                      "Sales",
                      "Support"
                    ],
                    onChanged: (v) {
                      campaignsController.templateFolder = v!;
                      setState(() {});
                    }),
                sizedTextfield,
                DropDownWidget(
                    status: campaignsController.templateVisibility,
                    lable: "Visibility",
                    statusList: const ["Only you", "Team", "Public"],
                    onChanged: (v) {
                      campaignsController.templateVisibility = v!;
                      setState(() {});
                    }),
                sizedTextfield,
                DropDownWidget(
                    status: campaignsController.templateFreeOrPaid,
                    lable: "Free or Paid",
                    statusList: const ["Free", "Paid"],
                    onChanged: (v) {
                      campaignsController.templateFreeOrPaid = v!;
                      setState(() {});
                    }),
                sizedTextfield,
                if (campaignsController.templateFreeOrPaid == "Paid")
                  MyCustomTextField.textField(
                      hintText: "Enter Amount",
                      textInputType: TextInputType.number,
                      lableText: "Amount",
                      controller: campaignsController.templateAmountController)
              ],
            ),
          ),
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                if (formkey.currentState!.validate()) {
                  Helper.loader(context);
                  if (widget.isEdit) {
                    campaignsController.editTemplate(campaignsController
                        .templateList[widget.index!].templateId);
                  } else {
                    campaignsController.createTemplate();
                  }
                }
              },
              title: widget.isEdit ? "Update" : "Create"),
        ),
      ),
    );
  }
}
