import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../userDetailsScreen/username_screen.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
      appBar: HelperAppBar.appbarHelper(title: "Startup"),
      backgroundColor: AppColors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                  text:
                      "Enter the required information below . You can change it anytime you want",
                  textSize: 12,
                  maxLine: 3),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Full Name",
                  hintText: "Enter Full Name",
                  controller: fullNameController),
              sizedTextfield,
              TextWidget(
                  text: "Select your gender",
                  textSize: 12,
                  fontWeight: FontWeight.w500),
              Row(
                children: [
                  Radio(
                      value: "Male",
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact,
                      groupValue: gender,
                      onChanged: (val) {
                        gender = val!;
                        setState(() {});
                      }),
                  TextWidget(
                      text: "Male",
                      color: AppColors.whiteCard,
                      textSize: 14),
                  SizedBox(width: 12),
                  Radio(
                      value: "Female",
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact,
                      groupValue: gender,
                      onChanged: (val) {
                        gender = val!;
                        setState(() {});
                      }),
                  TextWidget(
                      text: "Female",
                      color: AppColors.whiteCard,
                      textSize: 14),
                  SizedBox(width: 12),
                  Radio(
                      value: "Non-binary",
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact,
                      groupValue: gender,
                      onChanged: (val) {
                        gender = val!;
                        setState(() {});
                      }),
                  TextWidget(
                      text: "Non-binary",
                      color: AppColors.whiteCard,
                      textSize: 14)
                ],
              ),
              const SizedBox(height: 4),
              MyCustomTextField.textField(
                  lableText: "Email Address",
                  hintText: "Enter Email",
                  controller: emailController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Comapany Name",
                  hintText: "Enter Company Name",
                  controller: companyNameController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Designation",
                  hintText: "Enter Designation",
                  controller: designationController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Industry",
                  hintText: "Enter Industry",
                  controller: industryController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Location",
                  hintText: "Enter Location",
                  controller: locationController),
              sizedTextfield,
              DropDownWidget(
                  status: "0-5 Lakhs",
                  lable: "Funding Ask",
                  statusList: const [
                    "0-5 Lakhs",
                    "5-15 Lakhs",
                    "15-25 Lakhs",
                    "25-50 Lakhs"
                  ],
                  onChanged: (val) {}),
              sizedTextfield,
              DropDownWidget(
                  status: "0-5 Lakhs",
                  lable: "Previous Funding",
                  statusList: const [
                    "0-5 Lakhs",
                    "5-15 Lakhs",
                    "15-25 Lakhs",
                    "25-50 Lakhs"
                  ],
                  onChanged: (val) {}),
              sizedTextfield,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Get.to(() => UserNameScreen(),transition: Transition.rightToLeftWithFade,duration: transDuration);
                    },
                    title: "Confirm"),
              ),
              sizedTextfield,
            ],
          ),
        ),
      ),
    ));
  }
}
