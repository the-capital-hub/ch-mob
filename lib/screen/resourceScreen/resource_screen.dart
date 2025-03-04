import 'package:capitalhub_crm/controller/resourceController/resource_controller.dart';
import 'package:capitalhub_crm/screen/resourceScreen/resource_details_screen.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textWidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/app_var.dart';
import '../../widget/appbar/appbar.dart';
import '../drawerScreen/drawer_screen.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResourceController resourceController = Get.find();

    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: const DrawerWidget(),
          appBar: HelperAppBar.appbarHelper(
              title: "Resources", hideBack: true, autoAction: false),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            PngAssetPath.foxCurveImg,
                          ),
                          const TextWidget(
                            text: 'Welcome to the Hustlers Club',
                            textSize: 22,
                            align: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            maxLine: 1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWidget(
                            text:
                                'Hustlers Club gives you all the tools and support you need to take your startup to the next level.',
                            textSize: 16,
                            align: TextAlign.center,
                            maxLine: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.white12,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextWidget(
                            text: 'Access Now',
                            textSize: 25,
                            align: TextAlign.center,
                            fontWeight: FontWeight.bold,
                            maxLine: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      TextWidget(text: "Hey Nitin!", textSize: 22, fontWeight: FontWeight.bold,),
                      SizedBox(height: 16),
                      TextWidget(
                        text:
                            "Access essential playbooks for your business growth, convering GTM strategy, sales, marketing, pitch deck creation, and financial modeling. Designed to guide you with expert insights and proven strategies.",
                        textSize: 14,
                        maxLine: 5,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Card(
                        margin: EdgeInsets.zero,
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "Unlock Premium Resources",
                                textSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextWidget(
                                text: "INR 1,999",
                                textSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              AppButton.outlineButton(
                                  onButtonPressed: () {},
                                  title: "Get Premium",
                                  borderRadius: 10,
                                  borderColor: AppColors.primary)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Wrap(
                        spacing: 15,
                        runSpacing: 15,
                        children: List<Widget>.generate(
                            resourceController.menuItemsName.length, (index) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => ResourceDetailsScreen(index: index));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 120,
                              width: ((constraints.maxWidth / 2) - (15 / 2)),
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  border: Border.all(
                                      color: Colors.purple.shade100,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        resourceController.menuItemsIcons[index],
                                        height: 30,
                                        width: 30,
                                      ),
                                      Card(
                                        
                                        color: AppColors.brown,
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            children: [
                                              TextWidget(text: "locked", textSize: 10),
                                              SizedBox(width: 4,),
                                              Icon(Icons.lock,color: Colors.white,size: 15,),
                                            ],
                                          ),
                                        )),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  TextWidget(
                                    text:
                                        resourceController.menuItemsName[index],
                                    textSize: 16,
                                    fontWeight: FontWeight.bold,
                                    maxLine: 3,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
