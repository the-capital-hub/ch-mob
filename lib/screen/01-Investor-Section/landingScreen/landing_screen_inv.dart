import 'package:capitalhub_crm/controller/homeController/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../exploreScreen/explore_screen_inv.dart';
import '../homeScreen/home_screen_inv.dart';
import '../profileScreen/profile_screen_inv.dart';
import '../syndicatesScreen/syndicates_screen_inv.dart';


class LandingScreenInvestor extends StatefulWidget {
  const LandingScreenInvestor({
    super.key,
  });

  @override
  State<LandingScreenInvestor> createState() => _LandingScreenInvestorState();
}

class _LandingScreenInvestorState extends State<LandingScreenInvestor> {
  HomeController homeController = Get.put(HomeController());
  List icons = [
    Icons.home,
    Icons.explore,
    Icons.schedule,
    Icons.groups,
    Icons.person,
  ];
  List title = ["Home", "Explore", "My Schedule", "Syndicates", "Profile"];
  List screen = [
    const HomeScreenInvestor(),
    const ExploreScreenInvestor(),
    const ExploreScreenInvestor(),
    const SyndicatesScreenInvestor(),
    const ProfileScreenInvestor()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: AppColors.blackCard,
              spreadRadius: 3,
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
                width: 55,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[index],
                      size: 24,
                      color: homeController.selectIndex == index
                          ? AppColors.primaryInvestor
                          : AppColors.whiteCard,
                    ),
                    const SizedBox(height: 2),
                    TextWidget(
                      text: title[index],
                      textSize: 10,
                      color: homeController.selectIndex == index
                          ? AppColors.primaryInvestor
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