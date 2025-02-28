import 'dart:ui';

import 'package:capitalhub_crm/controller/newsController/news_controller.dart';
import 'package:capitalhub_crm/screen/Auth-Process/authScreen/signup_info_page.dart';
import 'package:capitalhub_crm/screen/chatScreen/community_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAboutScreen/communities_about_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddNewProductScreen/community_add_new_product_screen.dart';

import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/community_events_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityHomeScreen/community_home_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPeopleScreen/community_people_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsScreen/community_products_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityOverScreen/create_community_over_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityLandingScreen/create_community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityStartScreen/create_community_start_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/exploreCommunityScreen/explore_community_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/myCommunityScreen/my_community_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPurchaseScreen/community_purchase_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communitySettingsScreen/community_settings_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityUpdateSettingsScreen/community_update_settings_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/availability_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_new_webinar_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/events_screen.dart';
import 'package:capitalhub_crm/screen/analyticsScreen/analytics_screen.dart';
import 'package:capitalhub_crm/screen/companyScreen/company_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/exploreScreen/explore_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/screen/logoutScreen/logout_Screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/manage_account_Screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/plans_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/priority_dm_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/webinars_screen.dart';
import 'package:capitalhub_crm/screen/newsScreen/news_screen.dart';
import 'package:capitalhub_crm/screen/oneLinkScreen/one_link_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/profileController/profile_controller.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/getStore/get_store.dart';
import '../../widget/dilogue/logout.dart';
import '../../widget/textwidget/text_widget.dart';
import '../connectionScreen/connection_screen.dart';
import '../documentationScreen/documentation_screen.dart';
import '../helpScreen/help_screen.dart';
import '../savedPostScreen/saved_post_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final ProfileController profileController = Get.put(ProfileController());

  // final LogoutDialog _logout = LogoutDialog();
  List<String> items = [
    "Home",
    "Documentation",
    "Saved Post",
    "Explore",
    "News",
    "One link",
    "Company",
    "Team",
    "Analytics",
    "Community",
    "Meetings",
    "Investors",
    "Help",
    "Log Out",
  ];
  List<String> meetingsSubItems = [
    "Events",
    "Plans",
    "Availability",
    "Webinars",
    "Priority DMS"
  ];
  List<String> communitySubItems = [
    "Create a Community",
    "My Community",
    "Explore Community"
  ];
  List icons = [
    PngAssetPath.homeIcon,
    PngAssetPath.documentIcon,
    PngAssetPath.saveIcon,
    PngAssetPath.exploreIcon,
    PngAssetPath.newsIcon,
    PngAssetPath.onelinkIcon,
    PngAssetPath.financeIcon,
    PngAssetPath.teamIcon,
    PngAssetPath.customerIcon,
    PngAssetPath.communityIcon,
    PngAssetPath.meetingIcon,
    PngAssetPath.investorsIcon,
    PngAssetPath.helpIcon,
    PngAssetPath.logoutIcon,
  ];
  List page = [
    const LandingScreen(),
    const DocumentationScreen(),
    const SavedPostScreen(),
    const ExploreScreen(),
    const NewsScreen(),
    const OneLinkScreeen(),
    const CompanyScreen(),
    const ConnectionScreen(),
    const AnalyticsScreen(),
    const EventsScreen(),
    const CommunityLandingScreen(),
    const LandingScreen(),
    const HelpScreen(),
    const LogoutScreen(),
  ];
  List meetingsSubPages = [
    const EventsScreen(),
    const PlansScreen(),
    const AvailabilityScreen(),
    const WebinarsScreen(),
    const PriorityDMScreen()
  ];
  List communitySubPages = [
    const CreateCommunityLandingScreen(),
    const MyCommunityScreen(),
    const ExploreCommunityScreen(), 
  ];
  bool isExpanded = false;
  List<bool> isExpandedList = List.generate(13, (index) => false);
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        // if (index == 9) {
                        //   return _buildExpansionTile(index); // For index 8
                        // } else if (index == 10) {
                        //   return _buildExpansionTile(index); // For index 9
                         if (index == 9 || index == 10) {
                          return _buildExpansionTile(index);
                        } else {
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
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 0);
                      },
                    ),
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
                                    Get.to(const ProfileScreen());
                                  },
                                  height: 38,
                                  title: "View Profile"),
                              const SizedBox(height: 8),
                              AppButton.primaryButton(
                                  onButtonPressed: () {
                                    Get.to(const ManageAccountScreen());
                                  },
                                  height: 38,
                                  bgColor: AppColors.white12,
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

  // Widget _buildExpansionTile() {
  //   return Theme(
  //     data: ThemeData(
  //       dividerColor: Colors.transparent,
  //     ),
  //     child: ExpansionTile(
  //       visualDensity: VisualDensity.compact,
  //       dense: true,
  //       tilePadding: const EdgeInsets.only(left: 20),
  //       collapsedIconColor: AppColors.white,
  //       iconColor: AppColors.primary,
  //       onExpansionChanged: (bool expanded) {
  //         setState(() {
  //           isExpanded = expanded;
  //         });
  //       },
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Image.asset(
  //             PngAssetPath.meetingIcon,
  //             color: isExpanded ? AppColors.primary : AppColors.white,
  //             height: 22,
  //           ),
  //           const SizedBox(width: 12),
  //           TextWidget(
  //             text: "Meetings",
  //             textSize: 16,
  //             fontWeight: FontWeight.w500,
  //             maxLine: 1,
  //             align: TextAlign.center,
  //             color: isExpanded ? AppColors.primary : AppColors.white,
  //           ),
  //         ],
  //       ),
  //       children: meetingsSubItems.map((meetingsSubItemsTitle) {
  //         int meetingsSubItemsIndex =
  //             meetingsSubItems.indexOf(meetingsSubItemsTitle);
  //         return SizedBox(
  //           height: 30,
  //           child: ListTile(
  //             dense: true,
  //             visualDensity: VisualDensity.compact,
  //             contentPadding:
  //                 const EdgeInsets.only(left: 55, top: 0, bottom: 0),
  //             title: TextWidget(
  //               text: meetingsSubItemsTitle,
  //               textSize: 16,
  //               fontWeight: FontWeight.w500,
  //               maxLine: 1,
  //               color: AppColors.white,
  //             ),
  //             onTap: () {
  //               Get.to(meetingsSubPages[meetingsSubItemsIndex]);
  //             },
  //           ),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }
  // Widget _buildExpansionTile(int index) {
  //   return Theme(
  //     data: ThemeData(
  //       dividerColor: Colors.transparent,
  //     ),
  //     child: ExpansionTile(
  //       visualDensity: VisualDensity.compact,
  //       dense: true,
  //       tilePadding: const EdgeInsets.only(left: 20),
  //       collapsedIconColor: AppColors.white,
  //       iconColor: AppColors.primary,
  //       onExpansionChanged: (bool expanded) {
  //         setState(() {
  //           isExpanded = expanded;
  //         });
  //       },
  //       title: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Image.asset(
  //             icons[index],
  //             color: isExpanded ? AppColors.primary : AppColors.white,
  //             height: 22,
  //           ),
  //           const SizedBox(width: 12),
  //           TextWidget(
  //             text: items[index],
  //             textSize: 16,
  //             fontWeight: FontWeight.w500,
  //             maxLine: 1,
  //             align: TextAlign.center,
  //             color: isExpanded ? AppColors.primary : AppColors.white,
  //           ),
  //         ],
  //       ),
  //       children: 
  //       items[index]=="Community"?
        
  //        communitySubItems.map((communitySubItemsTitle) {
  //         int communitySubItemsIndex =
  //             communitySubItems.indexOf(communitySubItemsTitle);
  //         return SizedBox(
  //           height: 30,
  //           child: ListTile(
  //             dense: true,
  //             visualDensity: VisualDensity.compact,
  //             contentPadding:
  //                 const EdgeInsets.only(left: 55, top: 0, bottom: 0),
  //             title: TextWidget(
  //               text: communitySubItemsTitle,
  //               textSize: 16,
  //               fontWeight: FontWeight.w500,
  //               maxLine: 1,
  //               color: AppColors.white,
  //             ),
  //             onTap: () {
  //               Get.to(communitySubPages[communitySubItemsIndex]);
  //             },
  //           ),
  //         );
  //       }).toList():
  //       meetingsSubItems.map((meetingsSubItemsTitle) {
  //         int meetingsSubItemsIndex =
  //             meetingsSubItems.indexOf(meetingsSubItemsTitle);
  //         return SizedBox(
  //           height: 30,
  //           child: ListTile(
  //             dense: true,
  //             visualDensity: VisualDensity.compact,
  //             contentPadding:
  //                 const EdgeInsets.only(left: 55, top: 0, bottom: 0),
  //             title: TextWidget(
  //               text: meetingsSubItemsTitle,
  //               textSize: 16,
  //               fontWeight: FontWeight.w500,
  //               maxLine: 1,
  //               color: AppColors.white,
  //             ),
  //             onTap: () {
  //               Get.to(meetingsSubPages[meetingsSubItemsIndex]);
  //             },
  //           ),
  //         );
  //       }).toList()
  //     ),
  //   );
  // }

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
        iconColor: AppColors.primary,
        onExpansionChanged: (bool expanded) {
          setState(() {
            isExpandedList[index] = expanded; // Update specific index expansion state
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icons[index],
              color: isExpandedList[index] ? AppColors.primary : AppColors.white,
              height: 22,
            ),
            const SizedBox(width: 12),
            TextWidget(
              text: items[index],
              textSize: 16,
              fontWeight: FontWeight.w500,
              maxLine: 1,
              align: TextAlign.center,
              color: isExpandedList[index] ? AppColors.primary : AppColors.white,
            ),
          ],
        ),
        children: index == 9
            ? communitySubItems.map((communitySubItemsTitle) {
                int communitySubItemsIndex = communitySubItems.indexOf(communitySubItemsTitle);
                return SizedBox(
                  height: 30,
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.only(left: 55, top: 0, bottom: 0),
                    title: TextWidget(
                      text: communitySubItemsTitle,
                      textSize: 16,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                      color: AppColors.white,
                    ),
                    onTap: () {
                      Get.to(communitySubPages[communitySubItemsIndex]);
                    },
                  ),
                );
              }).toList()
            : meetingsSubItems.map((meetingsSubItemsTitle) {
                int meetingsSubItemsIndex = meetingsSubItems.indexOf(meetingsSubItemsTitle);
                return SizedBox(
                  height: 30,
                  child: ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    contentPadding: const EdgeInsets.only(left: 55, top: 0, bottom: 0),
                    title: TextWidget(
                      text: meetingsSubItemsTitle,
                      textSize: 16,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                      color: AppColors.white,
                    ),
                    onTap: () {
                      Get.to(meetingsSubPages[meetingsSubItemsIndex]);
                    },
                  ),
                );
              }).toList(),
      ),
    );
  }
}