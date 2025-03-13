import 'dart:developer';

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
  String folder = "Capitalhub";
  String visibility = "Only you";
  String freeOrPaid = "Free";
  final QuillEditorController controller = QuillEditorController();

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
                MyCustomTextField.htmlTextField(
                    hintText: "Enter Email Body",
                    lableText: "Email Body",
                    controller: controller),

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
