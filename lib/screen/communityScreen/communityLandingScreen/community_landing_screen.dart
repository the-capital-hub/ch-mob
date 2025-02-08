import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityHomeScreen/community_home_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPeopleScreen/community_people_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsScreen/community_products_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/create_community_over_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/my_community_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';

class CommunityLandingScreen extends StatefulWidget {
  const CommunityLandingScreen({super.key});

  @override
  State<CommunityLandingScreen> createState() => _CommunityLandingScreenState();
}

class _CommunityLandingScreenState extends State<CommunityLandingScreen> {
  
  
  int selectIndex = 0;
  List icons = [
   PngAssetPath.homeIcon,
     PngAssetPath.categoryIcon,
     PngAssetPath.meetingIcon,
     PngAssetPath.teamIcon,
    
    PngAssetPath.userIcon,
  ];
  List title = ["Home", "Products", "Events", "People", "Profile"];
  List screen = [
    CommunityHomeScreen(),
    CommunityProductsScreen(),
    
    MyCommunityScreen(),
    CommunityPeopleScreen(),
    MyCommunityScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child:Scaffold(
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