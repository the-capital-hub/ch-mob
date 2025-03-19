import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../utils/helper/helper.dart';
import '../../../widget/dilogue/campaignDilogue/campaign_created_dilogue.dart';
import '../../../widget/dilogue/campaignDilogue/schedule_campaign_dilogue.dart';
import '../../../widget/textwidget/text_widget.dart';

class CreateCampaignsScreen extends StatefulWidget {
  String templateId;
  CreateCampaignsScreen({super.key, required this.templateId});

  @override
  State<CreateCampaignsScreen> createState() => _CreateCampaignsScreenState();
}

class _CreateCampaignsScreenState extends State<CreateCampaignsScreen> {
  CampaignsController campaignsController = Get.find();
  @override
  void initState() {
    campaignsController.campaignSubjectController.text =
        campaignsController.proceedTemplateData.templateSubject!;
    campaignsController.ccEmails = campaignsController.proceedTemplateData.cc!;
    campaignsController.bccEmails.clear();
    campaignsController.campaignNameController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Create Campaign"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: AppColors.blackCard,
                  surfaceTintColor: AppColors.blackCard,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: "Campaign Summary",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        sizedTextfield,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: "Lists",
                                    textSize: 14,
                                    color: AppColors.whiteShade,
                                  ),
                                  const SizedBox(height: 2),
                                  TextWidget(
                                    text:
                                        "${campaignsController.proceedTemplateData.noOfList}",
                                    textSize: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                    color: AppColors.white38, width: 0)),
                            Expanded(
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: "Investors",
                                    textSize: 14,
                                    color: AppColors.whiteShade,
                                  ),
                                  const SizedBox(height: 2),
                                  TextWidget(
                                    text:
                                        "${campaignsController.proceedTemplateData.totalInvestor}",
                                    textSize: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                    color: AppColors.white38, width: 0)),
                            Expanded(
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: "VC",
                                    textSize: 14,
                                    color: AppColors.whiteShade,
                                  ),
                                  const SizedBox(height: 2),
                                  TextWidget(
                                    text:
                                        "${campaignsController.proceedTemplateData.totalVc}",
                                    textSize: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                    color: AppColors.white38, width: 0)),
                            Expanded(
                                child: Column(
                              children: [
                                TextWidget(
                                  text: "Template",
                                  textSize: 14,
                                  color: AppColors.whiteShade,
                                ),
                                const SizedBox(height: 2),
                                TextWidget(
                                  text:
                                      "${campaignsController.proceedTemplateData.templateName}",
                                  maxLine: 2,
                                  textSize: 14,
                                ),
                              ],
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Campaign Name",
                    lableText: "Campaign Name",
                    controller: campaignsController.campaignNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Subject",
                    lableText: "Subject",
                    readonly: true,
                    controller: campaignsController.campaignSubjectController),
                sizedTextfield,
                const TextWidget(
                  text: "CC",
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...campaignsController.ccEmails.map((email) => Chip(
                            label: TextWidget(
                              text: email,
                              textSize: 14,
                              color: AppColors.primary,
                            ),
                            backgroundColor: AppColors.black,
                            deleteIcon: const Icon(
                              Icons.close,
                              color: AppColors.redColor,
                              size: 20,
                            ),
                            onDeleted: () => ccRemoveEmail(email),
                          )),
                      SizedBox(
                        width: 150,
                        child: MyCustomTextField.textField(
                          controller: ccController,
                          textInputType: TextInputType.emailAddress,
                          hintText: "Enter email",
                          onSubmitted: ccAddEmail,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedTextfield,
                sizedTextfield,
                const TextWidget(
                  text: "BCC",
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 6, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ...campaignsController.bccEmails.map((email) => Chip(
                            label: TextWidget(
                              text: email,
                              textSize: 14,
                              color: AppColors.primary,
                            ),
                            backgroundColor: AppColors.black,
                            deleteIcon: const Icon(
                              Icons.close,
                              color: AppColors.redColor,
                              size: 20,
                            ),
                            onDeleted: () => bccRemoveEmail(email),
                          )),
                      SizedBox(
                        width: 150,
                        child: MyCustomTextField.textField(
                          controller: bccController,
                          hintText: "Enter email",
                          textInputType: TextInputType.emailAddress,
                          onSubmitted: bccAddEmail,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedTextfield,
                MyCustomTextField.htmlTextField(
                    hintText: "Enter Email Body",
                    lableText: "Email Body",
                    isEnable: false,
                    onEditorCreated: () {
                      campaignsController.emailContentcontroller.insertText(
                          campaignsController
                              .proceedTemplateData.templateContent!);
                    },
                    controller: campaignsController.emailContentcontroller),
                sizedTextfield,
                AppButton.primaryButton(
                    onButtonPressed: () {
                      Helper.loader(context);
                      campaignsController
                          .createCampaign(widget.templateId)
                          .then((val) {
                        if (val) {
                          campaignCreatedPopup(
                            context,
                            () {
                              Get.back(closeOverlays: true);
                              Get.back();
                            },
                            () {
                              scheduleCampaignPopup(context, () {
                                Helper.loader(context);
                                campaignsController
                                    .scheduleOutreachCampaign(
                                        isCancel: false,
                                        id: campaignsController.newCampaignID,
                                        fromViewScreen: false)
                                    .then((v) {
                                  Get.back(closeOverlays: true);
                                  Get.back(closeOverlays: true);
                                });
                              });
                            },
                            () {
                              Helper.loader(context);
                              campaignsController
                                  .runOutreachCampaign(
                                      campaignsController.newCampaignID, false)
                                  .then((val) {
                                Get.back(closeOverlays: true);
                                Get.back(closeOverlays: true);
                              });
                            },
                          );
                        }
                      });
                    },
                    title: "Create Campaign")
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController ccController = TextEditingController();
  final TextEditingController bccController = TextEditingController();

  void ccAddEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isNotEmpty && emailRegex.hasMatch(email)) {
      if (!campaignsController.ccEmails.contains(email)) {
        setState(() {
          campaignsController.ccEmails.add(email);
        });
        ccController.clear();
      }
    }
  }

  void ccRemoveEmail(String email) {
    setState(() {
      campaignsController.ccEmails.remove(email);
    });
  }

  void bccAddEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isNotEmpty && emailRegex.hasMatch(email)) {
      if (!campaignsController.bccEmails.contains(email)) {
        setState(() {
          campaignsController.bccEmails.add(email);
        });
        bccController.clear();
      }
    }
  }

  void bccRemoveEmail(String email) {
    setState(() {
      campaignsController.bccEmails.remove(email);
    });
  }
}
