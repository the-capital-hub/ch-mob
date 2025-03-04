import 'package:capitalhub_crm/controller/myStartupsController/my_startups_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors/app_colors.dart';
import 'add_startup_screen.dart';

class MyStartupScreen extends StatefulWidget {
  const MyStartupScreen({super.key});

  @override
  State<MyStartupScreen> createState() => _MyStartupScreenState();
}

class _MyStartupScreenState extends State<MyStartupScreen> {
  MyStartupsController myStartupsController = Get.put(MyStartupsController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidgetInvestor(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "My Startups", autoAction: true, hideBack: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(text: "My Investments", textSize: 15),
                    InkWell(
                      onTap: () {
                        Get.to(() => AddStartupScreen(
                            isMyInvestment: true, isEdit: false));
                      },
                      child: const TextWidget(
                        text: "+ Add",
                        textSize: 15,
                        color: AppColors.primaryInvestor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                sizedTextfield,
                SizedBox(
                  height: 210,
                  child: ListView.separated(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            width: Get.width / 1.3,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.white38, width: 0.4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage("url"),
                                    ),
                                    SizedBox(width: 8),
                                    TextWidget(
                                        text: "ACCIO ROBOTICS", textSize: 15),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const TextWidget(
                                  text:
                                      "Company description: Startup that works in Robo research and engineering. Startup that works in Robo research and engineering. Robo research and engineering.",
                                  textSize: 13,
                                  maxLine: 5,
                                ),
                                const Spacer(),
                                Divider(
                                  color: AppColors.white54,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.local_atm,
                                        color: AppColors.white),
                                    const SizedBox(width: 6),
                                    const TextWidget(
                                        text: "Invested: 20% Equity",
                                        textSize: 13),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              right: 6,
                              top: 6,
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => AddStartupScreen(
                                      isMyInvestment: true, isEdit: true));
                                },
                                child: CircleAvatar(
                                    backgroundColor: AppColors.whiteShade,
                                    radius: 12,
                                    child: Icon(Icons.edit,
                                        size: 16, color: AppColors.black)),
                              )),
                        ],
                      );
                    },
                  ),
                ),
                sizedTextfield,
                const TextWidget(text: "My Interests", textSize: 15),
                sizedTextfield,
                SizedBox(
                  height: 210,
                  child: ListView.separated(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            width: Get.width / 1.3,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.blackCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColors.white38, width: 0.4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 22,
                                      backgroundImage: NetworkImage("url"),
                                    ),
                                    SizedBox(width: 8),
                                    TextWidget(
                                        text: "ACCIO ROBOTICS", textSize: 15),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                const TextWidget(
                                  text:
                                      "Company description: Startup that works in Robo research and engineering. Startup that works in Robo research and engineering. Robo research and engineering.",
                                  textSize: 13,
                                  maxLine: 5,
                                ),
                                const Spacer(),
                                Divider(
                                  color: AppColors.white54,
                                ),
                                const TextWidget(
                                    text: "My Commitment:", textSize: 13)
                              ],
                            ),
                          ),
                          Positioned(
                              right: 8,
                              top: 8,
                              child: CircleAvatar(
                                  backgroundColor: AppColors.redColor,
                                  radius: 11,
                                  child: Icon(Icons.remove_circle,
                                      size: 16, color: AppColors.whiteShade))),
                        ],
                      );
                    },
                  ),
                ),
                sizedTextfield,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(text: "Past Investments", textSize: 15),
                    InkWell(
                      onTap: () {
                        Get.to(() => AddStartupScreen(
                              isMyInvestment: false,
                              isEdit: false,
                            ));
                      },
                      child: const TextWidget(
                          text: "+ Add",
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryInvestor,
                          textSize: 14),
                    ),
                  ],
                ),
                sizedTextfield,
                ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          // height: 150,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.blackCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.white38, width: 0.4),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundImage: NetworkImage("url"),
                                  ),
                                  SizedBox(width: 8),
                                  TextWidget(
                                      text: "ACCIO ROBOTICS", textSize: 15),
                                ],
                              ),
                              SizedBox(height: 6),
                              TextWidget(
                                text:
                                    "Company description: Startup that works in Robo research and engineering. Startup that works in Robo research and engineering. Robo research and engineering.",
                                textSize: 13,
                                maxLine: 5,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            right: 8,
                            top: 8,
                            child: InkWell(
                              onTap: () {
                                Get.to(() => AddStartupScreen(
                                    isMyInvestment: false, isEdit: true));
                              },
                              child: CircleAvatar(
                                  backgroundColor: AppColors.whiteShade,
                                  radius: 12,
                                  child: Icon(Icons.edit,
                                      size: 16, color: AppColors.black)),
                            )),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
