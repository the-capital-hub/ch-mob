import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../widget/dilogue/campaignDilogue/campaign_created_dilogue.dart';
import '../../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../../widget/textwidget/text_widget.dart';

class CreateCampaignsScreen extends StatefulWidget {
  const CreateCampaignsScreen({super.key});

  @override
  State<CreateCampaignsScreen> createState() => _CreateCampaignsScreenState();
}

class _CreateCampaignsScreenState extends State<CreateCampaignsScreen> {
  TextEditingController campaignNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  Future<void> requestStoragePermission() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  final QuillEditorController controller = QuillEditorController();

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
                                  const TextWidget(
                                    text: "1",
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
                                  const TextWidget(
                                    text: "1",
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
                                const TextWidget(
                                  text: "TEST",
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
                    controller: campaignNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Subject",
                    lableText: "Subject",
                    controller: subjectController),
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
                      ...ccEmails.map((email) => Chip(
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
                      ...bccEmails.map((email) => Chip(
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
                const TextWidget(
                    text: "Email Body",
                    textSize: 12,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: AppColors.white12), // Border effect
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.white12)),
                        child: ToolBar(
                          controller: controller,
                          toolBarColor: AppColors.transparent,
                          iconSize: 20,
                          activeIconColor: AppColors.white,
                          iconColor: AppColors.grey,
                          customButtons: [
                            InkWell(
                              onTap: () async {
                                await requestStoragePermission();
                                ImagePickerWidget imagePickerWidget =
                                    ImagePickerWidget();
                                imagePickerWidget.getImage(false).then((val) {
                                  controller.embedImage(
                                      'data:image/png;base64,' + val);
                                });
                              },
                              child: Icon(Icons.image,
                                  color: AppColors.white54, size: 20),
                            )
                          ],
                          padding: const EdgeInsets.all(8),
                          toolBarConfig: const [
                            ToolBarStyle.size,
                            ToolBarStyle.bold,
                            ToolBarStyle.underline,
                            ToolBarStyle.strike,
                            ToolBarStyle.listBullet,
                            ToolBarStyle.listOrdered,
                            ToolBarStyle.align,
                            ToolBarStyle.link,
                            // ToolBarStyle.image,
                            ToolBarStyle.codeBlock,
                            ToolBarStyle.italic,
                            ToolBarStyle.undo,
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      QuillHtmlEditor(
                        controller: controller,
                        hintText: "Enter Email Body",
                        minHeight: 200,
                        backgroundColor: AppColors.blackCard,
                        hintTextStyle: TextStyle(color: AppColors.white12),
                        textStyle: TextStyle(color: AppColors.white),

                        loadingBuilder: (context) {
                          return SizedBox();
                        }, // White text
                        onTextChanged: (text) {
                          print("HTML Output: $text");
                        },
                      ),
                    ],
                  ),
                ),
                sizedTextfield,
                AppButton.primaryButton(
                    onButtonPressed: () {
                      campaignCreatedPopup(context, () {}, () {}, () {});
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
  List<String> ccEmails = [];
  List<String> bccEmails = [];

  void ccAddEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isNotEmpty && emailRegex.hasMatch(email)) {
      if (!ccEmails.contains(email)) {
        setState(() {
          ccEmails.add(email);
        });
        ccController.clear();
      }
    }
  }

  void ccRemoveEmail(String email) {
    setState(() {
      ccEmails.remove(email);
    });
  }

  void bccAddEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isNotEmpty && emailRegex.hasMatch(email)) {
      if (!bccEmails.contains(email)) {
        setState(() {
          bccEmails.add(email);
        });
        bccController.clear();
      }
    }
  }

  void bccRemoveEmail(String email) {
    setState(() {
      bccEmails.remove(email);
    });
  }
}
