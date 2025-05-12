import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeCompanyScreen extends StatefulWidget {
  const WelcomeCompanyScreen({super.key});

  @override
  State<WelcomeCompanyScreen> createState() => _WelcomeCompanyScreenState();
}

class _WelcomeCompanyScreenState extends State<WelcomeCompanyScreen> {
    @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {});
    // });
    // setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
      backgroundColor: AppColors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(PngAssetPath.appLogo, height: 18),
                  const SizedBox(width: 8),
                  const TextWidget(text: "Capital Hub", textSize: 16),
                ],
              ),
              Column(
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                  ),
                  sizedTextfield,
                  const SizedBox(height: 8),
                  const TextWidget(
                    text: "Welcome to the capital hub",
                    textSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  const TextWidget(text: "Pramodbadiger@21", textSize: 16),
                ],
              ),
              AppButton.primaryButton(
                  onButtonPressed: () {
                      homeController.selectIndex = 4;
                    Get.to(const LandingScreen(),transition: Transition.rightToLeftWithFade,duration: Duration(milliseconds: 800));
                  },
                  title: "Continue")
            ],
          ),
        ),
      ),
    ));
  }

  HomeController homeController = Get.put(HomeController());
}
