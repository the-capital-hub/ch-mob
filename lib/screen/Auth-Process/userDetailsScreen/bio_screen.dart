import 'package:capitalhub_crm/controller/loginController/login_controller.dart';
import 'package:capitalhub_crm/controller/profileController/profile_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/Auth-Process/welcomeCompanyScreen/welcome_company_screen.dart';
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
import '../selectedIndustryScreen/select_field_screen.dart';

class BioScreen extends StatefulWidget {
  bool? isEdit;
  BioScreen({super.key, this.isEdit});

  @override
  State<BioScreen> createState() => _BioScreenState();
}

class _BioScreenState extends State<BioScreen> {
  LoginController loginController = Get.put(LoginController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    if (widget.isEdit == true) {
      loginController.bioController.text = profileController.profileData.bio!;
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
                    text: "Add a Bio",
                    textSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  sizedTextfield,
                  const TextWidget(
                    text: "Write something about you!",
                    textSize: 14,
                    maxLine: 3,
                  ),
                  sizedTextfield,
                  sizedTextfield,
                  MyCustomTextField.textField(
                      hintText: "Write a bio here",
                      maxLine: 12,
                      controller: loginController.bioController),
                  sizedTextfield,
                  sizedTextfield,
                  AppButton.primaryButton(
                      onButtonPressed: () {
                        if (widget.isEdit == true) {
                          profileController.updateBio(
                              context, loginController.bioController.text);
                        } else {
                          loginController.updateFounder(context).then((val) {
                            if (val) {
                              if (GetStoreData.getStore
                                  .read('isInvestor')) {
                                Get.offAll(LandingScreenInvestor());
                              } else {
                                Get.offAll(LandingScreen());
                              }
                            }
                          });
                        }
                      },
                      title: "Next")
                ],
              ),
            ),
          ),
        ));
  }
}
