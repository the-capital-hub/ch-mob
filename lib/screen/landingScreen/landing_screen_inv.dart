import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/screen/oneLinkScreen/one_link_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/notificationController/notification_controller.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/constant/asset_constant.dart';
import '../Auth-Process/authScreen/signupInfoScreens/signup_info_page.dart';
import '../communityScreen/exploreCommunityScreen/explore_community_screen.dart';
import '../createPostScreen/create_post_screen.dart';
import '../drawerScreen/NEW/menu_bottomsheet.dart';
import '../liveDealsScreen/live_deal_screen.dart';

// class LandingScreenInvestor extends StatefulWidget {
//   const LandingScreenInvestor({
//     super.key,
//   });

//   @override
//   State<LandingScreenInvestor> createState() => _LandingScreenInvestorState();
// }

// class _LandingScreenInvestorState extends State<LandingScreenInvestor> {
//   HomeController homeController = Get.put(HomeController());
//   NotificaitonController notificaitonController =
//       Get.put(NotificaitonController());
//   @override
//   void initState() {
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       notificaitonController.getNotificationCount().then((val) {
//         {
//           if (notificaitonController.isRequiredFieldsExist == false) {
//             Get.offAll(const SignupInfoScreen());
//           }
//         }
//       });
//     });
//   }

//   List icons = [
//     Icons.home,
//     Icons.link,
//     Icons.add_box,
//     Icons.groups,
//     Icons.person,
//   ];
//   List title = ["Home", "One link", "Post", "Community", "Profile"];
//   List screen = [
//     const HomeScreen(),
//     const OneLinkScreeen(),
//     CreatePostScreen(),
//     const MyCommunityScreen(),
//     const ProfileScreen()
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black,
//       resizeToAvoidBottomInset: false,
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
//         decoration: BoxDecoration(
//           color: AppColors.blackCard,
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(18), topRight: Radius.circular(18)),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.blackCard,
//               spreadRadius: 3,
//               blurRadius: 7,
//               offset: const Offset(0, 2), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: List.generate(
//             icons.length,
//             (index) => InkWell(
//               onTap: () {
//                 homeController.selectIndex = index;
//                 setState(() {});
//               },
//               child: SizedBox(
//                 width: Get.width/5-6,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       icons[index],
//                       size: 24,
//                       color: homeController.selectIndex == index
//                           ? AppColors.primaryInvestor
//                           : AppColors.whiteCard,
//                     ),
//                     const SizedBox(height: 2),
//                     TextWidget(
//                       text: title[index],
//                       textSize: 10,
//                       color: homeController.selectIndex == index
//                           ? AppColors.primaryInvestor
//                           : AppColors.whiteCard,
//                       maxLine: 2,
//                       align: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: screen[homeController.selectIndex],
//     );
//   }

//   // int currentTab() => widget.navigationShell.currentIndex;

//   // void _goBranch(int index) {
//   //   widget.navigationShell.goBranch(
//   //     index,
//   //     initialLocation: index == widget.navigationShell.currentIndex,
//   //   );
//   // }
// }

class LandingScreenInvestor extends StatefulWidget {
  const LandingScreenInvestor({super.key});

  @override
  State<LandingScreenInvestor> createState() => _LandingScreenInvestorState();
}

class _LandingScreenInvestorState extends State<LandingScreenInvestor> {
  int _selectedIndex = 1;

  final List<String> labels = [
    'Menu',
    'Home',
    'Onelink',
    "",
    'Live Deals',
    'Communities',
  ];

  final List<String> filledIcons = [
    PngAssetPath.menuFill,
    PngAssetPath.homeFill,
    PngAssetPath.onelinkFill,
    "", //create post
    PngAssetPath.liveDealsFill,
    PngAssetPath.communityFill,
  ];

  final List<String> outlinedIcons = [
    PngAssetPath.menu,
    PngAssetPath.home,
    PngAssetPath.onelink,
    "", //create post
    PngAssetPath.liveDeals,
    PngAssetPath.community,
  ];

  final List<Widget> pages = [
    const SizedBox(),
    const HomeScreen(),
    const OneLinkScreeen(),
    CreatePostScreen(),
    const LiveDealScreen(),
    const ExploreCommunityScreen(),
  ];
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

  void _onItemTapped(int index) {
    if (index == 0) {
      showMenuBottomSheet();
      return; // Do not set _selectedIndex for Menu
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(int index) {
    final bool isSelected = _selectedIndex == index;
    String icon = isSelected ? filledIcons[index] : outlinedIcons[index];
    final color = isSelected ? AppColors.primary : AppColors.whiteShade;

    return InkWell(
      splashColor: AppColors.transparent,
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(icon, height: 20, color: color),
          const SizedBox(height: 4),
          Text(labels[index],
              style: GoogleFonts.outfit(
                  textStyle: TextStyle(fontSize: 9, color: color)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              const SizedBox(width: 6),
              _buildNavItem(0),
              const SizedBox(width: 14),
              VerticalDivider(
                  color: AppColors.white54,
                  thickness: 1.3,
                  indent: 3,
                  endIndent: 3,
                  width: 0),
            ]),
            _buildNavItem(1),
            _buildNavItem(2),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                  _onItemTapped(3);
                  // Get.to(CreatePostScreen());
                },
                child: Image.asset(PngAssetPath.createPost)),
            _buildNavItem(4),
            _buildNavItem(5),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: _selectedIndex == 2 ? 40 : 0),
        child: pages[_selectedIndex],
      ),
    );
  }
}
