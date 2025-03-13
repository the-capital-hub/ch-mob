import 'package:capitalhub_crm/screen/campaignsScreen/campaignsListScreen/campaigns_list_screen.dart';
import 'package:capitalhub_crm/screen/campaignsScreen/campaignsOutreachScreen/campaigns_outreach_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/campaignsController/campaigns_controller.dart';
import 'campaignsTempletScreen/campaigns_templet_screen.dart';

class CampaignLandingScreen extends StatefulWidget {
  const CampaignLandingScreen({super.key});

  @override
  State<CampaignLandingScreen> createState() => _CampaignLandingScreenState();
}

class _CampaignLandingScreenState extends State<CampaignLandingScreen>
    with SingleTickerProviderStateMixin {
  CampaignsController campaignsController = Get.put(CampaignsController());
  @override
  void initState() {
    super.initState();
    campaignsController.tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    campaignsController.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        drawer: const DrawerWidget(),
        appBar: HelperAppBar.appbarHelper(
            title: "Campaign", hideBack: true, autoAction: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: bgDec,
                child: TabBar(
                  controller: campaignsController.tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  indicatorPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.white,
                  dividerColor: AppColors.transparent,
                  dividerHeight: 0,
                  unselectedLabelColor: AppColors.whiteShade,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: "List"),
                    Tab(text: "Template"),
                    Tab(text: "Outreach"),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: campaignsController.tabController,
                  children: const [
                    CampaignsListScreen(),
                    CampaignsTempletScreen(),
                    CampaignsOutreachScreen()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
