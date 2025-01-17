import 'package:capitalhub_crm/screen/profileScreen/challengeScreen/select_name_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/app_var.dart';

class BrainStromingScreen extends StatefulWidget {
  const BrainStromingScreen({super.key});

  @override
  State<BrainStromingScreen> createState() => _BrainStromingScreenState();
}

class _BrainStromingScreenState extends State<BrainStromingScreen> {
  TextEditingController brainstormingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
      backgroundColor: AppColors.transparent,
      appBar:
          HelperAppBar.appbarHelper(title: "Brand Identify", autoAction: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyCustomTextField.textField(
            hintText: "Description about idea",
            lableText: "Brainstorming",maxLine: 8,
            controller: brainstormingController),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(SelectNameScreen());
            },
            title: "Next"),
      ),
    ));
  }
}
