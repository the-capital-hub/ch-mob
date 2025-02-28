import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/community_events_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityHomeScreen/community_home_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPeopleScreen/community_people_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsScreen/community_products_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityUpdateSettingsScreen/community_update_settings_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/createCommunityAllScreens/createCommunityOverScreen/create_community_over_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/myCommunityScreen/my_community_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communitySettingsScreen/community_settings_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
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
  int selectIndex = 0;

  
  List icons = [
   PngAssetPath.homeIcon,
     PngAssetPath.categoryIcon,
     PngAssetPath.meetingIcon,
     PngAssetPath.teamIcon,


    PngAssetPath.exploreIcon
    // PngAssetPath.userIcon,
  ];
  List title = ["Home", "Products", "Events", "People", "Settings"];
  List screen = [
    CommunityHomeScreen(),
    CommunityProductsScreen(),
    CommunityEventsScreen(),
    CommunityPeopleScreen(),
    CommunityUpdateSettingsScreen()
  ];
   @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      aboutCommunity.getAboutCommunity().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        
        });
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child:Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.black,
          leading: 
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              radius: 20,
              foregroundImage: NetworkImage(communityLogo),
            ),
          ),
      
          title: 
          // aboutCommunity.aboutCommunityList.isEmpty
          //       ? CircularProgressIndicator():
          TextWidget(
            text: communityName,
            // aboutCommunity.aboutCommunityList[0].community.name, 
            textSize: 16),
          actions: [
            IconButton(onPressed: (){Get.to(() =>  const HomeScreen());}, icon:  Icon(Icons.swap_horizontal_circle_sharp,color: AppColors.white,size: 30,))
          ],
        ),
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColors.blackCard,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: AppColors.white12,
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            icons.length,
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
                                      icons[index],
                                      color: selectIndex == index
                          ? AppColors.primary
                          : AppColors.whiteCard,
                                      height: 22,
                                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      text: title[index],
                      textSize: 10,
                      color: selectIndex == index
                          ? AppColors.primary
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
      body: screen[selectIndex],
    )
    );
  }
}