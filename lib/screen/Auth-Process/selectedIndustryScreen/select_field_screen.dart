import 'package:capitalhub_crm/screen/Auth-Process/selectedIndustryScreen/select_industry_screen.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/buttons/button.dart';

class SelecteFieldScreen extends StatefulWidget {
  const SelecteFieldScreen({super.key});

  @override
  State<SelecteFieldScreen> createState() => _SelecteFieldScreenState();
}

class _SelecteFieldScreenState extends State<SelecteFieldScreen> {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration:  bgDec,
      child:
    Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Select Field", action: [
          TextWidget(
            text: "Skip",
            textSize: 14,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(width: 12),
        ]),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return sizedTextfield;
          },
          itemCount: 5,
          padding: EdgeInsets.all(12),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                selectedIndex = index;
                setState(() {});
              },
              child: Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.white12,
                    border: Border.all(
                        color: selectedIndex == index
                            ? AppColors.primary
                            : AppColors.transparent,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(12)),
                child: TextWidget(
                    text: "Technology and Innovation",
                    color: selectedIndex == index
                        ? AppColors.primary
                        : AppColors.white,
                    textSize: 15),
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                if (selectedIndex != -1) {
                  Get.to(SelectIndustryScreen());
                }
              },
              bgColor:
                  selectedIndex == -1 ? AppColors.white12 : AppColors.primary,
              title: "Next"),
        )));
  }

  int selectedIndex = -1;
}
