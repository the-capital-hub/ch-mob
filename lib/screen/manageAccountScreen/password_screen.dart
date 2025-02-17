import 'dart:developer';

import 'package:capitalhub_crm/screen/Auth-Process/authScreen/login_page.dart';
import 'package:capitalhub_crm/screen/Auth-Process/selectWhatYouAreScreen/select_role_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
                MyCustomTextField.textField(
                    controller: oldPassController,
                    lableText: 'Old Password',
                    valText: "Please enter old password",
                    hintText: "Enter Old Password"),
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
                AppButton.primaryButton(
                    onButtonPressed: () {},
                    title: "Set Password")
              ],
            ),
          ),
        ));
  }
}
