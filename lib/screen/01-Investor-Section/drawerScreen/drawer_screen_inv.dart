import 'package:capitalhub_crm/screen/01-Investor-Section/exploreScreen/explore_screen_inv.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/syndicatesScreen/syndicates_screen_inv.dart';
import 'package:capitalhub_crm/screen/logoutScreen/logout_Screen.dart';
import 'package:capitalhub_crm/screen/manageAccountScreen/manage_account_Screen.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../liveDealsScreen/live_deal_screen.dart';
import '../myStatrupScreen/my_startup_screen_inv.dart';

class DrawerWidgetInvestor extends StatefulWidget {
  const DrawerWidgetInvestor({super.key});

  @override
  State<DrawerWidgetInvestor> createState() => _DrawerWidgetInvestorState();
}

class _DrawerWidgetInvestorState extends State<DrawerWidgetInvestor> {
  // final ProfileController profileController = Get.put(ProfileController());

  // final LogoutDialog _logout = LogoutDialog();
  List<String> items = [
    "Home",
    "Explore",
    "My Startups",
    "Syndicates",
    "Live Deals",
    "My Schedule",
    "Saved posts",
    "Log Out",
  ];
  List icons = [
    PngAssetPath.homeIcon,
    PngAssetPath.exploreIcon,
    PngAssetPath.mystartupIcon,
    PngAssetPath.teamIcon,
    PngAssetPath.liveDealIcon,
    PngAssetPath.myscheduleIcon,
    PngAssetPath.saveIcon,
    PngAssetPath.logoutIcon,
  ];

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
                                radius: 28,
                                backgroundColor: Colors.green.shade600,
                                child: const CircleAvatar(
                                  radius: 26,
                                  backgroundImage: NetworkImage(
                                      'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text: "Pramod",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500),
                                  TextWidget(
                                      text: "Pramodbadiger@gmail.com",
                                      textSize: 12),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedTextfield,
                    Divider(
                      color: AppColors.white54,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: items.length,
                      padding: const EdgeInsets.only(
                        top: 0,
                        bottom: 10,
                        right: 16,
                        left: 8,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          if (index == 0) {
                            Get.to(() => const LandingScreenInvestor());
                          } else if (index == 1) {
                            Get.to(() => const ExploreScreenInvestor());
                          } else if (index == 2) {
                            Get.to(() => const MyStartupScreenInvestor());
                          } else if (index == 3) {
                            Get.to(() => const SyndicatesScreenInvestor());
                          } else if (index == 4) {
                            Get.to(() => const LiveDealScreen());
                          } else if (index == 5) {
                            // Get.to(() => const MyscheduleScreenInvestor());
                          } else if (index == 6) {
                            // Get.to(() => const SavedPostScreen());
                          } else if (index == 7) {
                            Get.to(() => const LogoutScreen());
                          }

                          //else if (index == 1) {
                          //   Get.to(() => const BookingScreen());
                          // } else if (index == 2) {
                          //   Get.to(() => const HomeScreenTransport());
                          // } else if (index == 3) {
                          //   Get.to(() => const AccountScreen());
                          // } else if (index == 4) {
                          //   Get.to(() => const HelpScreen());
                          // }
                          // Get.to(() => profileController.onTapList[index]);
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
                                  width: 16,
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
                      ),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 4);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        color: AppColors.blackCard,
                        surfaceTintColor: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                              ),
                              const SizedBox(height: 8),
                              const TextWidget(
                                text: "Pramod Badiger",
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(height: 3),
                              const TextWidget(
                                  text: "Pramodbadiger@gmail.com",
                                  textSize: 12),
                              const SizedBox(height: 3),
                              const TextWidget(
                                  text: "Founder & CEO of capital Hub",
                                  textSize: 12),
                              const SizedBox(height: 8),
                              AppButton.primaryButton(
                                  onButtonPressed: () {},
                                  height: 38,
                                  bgColor: AppColors.primaryInvestor,
                                  textColor: Colors.black,
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
}
