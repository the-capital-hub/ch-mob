import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';

import '../../utils/constant/app_var.dart';
import '../../widget/text_field/text_field.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  TextEditingController currentCompanyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController expController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
      backgroundColor: AppColors.transparent,
      appBar: HelperAppBar.appbarHelper(title: "Experience"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyCustomTextField.textField(
                lableText: "Current Company",
                hintText: "Enter Current Company",
                controller: currentCompanyController),
            sizedTextfield,
            MyCustomTextField.textField(
                lableText: "Designation",
                hintText: "Enter Designation",
                controller: designationController),
            sizedTextfield,
            MyCustomTextField.textField(
                lableText: "Education",
                hintText: "Enter Education",
                controller: educationController),
            sizedTextfield,
            MyCustomTextField.textField(
                lableText: "Experience",
                hintText: "Enter Experience",
                controller: expController),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {},bgColor: AppColors.white12, title: "Cancel")),
            const SizedBox(width: 12),
            Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {}, title: "Save"))
          ],
        ),
      ),
    ));
  }
}
