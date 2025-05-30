
import 'package:capitalhub_crm/controller/newsController/news_controller.dart';
import 'package:capitalhub_crm/screen/Auth-Process/authScreen/signupInfoScreens/signup_info_page.dart';
import 'package:capitalhub_crm/screen/campaignsScreen/campaign_landing_screen.dart';
import 'package:capitalhub_crm/screen/chatScreen/group_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityLandingScreen/create_community_landing_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/exploreCommunityScreen/explore_community_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/myCommunityScreen/my_community_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/availability_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/events_screen.dart';
import 'package:capitalhub_crm/screen/analyticsScreen/analytics_screen.dart';
import 'package:capitalhub_crm/screen/companyScreen/company_screen.dart';
import 'package:capitalhub_crm/screen/createPostScreen/create_post_screen.dart';
import 'package:capitalhub_crm/screen/exploreScreen/explore_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/screen/logoutScreen/logout_Screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/manage_account_Screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/plans_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/priority_dm_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/webinars_screen.dart';
import 'package:capitalhub_crm/screen/newsScreen/news_screen.dart';
import 'package:capitalhub_crm/screen/oneLinkScreen/one_link_screen.dart';
import 'package:capitalhub_crm/screen/profileScreen/profile_screen.dart';
import 'package:capitalhub_crm/screen/resourceScreen/resource_screen.dart';
import 'package:capitalhub_crm/screen/spotlLightScreen/spotlight_landing_screen.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../controller/homeController/home_controller.dart';
import '../../controller/profileController/profile_controller.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/getStore/get_store.dart';
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
  HomeController homeController = Get.find();

  // final LogoutDialog _logout = LogoutDialog();
  List<String> items = [
    "Home",
    "Explore",
    "Company",
    "Documentation",
    "One link",
    "Resources",
    "Campaign",
    // "Meetings",
    "Analytics",
    "Saved Post",
    "News",
    "Team",
    "Community",
    "Meetings",
    "Spotlight",
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
    PngAssetPath.exploreIcon,
    PngAssetPath.financeIcon, // Company
    PngAssetPath.documentIcon,
    PngAssetPath.onelinkIcon,
    PngAssetPath.resourceIcon,
    PngAssetPath.campaignIcon,
    // PngAssetPath.meetingIcon,
    PngAssetPath.customerIcon, // Analytics
    PngAssetPath.saveIcon, // Saved Post
    PngAssetPath.newsIcon,
    PngAssetPath.teamIcon,
    PngAssetPath.communityIcon,
    PngAssetPath.meetingIcon,
    PngAssetPath.spotlightIcon,
    PngAssetPath.helpIcon,
    PngAssetPath.logoutIcon,
  ];
  List page = [
    const LandingScreen(),
    const ExploreScreen(),
    const CompanyScreen(),
    const DocumentationScreen(),
    const OneLinkScreeen(),
    const ResourceScreen(),
    const CampaignLandingScreen(),
    // const EventsScreen(),
    const AnalyticsScreen(),
    const SavedPostScreen(),
    const NewsScreen(),
    const ConnectionScreen(), // Team
    const CommunityLandingScreen(),
    const EventsScreen(),
    const SpotLightLandingScreen(),
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
    const ExploreCommunityScreen()
  ];
  bool isExpanded = false;
  List<bool> isExpandedList = List.generate(14, (index) => false);
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
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            delay: const Duration(milliseconds: 50),
                            duration: const Duration(
                                milliseconds: 300), // Smooth animation
                            child: SlideAnimation(
                                horizontalOffset: -250,
                                verticalOffset: -20,
                                curve:
                                    Curves.easeOutBack, // Adds a bounce effect
                                child: FadeInAnimation(
                                    child: (index == 11 || index == 12)
                                        ? _buildExpansionTile(index)
                                        : InkWell(
                                            onTap: () {
                                              if (index == 0) {
                                                homeController.selectIndex = 0;
                                              }
                                              Get.to(page[index]);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  100),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  100))),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
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
            isExpandedList[index] = expanded;
          });
        },
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icons[index],
              color:
                  isExpandedList[index] ? AppColors.primary : AppColors.white,
              height: 22,
            ),
            const SizedBox(width: 12),
            TextWidget(
              text: items[index],
              textSize: 16,
              fontWeight: FontWeight.w500,
              maxLine: 1,
              align: TextAlign.center,
              color:
                  isExpandedList[index] ? AppColors.primary : AppColors.white,
            ),
          ],
        ),
        children: index == 11
            ? communitySubItems.map((communitySubItemsTitle) {
                int communitySubItemsIndex =
                    communitySubItems.indexOf(communitySubItemsTitle);
                return InkWell(
                  onTap: () {
                    Get.to(communitySubPages[communitySubItemsIndex]);
                  },
                  splashColor: AppColors.transparent,
                  child: SizedBox(
                    height: 35,
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding:
                          const EdgeInsets.only(left: 55, top: 0, bottom: 0),
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
                          const EdgeInsets.only(left: 55, top: 0, bottom: 0),
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
