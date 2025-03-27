import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/text_field/text_field.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Password",
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                if (profileController.profileData.banner!.isPasswordSet)
                  MyCustomTextField.textField(
                      controller: oldPassController,
                      lableText: 'Old Password',
                      valText: "Please enter old password",
                      hintText: "Enter Old Password"),
                if (profileController.profileData.banner!.isPasswordSet)
                  sizedTextfield,
                MyCustomTextField.textField(
                    controller: newPassController,
                    lableText: 'New Password',
                    valText: "Please enter new password",
                    hintText: "Enter New Password"),
                sizedTextfield,
                MyCustomTextField.textField(
                    controller: confirmPassController,
                    lableText: 'Confirm Password',
                    valText: "Please enter confirm password",
                    hintText: "Enter Confirm Password"),
                sizedTextfield,
                sizedTextfield,
                AppButton.primaryButton(
                    onButtonPressed: () {
                      if (newPassController.text ==
                          confirmPassController.text) {
                        Helper.loader(context);
                        profileController.setPassword(
                            newPassController.text, oldPassController.text);
                      } else {
                        HelperSnackBar.snackBar(
                            "Error", "Password does not match");
                      }
                    },
                    title: "Set Password")
              ],
            ),
          ),
        ));
  }
}
