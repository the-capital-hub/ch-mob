import 'package:capitalhub_crm/screen/Auth-Process/userDetailsScreen/username_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/appbar/appbar.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/dropdownWidget/drop_down_widget.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';

class InvestorFormScreen extends StatefulWidget {
  const InvestorFormScreen({super.key});

  @override
  State<InvestorFormScreen> createState() => _InvestorFormScreenState();
}

class _InvestorFormScreenState extends State<InvestorFormScreen> {
  String gender = "Male";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController portfolioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
      appBar: HelperAppBar.appbarHelper(title: "Investor"),
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
              const TextWidget(
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
                  const SizedBox(width: 12),
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
                  const SizedBox(width: 12),
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
              DropDownWidget(
                  status: "Capital Hub",
                  lable: "Select Company",
                  statusList: const [
                    "Capital Hub",
                  ],
                  onChanged: (val) {}),
              sizedTextfield,
              DropDownWidget(
                  status: "Finance",
                  lable: "Select Industry",
                  statusList: const [
                    "Finance",
                  ],
                  onChanged: (val) {}),
              sizedTextfield,
              DropDownWidget(
                  status: "0-5 Lakhs",
                  lable: "Maximum Investment",
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
                  lable: "Minimum Investment",
                  statusList: const [
                    "0-5 Lakhs",
                    "5-15 Lakhs",
                    "15-25 Lakhs",
                    "25-50 Lakhs"
                  ],
                  onChanged: (val) {}),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Portfolio",
                  hintText: "Enter Portfolio",
                  controller: portfolioController),
              sizedTextfield,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Get.to(() => UserNameScreen());
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
