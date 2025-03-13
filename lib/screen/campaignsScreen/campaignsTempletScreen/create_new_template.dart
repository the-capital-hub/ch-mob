import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../../widget/textwidget/text_widget.dart';

class CreateNewTemplate extends StatefulWidget {
  const CreateNewTemplate({super.key});

  @override
  State<CreateNewTemplate> createState() => _CreateNewTemplateState();
}

class _CreateNewTemplateState extends State<CreateNewTemplate> {
  TextEditingController templateNameController = TextEditingController();
  TextEditingController emailSubjectController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();
  String folder = "Capitalhub";
  String visibility = "Only you";
  String freeOrPaid = "Free";
  final QuillEditorController controller = QuillEditorController();
  Future<void> requestStoragePermission() async {
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomTextField.textField(
                    hintText: "Enter Template Name",
                    lableText: "Template Name",
                    controller: templateNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Email Subject",
                    lableText: "Email Subject",
                    controller: emailSubjectController),
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Email Body",
                    lableText: "Email Body",
                    maxLine: 4,
                    controller: emailBodyController),
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
                DropDownWidget(
                    status: folder,
                    lable: "Folder",
                    statusList: const ["Capitalhub", "xyz"],
                    onChanged: (v) {
                      folder = v!;
                      setState(() {});
                    }),
                sizedTextfield,
                DropDownWidget(
                    status: visibility,
                    lable: "Visibility",
                    statusList: const ["Only you", "Team", "Public"],
                    onChanged: (v) {
                      visibility = v!;
                      setState(() {});
                    }),
                sizedTextfield,
                DropDownWidget(
                    status: freeOrPaid,
                    lable: "Free or Paid",
                    statusList: const ["Free", "Paid"],
                    onChanged: (v) {
                      freeOrPaid = v!;
                      setState(() {});
                    })
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child:
              AppButton.primaryButton(onButtonPressed: () {}, title: "Create"),
        ),
      ),
    );
  }
}
