import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfessionalInfoScreen extends StatefulWidget {
  const ProfessionalInfoScreen({super.key});

  @override
  State<ProfessionalInfoScreen> createState() => _ProfessionalInfoScreenState();
}

class _ProfessionalInfoScreenState extends State<ProfessionalInfoScreen> {
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Professional Information"),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              MyCustomTextField.textField(
                  lableText: "Company",
                  hintText: "Enter your company",
                  controller: profileController.companyController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Designation",
                  hintText: "Enter your designation",
                  controller: profileController.designationController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Industry",
                  hintText: "Enter your industry",
                  controller: profileController.industryController),
              sizedTextfield,
              const Row(
                children: [
                  TextWidget(
                    text: "Industry Experience",
                    textSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              sizedTextfield,
              DropDownWidget(
                  status: profileController.selectExperience,
                  statusList: const [
                    '0 Year',
                    '1 Year',
                    '2 Years',
                    '3 Years',
                    '4 Years',
                    '5 Years',
                    '6 Years',
                    '7 Years',
                    '8 Years',
                    '9 Years',
                    '10 Years',
                    '11 Years',
                    '12 Years',
                    '13 Years',
                    '14 Years',
                    '15 Years',
                    '16 Years',
                    '17 Years',
                    '18 Years',
                    '19 Years',
                    '20 Years',
                  ],
                  onChanged: (val) {
                    setState(() {
                      profileController.selectExperience = val.toString();
                    });
                  }),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Helper.loader(context);
                profileController.updateProffesionalInfo();
              },
              title: "Update"),
        ),
      ),
    );
  }
}
