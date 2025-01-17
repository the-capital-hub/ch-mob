import 'dart:async';

import 'package:capitalhub_crm/controller/loginController/login_controller.dart';
import 'package:capitalhub_crm/screen/Auth-Process/userDetailsScreen/upload_picture_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textWidget/text_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(title: ""),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  text: "Create a Username",
                  textSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                sizedTextfield,
                const TextWidget(
                  text:
                      "Add a username or use our suggestions. You can change this at any time.",
                  textSize: 14,
                  maxLine: 3,
                ),
                sizedTextfield,
                sizedTextfield,
                MyCustomTextField.textField(
                    hintText: "Enter Username",
                    lableText: "Username",
                    onChange: (val) {},
                    controller: loginController.usernameController),
                sizedTextfield,
                sizedTextfield,
                AppButton.primaryButton(
                    onButtonPressed: () {
                      FocusScope.of(context).unfocus();
                      loginController.getUserByUsername(context).then((val) {
                        if (val) {
                          loginController.updateFounder(context).then(((val) {
                            if (val) {
                              Get.to(UploadPictureScreen(),
                                  transition: Transition.rightToLeftWithFade,
                                  duration: transDuration);
                            }
                          }));
                        }
                      });

                      // Get.to(UploadPictureScreen(),
                      //     transition: Transition.rightToLeftWithFade,
                      //     duration: transDuration);
                    },
                    title: "Next")
              ],
            ),
          ),
        ));
  }
}
