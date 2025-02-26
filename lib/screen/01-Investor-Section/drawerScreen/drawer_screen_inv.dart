import 'dart:ui';

import 'package:capitalhub_crm/screen/companyScreen/companyScreenInv/company_inv_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/exploreScreen/explore_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/screen/logoutScreen/logout_Screen.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/getStore/get_store.dart';
import '../../../widget/textwidget/text_widget.dart';

class DrawerWidgetInvestor extends StatefulWidget {
  const DrawerWidgetInvestor({super.key});

  @override
  State<DrawerWidgetInvestor> createState() => _DrawerWidgetInvestorState();
}

class _DrawerWidgetInvestorState extends State<DrawerWidgetInvestor> {
  // final ProfileController profileController = Get.put(ProfileController());

  List<String> items = [
    "Home",
    "Company",
    "Explore",
    "Log Out",
  ];
  List icons = [
    PngAssetPath.homeIcon,
    PngAssetPath.financeIcon,
    PngAssetPath.exploreIcon,
    PngAssetPath.logoutIcon,
  ];
  List page = [
    const LandingScreen(),
    const CompanyInvScreen(),
    const ExploreScreen(),
    const LogoutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedTextfield,
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${GetStoreData.getStore.read('profile_image')}'),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text:
                                          "${GetStoreData.getStore.read('name')}",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500),
                                  TextWidget(
                                      text:
                                          "${GetStoreData.getStore.read('phone')}",
                                      textSize: 12),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      child: AppButton.primaryButton(
                          onButtonPressed: () {},
                          height: 42,
                          title: "Create Post"),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemCount: items.length,
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 10,
                          right: 16,
                          left: 0,
                        ),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 6);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Get.to(page[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100))),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, top: 10, left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      icons[index],
                                      color: AppColors.white,
                                      height: 22,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    TextWidget(
                                        text: items[index],
                                        textSize: 16,
                                        fontWeight: FontWeight.w500,
                                        maxLine: 1,
                                        align: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    '${GetStoreData.getStore.read('profile_image')}'),
                              ),
                              const SizedBox(height: 8),
                              TextWidget(
                                text: "${GetStoreData.getStore.read('name')}",
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 3),
                              TextWidget(
                                  text:
                                      "${GetStoreData.getStore.read('email')}",
                                  textSize: 12),
                              const SizedBox(height: 3),
                              AppButton.primaryButton(
                                  onButtonPressed: () {},
                                  height: 38,
                                  title: "View Profile"),
                              const SizedBox(height: 8),
                              AppButton.primaryButton(
                                  onButtonPressed: () {},
                                  height: 38,
                                  bgColor: AppColors.white12,
                                  textColor: AppColors.white,
                                  title: "Manage Account"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedTextfield
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
