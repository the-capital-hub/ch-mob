import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/app_var.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/text_field/text_field.dart';
import '../welcomeCompanyScreen/welcome_company_screen.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController twitterLinkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    Container(
      decoration:  bgDec,
      child:
     Scaffold(backgroundColor: AppColors.transparent,
      appBar: HelperAppBar.appbarHelper(title: "Social Media Links"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MyCustomTextField.textField(
                lableText: "Facebook",
                hintText: "Https://",
                controller: facebookLinkController),
            sizedTextfield,
            MyCustomTextField.textField(
                lableText: "Instagram",
                hintText: "Https://",
                controller: facebookLinkController),
            sizedTextfield,
            MyCustomTextField.textField(
                lableText: "Twitter",
                hintText: "Https://",
                controller: facebookLinkController),
            sizedTextfield,
          ],
        ),
      ),
       bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(() => WelcomeCompanyScreen());
            },
            title: "Confirm"),
      ),
    ));
  }
}
