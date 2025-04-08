import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAboutScreen/communities_about_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityHomeScreen/community_home_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPeopleScreen/community_people_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/community_products_and_services_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityUpdateSettingsScreen/community_update_settings_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunityLandingScreen extends StatefulWidget {
  const CommunityLandingScreen({super.key});

  @override
  State<CommunityLandingScreen> createState() => _CommunityLandingScreenState();
}

class _CommunityLandingScreenState extends State<CommunityLandingScreen> {
  CommunityAboutController aboutCommunity = Get.put(CommunityAboutController());
  CommunityController myCommunities = Get.put(CommunityController());
  CommunityMeetingsController communityMeetings =
      Get.put(CommunityMeetingsController());
  CommunityController allCommunities = Get.put(CommunityController());
  int selectIndex = 0;
  GlobalKey<PopupMenuButtonState<String>> _popupMenuKey = GlobalKey();
  List adminIcons = [
    PngAssetPath.homeIcon,
    PngAssetPath.categoryIcon,
    PngAssetPath.teamIcon,
    PngAssetPath.infoIcon,
    PngAssetPath.exploreIcon
  ];
  List memberIcons = [
    PngAssetPath.homeIcon,
    PngAssetPath.categoryIcon,
    PngAssetPath.teamIcon,
    PngAssetPath.infoIcon,
  ];
  List adminTitle = ["Home", "Products", "People", "About", "Settings"];
  List memberTitle = ["Home", "Products", "People", "About"];
  List adminScreen = [
    const CommunityHomeScreen(),
    const CommunityProductsAndServicesScreen(),
    const CommunityPeopleScreen(),
    CommunityAboutScreen(
      isPublic: false,
      index: 0,
    ),
    const CommunityUpdateSettingsScreen()
  ];
  List memberScreen = [
    const CommunityHomeScreen(),
    const CommunityProductsAndServicesScreen(),
    const CommunityPeopleScreen(),
    CommunityAboutScreen(
      isPublic: false,
      index: 0,
    ),
  ];
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isAdmin) {
        allCommunities.getCommunityMemberSettings();

        communityMeetings.getMemberEmails();
      }
      aboutCommunity.getAboutCommunity().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.black,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CircleAvatar(
                radius: 20,
                foregroundImage: NetworkImage(communityLogo),
              ),
            ),
            title: TextWidget(text: communityName, textSize: 16),
            actions: [
              if (!isAdmin)
                PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    key: _popupMenuKey,
                    icon: Icon(
                      Icons.settings,
                      size: 22,
                    ),
                    iconColor: GetStoreData.getStore.read('isInvestor')
                        ? AppColors.black
                        : AppColors.white,
                    color: AppColors.blackCard,
                    offset: Offset(100, 55),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            enabled: false,
                            child: Row(
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Checkbox(
                                      value: allCommunities.receiveEmail,
                                      checkColor: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.black
                                          : AppColors.white,
                                      activeColor: GetStoreData.getStore
                                              .read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          allCommunities.receiveEmail = value!;
                                        });

                                        Helper.loader(context);
                                        allCommunities.toggleReceiveEmail();
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    );
                                  },
                                ),
                                const TextWidget(
                                  maxLine: 2,
                                  text: "Receive Community\nEmails",
                                  textSize: 16,
                                ),
                              ],
                            ),
                          ),
                          PopupMenuDivider(),
                          PopupMenuItem(
                            value: "admin",
                            child: TextWidget(
                              text: "Leave Community",
                              textSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.redColor,
                            ),
                            onTap: () {
                              Helper.loader(context);
                              myCommunities
                                  .leaveCommunity(createdCommunityId)
                                  .then((v) {
                                GetStoreData.getStore.read('isInvestor')
                                    ? Get.offAll(const LandingScreenInvestor())
                                    : Get.offAll(const LandingScreen());
                              });
                            },
                          ),
                        ]),
              InkWell(
                onTap: () {
                  GetStoreData.getStore.read('isInvestor')
                      ? Get.offAll(const LandingScreenInvestor())
                      : Get.offAll(const LandingScreen());
                },
                child: Icon(
                  Icons.swap_horizontal_circle_sharp,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          backgroundColor: AppColors.black,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Container(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
            decoration: BoxDecoration(
              color: AppColors.blackCard,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.white12,
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                isAdmin ? adminIcons.length : memberIcons.length,
                (index) => InkWell(
                  onTap: () {
                    selectIndex = index;
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          isAdmin ? adminIcons[index] : memberIcons[index],
                          color: selectIndex == index
                              ? GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.primaryInvestor
                                  : AppColors.primary
                              : AppColors.whiteCard,
                          height: 22,
                        ),
                        const SizedBox(height: 2),
                        TextWidget(
                          text:
                              isAdmin ? adminTitle[index] : memberTitle[index],
                          textSize: 10,
                          color: selectIndex == index
                              ? GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.primaryInvestor
                                  : AppColors.primary
                              : AppColors.whiteCard,
                          maxLine: 2,
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: isAdmin ? adminScreen[selectIndex] : memberScreen[selectIndex],
        ));
  }
}
