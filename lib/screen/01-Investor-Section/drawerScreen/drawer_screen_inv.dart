import 'dart:ui';

import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityHomeScreen/community_home_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityLandingScreen/create_community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/exploreCommunityScreen/explore_community_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/myCommunityScreen/my_community_screen.dart';
import 'package:capitalhub_crm/screen/companyScreen/companyScreenInv/company_inv_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/exploreScreen/explore_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/screen/logoutScreen/logout_Screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/availability_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/events_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/plans_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/priority_dm_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/webinars_screen.dart';
import 'package:capitalhub_crm/screen/myStartupsScreen/my_startup_screen.dart';
import 'package:capitalhub_crm/screen/oneLinkScreen/one_link_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../controller/homeController/home_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/getStore/get_store.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../../connectionScreen/connection_screen.dart';
import '../../liveDealsScreen/live_deal_screen.dart';
import '../../manageAccountScreen/manage_account_Screen.dart';
import '../../newsScreen/news_screen.dart';
import '../../savedPostScreen/saved_post_screen.dart';

class DrawerWidgetInvestor extends StatefulWidget {
  const DrawerWidgetInvestor({super.key});

  @override
  State<DrawerWidgetInvestor> createState() => _DrawerWidgetInvestorState();
}

class _DrawerWidgetInvestorState extends State<DrawerWidgetInvestor> {
  // final ProfileController profileController = Get.put(ProfileController());
  HomeController homeController = Get.find();

  List<String> items = [
    "Home",
    "Company",
    "Explore",
    "Live deals",
    "One Link",
    "My Startups",
    "Community",
    "Meetings",
    "News",
    "Saved Post",
    "Connection",
    "Log Out",
  ];
  List<String> communitySubItems = [
    "Create a Community",
    "My Community",
    "Explore Community"
  ];
  List<String> meetingsSubItems = [
    "Events",
    "Plans",
    "Availability",
    "Webinars",
    "Priority DMS"
  ];
  List icons = [
    PngAssetPath.homeIcon,
    PngAssetPath.financeIcon,
    PngAssetPath.exploreIcon,
    PngAssetPath.liveDealIcon,
    PngAssetPath.onelinkIcon,
    PngAssetPath.mystartupIcon,
    PngAssetPath.communityIcon,
    PngAssetPath.meetingIcon,
    PngAssetPath.newsIcon,
    PngAssetPath.saveIcon,
    PngAssetPath.teamIcon,
    PngAssetPath.logoutIcon,
  ];
  List page = [
    const LandingScreenInvestor(),
    const CompanyInvScreen(),
    const ExploreScreen(),
    const LiveDealScreen(),
    const OneLinkScreeen(),
    const MyStartupScreen(),
    const CommunityHomeScreen(),
    const EventsScreen(),
    const NewsScreen(),
    const SavedPostScreen(),
    const ConnectionScreen(),
    const LogoutScreen(),
  ];
  List communitySubPages = [
    const CreateCommunityLandingScreen(),
    const MyCommunityScreen(),
    const ExploreCommunityScreen(),
  ];
  List meetingsSubPages = [
    const EventsScreen(),
    const PlansScreen(),
    const AvailabilityScreen(),
    const WebinarsScreen(),
    const PriorityDMScreen()
  ];
  bool isExpanded = false;
  List<bool> isExpandedList = List.generate(8, (index) => false);
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
                          onButtonPressed: () {
                            Get.to(CreatePostScreen());
                          },
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
                          return const SizedBox(height: 6);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              delay: const Duration(milliseconds: 50),
                              duration: const Duration(milliseconds: 300),
                              child: SlideAnimation(
                                  horizontalOffset: -250,
                                  verticalOffset: -20,
                                  curve: Curves.easeOutBack,
                                  child: FadeInAnimation(
                                      child: (index == 6 || index == 7)
                                          ? _buildExpansionTile(index)
                                          : InkWell(
                                              onTap: () {
                                                if (index == 0) {
                                                  homeController.selectIndex =
                                                      0;
                                                }
                                                Get.to(page[index]);
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    100),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    100))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          top: 10,
                                                          left: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          maxLine: 1,
                                                          align:
                                                              TextAlign.center),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))));
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
                                  onButtonPressed: () {
                                    Get.to(() => const ProfileScreen());
                                  },
                                  height: 40,
                                  title: "View Profile"),
                              const SizedBox(height: 8),
                              AppButton.primaryButton(
                                  onButtonPressed: () {
                                    Get.to(() => const ManageAccountScreen());
                                  },
                                  height: 40,
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

  Widget _buildExpansionTile(int index) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        visualDensity: VisualDensity.compact,
        dense: true,
        tilePadding: const EdgeInsets.only(left: 20),
        collapsedIconColor: AppColors.white,
        iconColor: AppColors.primaryInvestor,
        onExpansionChanged: (bool expanded) {
          setState(() {
            isExpandedList[index] =
                expanded; // Update specific index expansion state
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icons[index],
              color: isExpandedList[index]
                  ? AppColors.primaryInvestor
                  : AppColors.white,
              height: 22,
            ),
            const SizedBox(width: 12),
            TextWidget(
              text: items[index],
              textSize: 16,
              fontWeight: FontWeight.w500,
              maxLine: 1,
              align: TextAlign.center,
              color: isExpandedList[index]
                  ? AppColors.primaryInvestor
                  : AppColors.white,
            ),
          ],
        ),
        children: index == 6
            ? communitySubItems.map((communitySubItemsTitle) {
                int communitySubItemsIndex =
                    communitySubItems.indexOf(communitySubItemsTitle);
                return InkWell(
                  splashColor: AppColors.transparent,
                  onTap: () {
                    Get.to(communitySubPages[communitySubItemsIndex]);
                  },
                  child: SizedBox(
                    height: 35,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding:
                          const EdgeInsets.only(left: 55, bottom: 10),
                      title: TextWidget(
                        text: communitySubItemsTitle,
                        textSize: 15,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                );
              }).toList()
            : meetingsSubItems.map((meetingsSubItemsTitle) {
                int meetingsSubItemsIndex =
                    meetingsSubItems.indexOf(meetingsSubItemsTitle);
                return InkWell(
                  onTap: () {
                    Get.to(meetingsSubPages[meetingsSubItemsIndex]);
                  },
                  splashColor: AppColors.transparent,
                  child: SizedBox(
                    height: 35,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding:
                          const EdgeInsets.only(left: 55, bottom: 10),
                      title: TextWidget(
                        text: meetingsSubItemsTitle,
                        textSize: 15,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
      ),
    );
  }
}
