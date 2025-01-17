import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'login_page.dart';
import 'signup_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(PngAssetPath.appLogo),
                sizedTextfield,
                TextWidget(
                  text: "Welcome to the Capital Hub",
                  textSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                sizedTextfield,
                TextWidget(text: "Start your journey with us !", textSize: 16),
                sizedTextfield,
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                        child: AppButton.outlineButton(
                            onButtonPressed: () {
                              Get.to(LoginPage(),transition: Transition.downToUp,duration: transDuration);
                            },
                            title: "Login")),
                    SizedBox(width: 12),
                    Expanded(
                        child: AppButton.primaryButton(
                            onButtonPressed: () {
                              Get.to(SignupScreen(),transition: Transition.downToUp,duration: transDuration);
                            },
                            title: "Sign Up")),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
