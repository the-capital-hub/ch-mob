import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class ProfessionalInfoScreen extends StatefulWidget {
  const ProfessionalInfoScreen({super.key});

  @override
  State<ProfessionalInfoScreen> createState() => _ProfessionalInfoScreenState();
}

class _ProfessionalInfoScreenState extends State<ProfessionalInfoScreen> {
  String selectExperience = "Select Experience";
  TextEditingController firstNameController = TextEditingController();
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
                  controller: firstNameController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Designation",
                  hintText: "Enter your designation",
                  controller: firstNameController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Industry",
                  hintText: "Enter your industry",
                  controller: firstNameController),
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
                  status: selectExperience,
                  statusList: const [
                    '0',
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
                      selectExperience = val.toString();
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
