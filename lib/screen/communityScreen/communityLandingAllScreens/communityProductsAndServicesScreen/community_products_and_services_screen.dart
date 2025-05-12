import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityProductsScreen/community_add_new_product_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityEventsScreen/community_events_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityMeetingsScreen/community_meetings_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityPriorityDMsScreen/community_priority_dms_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityProductsScreen/community_products_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityWebinarsScreen/community_webinars_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityProductsAndServicesScreen extends StatefulWidget {
  const CommunityProductsAndServicesScreen({super.key});

  @override
  State<CommunityProductsAndServicesScreen> createState() =>
      _CommunityProductsAndServicesScreenState();
}

class _CommunityProductsAndServicesScreenState
    extends State<CommunityProductsAndServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // exploreController.tabController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (isAdmin) ...[
              //   Row(
              //     children: [
                   
              //       Expanded(
              //         child: AppButton.primaryButton(
              //             onButtonPressed: () {
              //               addServiceIndex = 0;
              //               Get.to(() => CommunityAddServiceScreen(
              //                     isEdit: false,
              //                     isPriorityDM: false,
              //                     isMeeting: false,
              //                     isEvent: false,
              //                     isWebinar: false,
              //                   ));
              //             },
              //             title: "Add New Service"),
              //       ),
              //     ],
              //   ),
              //   const SizedBox(
              //     height: 12,
              //   ),
              // ],
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      controller: _tabController,
                      dividerHeight: 0,
                      indicator: BoxDecoration(
                        color: GetStoreData.getStore.read('isInvestor')
                            ? AppColors.primaryInvestor
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 8.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (val) {},
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 0
                                  ? null
                                  : AppColors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: TextWidget(text: "Products", textSize: 14),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 1
                                  ? null
                                  : AppColors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: TextWidget(
                                  text: "Priority DMs", textSize: 14),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 2
                                  ? null
                                  : AppColors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: TextWidget(text: "Meetings", textSize: 14),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 3
                                  ? null
                                  : AppColors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: TextWidget(text: "Events", textSize: 14),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 4
                                  ? null
                                  : AppColors.white12,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical:8),
                              child: TextWidget(text: "Webinars", textSize: 14),
                            ),
                          ),
                        ),
                      ],
                      labelColor: GetStoreData.getStore.read('isInvestor')
                          ? AppColors.black
                          : AppColors.white,
                      unselectedLabelColor: AppColors.white,
                      unselectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.normal),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      CommunityProductsScreen(),
                      CommunityPriorityDMsScreen(),
                      CommunityMeetingsScreen(),
                      CommunityEventsScreen(),
                      CommunityWebinarsScreen()
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
