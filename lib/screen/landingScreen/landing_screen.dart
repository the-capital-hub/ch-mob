import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:capitalhub_crm/controller/notificationController/notification_controller.dart';
import 'package:capitalhub_crm/screen/Auth-Process/authScreen/signupInfoScreens/signup_info_page.dart';
import 'package:capitalhub_crm/screen/communityScreen/myCommunityScreen/my_community_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../controller/profileController/profile_controller.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../widget/textwidget/text_widget.dart';
import '../chatScreen/group_screen.dart';
import '../createPostScreen/create_post_screen.dart';
import '../homeScreen/home_screen.dart';
import '../oneLinkScreen/one_link_screen.dart';
import '../profileScreen/profile_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({
    super.key,
  });

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  HomeController homeController = Get.put(HomeController());
  ProfileController profileController = Get.put(ProfileController());
  NotificaitonController notificaitonController =
      Get.put(NotificaitonController());
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notificaitonController.getNotificationCount().then((val) {
        {
          if (notificaitonController.isRequiredFieldsExist == false) {
            Get.offAll(const SignupInfoScreen());
          }
        }
      });
    });
  }

  List icons = [
    Icons.home,
    Icons.link,
    Icons.add_box,
    Icons.groups,
    Icons.person,
  ];
  List title = ["Home", "One link", "Post", "Community", "Profile"];
  List screen = [
    const HomeScreen(),
    const OneLinkScreeen(),
     CreatePostScreen(),
    // const CommunityMemberScreen(),
    const MyCommunityScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
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
                homeController.selectIndex = index;
                setState(() {});
              },
              child: SizedBox(
                width: Get.width/5-6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      size: 24,
                      color: homeController.selectIndex == index
                          ? AppColors.primary
                          : AppColors.whiteCard,
                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      text: title[index],
                      textSize: 10,
                      color: homeController.selectIndex == index
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
      body: screen[homeController.selectIndex],
    );
  }

  // int currentTab() => widget.navigationShell.currentIndex;

  // void _goBranch(int index) {
  //   widget.navigationShell.goBranch(
  //     index,
  //     initialLocation: index == widget.navigationShell.currentIndex,
  //   );
  // }
}
