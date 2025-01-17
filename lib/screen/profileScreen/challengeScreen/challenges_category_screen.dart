import 'package:capitalhub_crm/screen/profileScreen/challengeScreen/brain_stroming_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/buttons/button.dart';

class ChallengeCategoryScreen extends StatefulWidget {
  const ChallengeCategoryScreen({super.key});

  @override
  State<ChallengeCategoryScreen> createState() =>
      _ChallengeCategoryScreenState();
}

class _ChallengeCategoryScreenState extends State<ChallengeCategoryScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Categories",
          autoAction: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: "Choose your categories", textSize: 16),
              sizedTextfield,
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              border: Border.all(
                                  color: selectedIndex == index
                                      ? AppColors.primary
                                      : AppColors.transparent,
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: FlutterLogo(),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextWidget(
                          text: "Brand Identify",
                          color: selectedIndex == index
                              ? AppColors.primary
                              : AppColors.white,
                          textSize: 12)
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
              Get.to(BrainStromingScreen());

              },
              bgColor:
                  selectedIndex == -1 ? AppColors.white12 : AppColors.primary,
              title: "Next"),
        )));
  }
}
