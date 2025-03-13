import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddNewProductScreen/community_add_new_product_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/community_events_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/community_meetings_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityPriorityDMsScreen/community_priority_dms_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsScreen/community_products_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/community_webinars_screen.dart';
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
      setState(() {}); // Rebuild when tab index changes
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAdmin)
                Row(
                  children: [
                    Expanded(
                      child: AppButton.primaryButton(
                          onButtonPressed: () {
                            Get.to(() => const AddNewProductScreen());
                          },
                          title: "Add New Product"),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: AppButton.primaryButton(
                          onButtonPressed: () {
                            Get.to(() => const CommunityAddServiceScreen());
                          },
                          title: "Add New Service"),
                    ),
                  ],
                ),
              // if(isAdmin)
              // SizedBox(height: 12,),
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
                        borderRadius:
                            BorderRadius.circular(5), // Rounded corners
                      ),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 2.0, vertical: 5.0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (val) {},
                      // tabs:  [

                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Tab(text: "Products"),
                      //   ),
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Tab(text: "Priority DMs"),
                      //   ),
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Tab(text: "Meetings"),
                      //   ),
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Tab(text: "Events"),
                      //   ),
                      //   Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8),
                      //     child: Tab(text: "Webinars"),
                      //   ),
                      // ],
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 0
                                  ? null // Selected tab will not have background color
                                  : AppColors
                                      .white12, // Grey background for unselected tabs
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11.0),
                              child: Text("Products"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 1
                                  ? null
                                  : AppColors
                                      .white12, // Grey background for unselected tabs
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11),
                              child: Text("Priority DMs"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 2
                                  ? null
                                  : AppColors
                                      .white12, // Grey background for unselected tabs
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11),
                              child: Text("Meetings"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 3
                                  ? null
                                  : AppColors
                                      .white12, // Grey background for unselected tabs
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11),
                              child: Text("Events"),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _tabController.index == 4
                                  ? null
                                  : AppColors
                                      .white12, // Grey background for unselected tabs
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 11),
                              child: Text("Webinars"),
                            ),
                          ),
                        ),
                      ],
                      labelColor: GetStoreData.getStore.read('isInvestor')
                          ? AppColors.black
                          : AppColors.white, // Text color for selected tab
                      unselectedLabelColor:
                          AppColors.white, // Text color for unselected tab
                      unselectedLabelStyle:
                          const TextStyle(fontWeight: FontWeight.normal),
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const SizedBox(height: 12),

              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              //   child: TextWidget(
              //       text: "Startup Results",
              //       textSize: 16,
              //       fontWeight: FontWeight.w500),
              // ),
              Expanded(
                child:
                    // exploreController.isLoading.value
                    //     ? Helper.pageLoading()
                    //     :
                    TabBarView(
                        controller: _tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                      const CommunityProductsScreen(),
                      const CommunityPriorityDMsScreen(),
                      const CommunityMeetingsScreen(),
                      const CommunityEventsScreen(),
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
