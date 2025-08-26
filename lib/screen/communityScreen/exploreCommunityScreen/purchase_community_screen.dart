import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/profileController/profile_controller.dart';
import '../../../utils/paymentService/payment_service.dart';
import '../communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';

class CommunityPurchaseScreen extends StatefulWidget {
  int index;
  CommunityPurchaseScreen({required this.index, super.key});

  @override
  State<CommunityPurchaseScreen> createState() =>
      _CommunityPurchaseScreenState();
}

class _CommunityPurchaseScreenState extends State<CommunityPurchaseScreen> {
  CommunityProductsAndMembersController communityProducts =
      Get.put(CommunityProductsAndMembersController());
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            drawer: const DrawerWidget(),
            backgroundColor: AppColors.transparent,
            appBar: AppBar(
              backgroundColor: AppColors.black,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: AppColors.white,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.transparent,
                    foregroundImage: NetworkImage(communityLogo),
                  ),
                ],
              ),
              title: TextWidget(text: communityName, textSize: 16),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(() => const HomeScreen());
                    },
                    icon: Icon(
                      Icons.swap_horizontal_circle_sharp,
                      color: AppColors.white,
                      size: 30,
                    ))
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
                child: Column(children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.transparent,
                    backgroundImage: NetworkImage(allCommunities
                        .allCommunitiesDetails[widget.index].image),
                  ),
                  const TextWidget(
                    text: "Purchase Community",
                    textSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    color: AppColors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            text: "Details",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          Divider(
                            color: AppColors.white38,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                            text: "Name:",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GetStoreData.getStore.read('isInvestor')
                                ? AppColors.primaryInvestor
                                : AppColors.primary,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                              text: allCommunities
                                  .allCommunitiesDetails[widget.index]
                                  .community,
                              textSize: 13),
                          const SizedBox(height: 8),
                          Divider(
                            color: AppColors.white38,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                            text: "Created At:",
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                            color: GetStoreData.getStore.read('isInvestor')
                                ? AppColors.primaryInvestor
                                : AppColors.primary,
                          ),
                          const SizedBox(height: 8),
                          TextWidget(
                              text: allCommunities
                                  .allCommunitiesDetails[widget.index]
                                  .createdAtTimeAgo,
                              textSize: 13),
                          const SizedBox(height: 8),
                          Divider(
                            color: AppColors.white38,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Members",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        GetStoreData.getStore.read('isInvestor')
                                            ? AppColors.primaryInvestor
                                            : AppColors.primary,
                                  ),
                                  const SizedBox(height: 8),
                                  TextWidget(
                                      text: allCommunities
                                          .allCommunitiesDetails[widget.index]
                                          .members,
                                      textSize: 13),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: "Price",
                                    textSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        GetStoreData.getStore.read('isInvestor')
                                            ? AppColors.primaryInvestor
                                            : AppColors.primary,
                                  ),
                                  const SizedBox(height: 8),
                                  TextWidget(
                                      text:
                                          "${allCommunities.allCommunitiesDetails[widget.index].amount}/-",
                                      textSize: 13),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(12),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: AppButton.outlineButton(
                      borderColor: GetStoreData.getStore.read('isInvestor')
                          ? AppColors.primaryInvestor
                          : AppColors.primary,
                      onButtonPressed: () {
                        Get.back();
                      },
                      title: "Cancel"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton.primaryButton(
                      onButtonPressed: () {
                        ProfileController profileController =
                            Get.put(ProfileController());
                        final paymentService = CashFreePaymentService();
                      },
                      title: "Proceed to Payment"),
                ),
              ]),
            )));
  }

  _joinNowTap(index) async {
    createdCommunityId = allCommunities.allCommunitiesDetails[index].id;
    communityLogo = allCommunities.allCommunitiesDetails[index].image;
    communityName = allCommunities.allCommunitiesDetails[index].community;
    isAdmin = allCommunities.allCommunitiesDetails[index].role == "Admin"
        ? true
        : false;
    await allCommunities.joinCommunity();
    Get.to(() => const CommunityLandingScreen());
  }
}
