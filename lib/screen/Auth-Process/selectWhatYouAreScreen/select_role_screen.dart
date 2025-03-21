// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:capitalhub_crm/screen/Auth-Process/authScreen/login_page.dart';
import 'package:capitalhub_crm/screen/Auth-Process/startUpFormScreen/startup_form_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/loginController/login_controller.dart';
import '../../../utils/constant/app_var.dart';
import '../investorFormScreen/investor_forn_screen.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  List<String> imgList = [
    PngAssetPath.startupImg,
    PngAssetPath.investorImg,
  ];
  List nameList = ["Startup", "Investor"];
  LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loginController.selectedRoleIndex = 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: AppBar(
            backgroundColor: AppColors.black,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const TextWidget(
              text: "Select one what you are",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(height: 22);
              },
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    loginController.selectedRoleIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: loginController.selectedRoleIndex == index
                                ? AppColors.primary
                                : AppColors.transparent,
                            width: 1.5),
                        color: AppColors.blackCard,
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 105,
                          decoration: BoxDecoration(
                              color: AppColors.white12,
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage(imgList[index]),
                                  fit: BoxFit.fitHeight)),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "${nameList[index]}",
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 8),
                              TextWidget(
                                text:
                                    "Lorem ipsum dolor sit amet consectetur. Maecenas ac elementum lacus vel vitae sed nisi aliquam aliquet. Vel adipiscing placerat tellus faucibus diam mauris ipsum vitae.",
                                textSize: 10,
                                maxLine: 4,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(12),
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  print(loginController.selectedRoleIndex);
                  Get.to(LoginPage());

                  // if (selectedIndex == 0) {
                  //   //startup
                  //   Get.to(StartupScreen(),transition: Transition.downToUp,duration: transDuration);
                  // } else if (selectedIndex == 1) {
                  //   //investor
                  //   Get.to(InvestorFormScreen(),transition: Transition.downToUp,duration: transDuration);

                  // }
                },
                bgColor: loginController.selectedRoleIndex == -1
                    ? AppColors.white12
                    : AppColors.primary,
                title: "Next"),
          ),
        ));
  }
}
