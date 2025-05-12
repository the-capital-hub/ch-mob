import 'package:capitalhub_crm/controller/loginController/login_controller.dart';
import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/app_var.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/textwidget/text_widget.dart';

class PhilosophyScreen extends StatefulWidget {
  bool? isEdit;
  PhilosophyScreen({super.key, this.isEdit});

  @override
  State<PhilosophyScreen> createState() => _PhilosophyScreenState();
}

class _PhilosophyScreenState extends State<PhilosophyScreen> {
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    if (widget.isEdit == true) {
      profileController.philosophyController.text =
          profileController.profileData.user!.investmentPhilosophy ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: ""),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: "Philosophy",
                    textSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      hintText: "Write a philosophy",
                      maxLine: 12,
                      controller: profileController.philosophyController),
                  sizedTextfield,
                  sizedTextfield,
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        profileController.updatePhilosophy(context);
                      },
                      title: "Update")
                ],
              ),
            ),
          ),
        ));
  }
}
