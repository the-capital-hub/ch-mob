import 'package:animate_do/animate_do.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/liveDealsScreen/live_deal_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/textwidget/text_widget.dart';

class StartupspvLandingScreen extends StatefulWidget {
  const StartupspvLandingScreen({super.key});

  @override
  State<StartupspvLandingScreen> createState() =>
      _StartupspvLandingScreenState();
}

class _StartupspvLandingScreenState extends State<StartupspvLandingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = [
    'Overview',
    'Live Deals',
    'Investors',
    'Pipeline',
    'Transactions',
  ];
  final RxInt selectedTabIndex = 0.obs;
  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.addListener(() {
        selectedTabIndex.value = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(String label, int index) {
    return Obx(() => Tab(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 50),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: selectedTabIndex.value == index
                        ? AppColors.primary
                        : AppColors.transparent,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: TextWidget(
                text: label,
                align: TextAlign.center,
                textSize: 14,
                fontWeight: FontWeight.w500,
                color: selectedTabIndex.value == index
                    ? AppColors.primary
                    : Colors.white,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidgetInvestor(),
      backgroundColor: AppColors.black,
      appBar: HelperAppBar.appbarHelper(title: "Startup SPV", hideBack: true),
      body: Column(
        children: [
          Obx(() => FlipInX(
                key: ValueKey(selectedTabIndex.value),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                  indicator: const BoxDecoration(),
                  tabs: List.generate(
                      _tabs.length, (index) => _buildTab(_tabs[index], index)),
                  dividerHeight: 0,
                  dividerColor: AppColors.transparent,
                  onTap: (index) {
                    selectedTabIndex.value = index;
                  },
                ),
              )),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SizedBox(),
              SizedBox(),
              // LiveDealScreen(),
              SizedBox(),
              SizedBox(),
              SizedBox(),
            ]),
          )
        ],
      ),
    );
  }
}
