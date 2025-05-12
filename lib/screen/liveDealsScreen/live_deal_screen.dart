import 'package:capitalhub_crm/controller/liveDealsController/live_deals_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/liveDealsModel/live_deals_model.dart';
import '../../utils/constant/asset_constant.dart';
import '../../utils/getStore/get_store.dart';
import '../../utils/helper/helper.dart';
import '../../widget/buttons/button.dart';
import '../../widget/textwidget/text_widget.dart';
import '../publicProfileScreen/public_profile_screen.dart';

class LiveDealScreen extends StatefulWidget {
  const LiveDealScreen({super.key});

  @override
  State<LiveDealScreen> createState() => _LiveDealScreenState();
}

class _LiveDealScreenState extends State<LiveDealScreen>
    with TickerProviderStateMixin {
  LiveDealsController liveDealsController = Get.put(LiveDealsController());
  late TabController fundingTabController;
  late TabController tabController;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      fundingTabController = TabController(length: 2, vsync: this);
      tabController = TabController(length: 4, vsync: this);
      liveDealsController.getLiveDeals().then((v) {});
    });
    super.initState();
  }

  List<ChartData> _generateChartData(LiveDealData deal) {
    final funding = deal.fundingOverview;
    return [
      ChartData("Funding Ask", funding?.fundingAsk ?? 0.0),
      ChartData("Proposed Funding", funding?.proposedFunding ?? 0.0),
      ChartData("Raised Funds", funding?.raisedFunds ?? 0.0),
    ];
  }

  List<ChartData> _generateChartDataAllocation(LiveDealData deal) {
    return deal.allocationDetails?.map((allocation) {
          return ChartData(allocation.name ?? "Unknown",
              (allocation.percentage ?? 0).toDouble());
        }).toList() ??
        [];
  }

  @override
  void dispose() {
    fundingTabController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      drawer: const DrawerWidgetInvestor(),
      appBar: HelperAppBar.appbarHelper(
          title: "Live Deals", autoAction: true, hideBack: true),
      body: Obx(
        () => liveDealsController.isLoading.value
            ? Helper.pageLoading()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: liveDealsController.liveDealsList.isEmpty
                    ? const Center(
                        child: TextWidget(
                          text: "No Data Found",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : ListView.separated(
                        itemCount: liveDealsController.liveDealsList.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: AppColors.blackCard,
                              surfaceTintColor: AppColors.blackCard,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      liveDealsController
                                                          .liveDealsList[index]
                                                          .logo!))),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextWidget(
                                                    text:
                                                        "${liveDealsController.liveDealsList[index].company}",
                                                    textSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  // Icon(Icons.bookmark_border_outlined,
                                                  //     color: AppColors.white, size: 20)
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              TextWidget(
                                                text:
                                                    "${liveDealsController.liveDealsList[index].sector}",
                                                textSize: 12,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: AppColors.white38,
                                    height: 0,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 4),
                                    child: TextWidget(
                                        text: "Overview",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 2),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: AppColors.white12,
                                        surfaceTintColor: AppColors.white12,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const TextWidget(
                                                        text: "Employees",
                                                        textSize: 14),
                                                    const SizedBox(height: 4),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.groups_2,
                                                          size: 20,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                        const SizedBox(
                                                            width: 6),
                                                        TextWidget(
                                                            text:
                                                                "${liveDealsController.liveDealsList[index].noOfEmployees}",
                                                            textSize: 14)
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const TextWidget(
                                                      text: "Location",
                                                      textSize: 14),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 20,
                                                        color: AppColors.white,
                                                      ),
                                                      const SizedBox(width: 6),
                                                      TextWidget(
                                                          text:
                                                              "${liveDealsController.liveDealsList[index].location}",
                                                          textSize: 14)
                                                    ],
                                                  )
                                                ],
                                              ))
                                            ],
                                          ),
                                        )),
                                  ),
                                  if (liveDealsController.liveDealsList[index]
                                      .socialLinks!.isNotEmpty)
                                    SizedBox(
                                      height: 42,
                                      child: ListView.separated(
                                        itemCount: liveDealsController
                                            .liveDealsList[index]
                                            .socialLinks!
                                            .length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, ind) {
                                          return const SizedBox(width: 3);
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int ind) {
                                          return InkWell(
                                            onTap: () {
                                              Helper.launchUrl(
                                                  liveDealsController
                                                      .liveDealsList[index]
                                                      .socialLinks![ind]
                                                      .link!);
                                            },
                                            child: Card(
                                              color: AppColors.white12,
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Row(
                                                  children: [
                                                    Image.network(
                                                      liveDealsController
                                                          .liveDealsList[index]
                                                          .socialLinks![ind]
                                                          .logo!,
                                                      height: 25,
                                                    ),
                                                    const SizedBox(width: 8),
                                                    TextWidget(
                                                        text:
                                                            "${liveDealsController.liveDealsList[index].socialLinks![ind].name}",
                                                        textSize: 12)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    child: SizedBox(
                                      width: Get.width,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        color: AppColors.white12,
                                        surfaceTintColor: AppColors.white12,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const TextWidget(
                                                  text: "About the company :",
                                                  textSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              const SizedBox(height: 4),
                                              TextWidget(
                                                text:
                                                    "${liveDealsController.liveDealsList[index].description}",
                                                textSize: 12,
                                                maxLine: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (liveDealsController.liveDealsList[index]
                                      .interestedInvestors!.isNotEmpty)
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: TextWidget(
                                          text: "Interested Investors",
                                          textSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  if (liveDealsController.liveDealsList[index]
                                      .interestedInvestors!.isNotEmpty)
                                    SizedBox(
                                      height: 85,
                                      child: ListView.separated(
                                        itemCount: liveDealsController
                                            .liveDealsList[index]
                                            .interestedInvestors!
                                            .length,
                                        shrinkWrap: true,
                                        separatorBuilder: (context, ind) {
                                          return const SizedBox(width: 3);
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int ind) {
                                          return Card(
                                            color: AppColors.white12,
                                            surfaceTintColor: AppColors.white12,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                      radius: 24,
                                                      backgroundImage: NetworkImage(
                                                          liveDealsController
                                                              .liveDealsList[
                                                                  index]
                                                              .interestedInvestors![
                                                                  ind]
                                                              .profilePicture!)),
                                                  const SizedBox(width: 8),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextWidget(
                                                          text:
                                                              "${liveDealsController.liveDealsList[index].interestedInvestors![ind].firstName} ${liveDealsController.liveDealsList[index].interestedInvestors![ind].lastName}",
                                                          textSize: 14),
                                                      const SizedBox(height: 2),
                                                      TextWidget(
                                                          text:
                                                              "${liveDealsController.liveDealsList[index].interestedInvestors![ind].designation}",
                                                          textSize: 12),
                                                      const SizedBox(height: 2),
                                                      TextWidget(
                                                          text:
                                                              "${liveDealsController.liveDealsList[index].interestedInvestors![ind].proposedInvestment}",
                                                          textSize: 12),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 6),
                                    child: TextWidget(
                                        text: "Revenue Statistics",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        sqaureCard(
                                            img: PngAssetPath.valuationIcon,
                                            subTitle:
                                                "${liveDealsController.liveDealsList[index].revenueStatistics!.maximumTicketsSize}",
                                            title: "Maximum Tickets Size"),
                                        sqaureCard(
                                            img: PngAssetPath.fundingAskIcon,
                                            subTitle:
                                                "${liveDealsController.liveDealsList[index].revenueStatistics!.seedRound}",
                                            title: "Seed Round"),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    child: TextWidget(
                                        text: "Current Funding",
                                        textSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        sqaureCard(
                                            img: PngAssetPath.fundingAskIcon,
                                            subTitle:
                                                "${liveDealsController.liveDealsList[index].currentFunding!.minimumTicketsSize}",
                                            title: "Min. Tickets"),
                                        sqaureCard(
                                            img: PngAssetPath.valuationIcon,
                                            subTitle:
                                                "${liveDealsController.liveDealsList[index].currentFunding!.maximumTicketsSize}",
                                            title: "Max. Tickets"),
                                        sqaureCard(
                                            img: PngAssetPath.fundingRaisedIcon,
                                            subTitle:
                                                "${liveDealsController.liveDealsList[index].currentFunding!.seedRound}",
                                            title: "Seed Round"),
                                      ],
                                    ),
                                  ),
                                  sizedTextfield,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Column(
                                      children: [
                                        Center(
                                            child: TextWidget(
                                                text:
                                                    "${liveDealsController.liveDealsList[index].company}",
                                                align: TextAlign.center,
                                                color: AppColors.green,
                                                maxLine: 3,
                                                fontWeight: FontWeight.w500,
                                                textSize: 18)),
                                        sizedTextfield,
                                        Container(
                                            width: Get.width,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                            decoration: BoxDecoration(
                                                color: AppColors.green700
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: TextWidget(
                                                text:
                                                    "Total Proposed Funding: ₹${liveDealsController.liveDealsList[index].fundingOverview!.proposedFunding}",
                                                textSize: 16,
                                                align: TextAlign.center,
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w500)),
                                        sizedTextfield,
                                        Card(
                                            color: AppColors.white12,
                                            surfaceTintColor: AppColors.white12,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: "Funding Details",
                                                    textSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TextWidget(
                                                      text: "Funding Ask:",
                                                      textSize: 14,
                                                      color: AppColors.grey),
                                                  const SizedBox(height: 4),
                                                  TextWidget(
                                                      text:
                                                          "₹${liveDealsController.liveDealsList[index].fundingOverview!.fundingAsk}",
                                                      textSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                  TabBar(
                                                    controller:
                                                        fundingTabController,
                                                    indicator: BoxDecoration(
                                                      color: AppColors
                                                          .primaryInvestor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                    ),
                                                    indicatorPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 6,
                                                            horizontal: 6),
                                                    indicatorSize:
                                                        TabBarIndicatorSize.tab,
                                                    labelColor:
                                                        AppColors.blackCard,
                                                    dividerColor:
                                                        AppColors.transparent,
                                                    dividerHeight: 0,
                                                    unselectedLabelColor:
                                                        AppColors.whiteShade,
                                                    labelPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 16),
                                                    tabs: const [
                                                      Tab(text: "Overview"),
                                                      Tab(text: "Allocation"),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 250,
                                                    child: TabBarView(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      controller:
                                                          fundingTabController,
                                                      children: [
                                                        SfCircularChart(
                                                          margin:
                                                              EdgeInsets.zero,
                                                          legend: const Legend(
                                                            isVisible: true,
                                                            position:
                                                                LegendPosition
                                                                    .bottom,
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          tooltipBehavior:
                                                              TooltipBehavior(
                                                                  enable:
                                                                      true), // Enables tooltips
                                                          series: <CircularSeries>[
                                                            DoughnutSeries<
                                                                ChartData,
                                                                String>(
                                                              dataSource: _generateChartData(
                                                                  liveDealsController
                                                                          .liveDealsList[
                                                                      index]),
                                                              xValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.label,
                                                              yValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.value,
                                                              innerRadius:
                                                                  '50%',
                                                              dataLabelSettings:
                                                                  const DataLabelSettings(
                                                                isVisible: true,
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              enableTooltip:
                                                                  true,
                                                              animationDuration:
                                                                  1500,
                                                              onPointTap:
                                                                  (ChartPointDetails
                                                                      details) {
                                                                setState(() {
                                                                  _selectedIndex =
                                                                      details
                                                                          .pointIndex;
                                                                });
                                                              },
                                                              selectionBehavior:
                                                                  SelectionBehavior(
                                                                enable: true,
                                                                selectedColor:
                                                                    AppColors
                                                                        .green700,
                                                                unselectedOpacity:
                                                                    0.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SfCircularChart(
                                                          margin:
                                                              EdgeInsets.zero,
                                                          legend: const Legend(
                                                            isVisible: true,
                                                            position:
                                                                LegendPosition
                                                                    .bottom,
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          tooltipBehavior:
                                                              TooltipBehavior(
                                                                  enable:
                                                                      true), // Enables tooltips
                                                          series: <CircularSeries>[
                                                            DoughnutSeries<
                                                                ChartData,
                                                                String>(
                                                              dataSource: _generateChartDataAllocation(
                                                                  liveDealsController
                                                                          .liveDealsList[
                                                                      index]),
                                                              xValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.label,
                                                              yValueMapper:
                                                                  (ChartData data,
                                                                          _) =>
                                                                      data.value,
                                                              innerRadius:
                                                                  '55%',
                                                              dataLabelSettings:
                                                                  const DataLabelSettings(
                                                                isVisible: true,
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              enableTooltip:
                                                                  true,
                                                              animationDuration:
                                                                  1500,
                                                              onPointTap:
                                                                  (ChartPointDetails
                                                                      details) {
                                                                setState(() {
                                                                  _selectedIndex =
                                                                      details
                                                                          .pointIndex;
                                                                });
                                                              },
                                                              selectionBehavior:
                                                                  SelectionBehavior(
                                                                enable: true,
                                                                selectedColor:
                                                                    AppColors
                                                                        .green700,
                                                                unselectedOpacity:
                                                                    0.5,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        sizedTextfield,
                                        Card(
                                            color: AppColors.white12,
                                            surfaceTintColor: AppColors.white12,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: "Pitch & Founder",
                                                    textSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            image: DecorationImage(
                                                                image: NetworkImage(liveDealsController
                                                                    .liveDealsList[
                                                                        index]
                                                                    .pitchRecordings!
                                                                    .fileUrl!),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Helper.launchUrl(
                                                              liveDealsController
                                                                  .liveDealsList[
                                                                      index]
                                                                  .pitchRecordings!
                                                                  .videoUrl!);
                                                        },
                                                        child: Container(
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .black54,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .play_circle,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  size: 40),
                                                              const SizedBox(
                                                                  width: 8),
                                                              const TextWidget(
                                                                  text:
                                                                      "Watch Pitch Recording",
                                                                  textSize: 14),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white12,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${liveDealsController.liveDealsList[index].founder!.profilePicture}"),
                                                            ),
                                                            const SizedBox(
                                                                width: 12),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                TextWidget(
                                                                  text:
                                                                      "${liveDealsController.liveDealsList[index].founder!.firstName} ${liveDealsController.liveDealsList[index].founder!.lastName}",
                                                                  textSize: 14,
                                                                ),
                                                                TextWidget(
                                                                    text:
                                                                        "${liveDealsController.liveDealsList[index].founder!.designation}",
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                    textSize:
                                                                        12),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextWidget(
                                                            text:
                                                                "${liveDealsController.liveDealsList[index].pitchRecordings!.userMessage}",
                                                            maxLine: 10,
                                                            textSize: 12)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        sizedTextfield,
                                        Card(
                                            color: AppColors.white12,
                                            surfaceTintColor: AppColors.white12,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text:
                                                        "Documents and Pitch day",
                                                    textSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  AppButton.primaryButton(
                                                      onButtonPressed: () {
                                                        Helper.launchUrl(
                                                            liveDealsController
                                                                .liveDealsList[
                                                                    index]
                                                                .upcomingPitchDay!
                                                                .link!);
                                                      },
                                                      borderRadius: 12,
                                                      title:
                                                          "Download Pitch Deck"),
                                                  const SizedBox(height: 8),
                                                  TextWidget(
                                                    text: "Pitch Day Details",
                                                    textSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.white12,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .calendar_month,
                                                                color: AppColors
                                                                    .primaryInvestor,
                                                                size: 20),
                                                            const SizedBox(
                                                                width: 8),
                                                            TextWidget(
                                                                text:
                                                                    "${liveDealsController.liveDealsList[index].upcomingPitchDay!.date!}",
                                                                textSize: 14)
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .alarm_outlined,
                                                                color: AppColors
                                                                    .primaryInvestor,
                                                                size: 20),
                                                            const SizedBox(
                                                                width: 8),
                                                            TextWidget(
                                                                text:
                                                                    "${liveDealsController.liveDealsList[index].upcomingPitchDay!.date!} - ${liveDealsController.liveDealsList[index].upcomingPitchDay!.date!}",
                                                                textSize: 14)
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        TextWidget(
                                                            text:
                                                                "${liveDealsController.liveDealsList[index].upcomingPitchDay!.description!}",
                                                            maxLine: 10,
                                                            textSize: 12),
                                                        const SizedBox(
                                                            height: 8),
                                                        AppButton.primaryButton(
                                                            onButtonPressed:
                                                                () {
                                                              Helper.launchUrl(
                                                                  liveDealsController
                                                                      .liveDealsList[
                                                                          index]
                                                                      .upcomingPitchDay!
                                                                      .link!);
                                                            },
                                                            borderRadius: 12,
                                                            title:
                                                                "Register Now"),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        TabBar(
                                          controller: tabController,
                                          indicator: BoxDecoration(
                                            color: AppColors.primaryInvestor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          indicatorPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 6, horizontal: 6),
                                          indicatorSize:
                                              TabBarIndicatorSize.tab,
                                          isScrollable: true,
                                          labelColor: AppColors.blackCard,
                                          dividerColor: AppColors.transparent,
                                          dividerHeight: 0,
                                          tabAlignment: TabAlignment.start,
                                          unselectedLabelColor:
                                              AppColors.whiteShade,
                                          labelPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                          tabs: const [
                                            Tab(text: "Heighlights"),
                                            Tab(text: "Documents"),
                                            Tab(text: "Product Showcase"),
                                            Tab(text: "About Founder"),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 200,
                                          child: TabBarView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            controller: tabController,
                                            children: [
                                              heighlists(index),
                                              documentation(index),
                                              productshowcase(index),
                                              aboutFounder(index),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        bottom: 12,
                                        top: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: AppButton.primaryButton(
                                                borderRadius: 12,
                                                height: 40,
                                                onButtonPressed: () {
                                                  if (liveDealsController
                                                          .isButtonLoading
                                                          .value ==
                                                      false) {
                                                    liveDealsController
                                                        .intrestedUnintrestedDeal(
                                                      id: liveDealsController
                                                          .liveDealsList[index]
                                                          .liveDealId!,
                                                    )
                                                        .then((val) {
                                                      if (val) {
                                                        if (liveDealsController
                                                                .liveDealsList[
                                                                    index]
                                                                .myInterest ==
                                                            "Interested") {
                                                          liveDealsController
                                                                  .liveDealsList[
                                                                      index]
                                                                  .myInterest =
                                                              "Uninterest";
                                                        } else {
                                                          liveDealsController
                                                                  .liveDealsList[
                                                                      index]
                                                                  .myInterest =
                                                              "Interested";
                                                        }
                                                        setState(() {});
                                                      }
                                                    });
                                                  }
                                                },
                                                title: liveDealsController
                                                    .liveDealsList[index]
                                                    .myInterest!)),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child: AppButton.primaryButton(
                                                borderRadius: 12,
                                                height: 40,
                                                onButtonPressed: () {
                                                  if (liveDealsController
                                                          .liveDealsList[index]
                                                          .oneLinkRequestStatus ==
                                                      "Request for OneLink") {
                                                    liveDealsController
                                                        .onelinkSent(
                                                            id: liveDealsController
                                                                .liveDealsList[
                                                                    index]
                                                                .startupId!)
                                                        .then((val) {
                                                      if (val) {
                                                        liveDealsController
                                                                .liveDealsList[
                                                                    index]
                                                                .oneLinkRequestStatus =
                                                            "pending";
                                                      }
                                                    });
                                                  }
                                                },
                                                title: liveDealsController
                                                    .liveDealsList[index]
                                                    .oneLinkRequestStatus!
                                                    .capitalizeFirst!))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60),
                                    child: AppButton.outlineButton(
                                        onButtonPressed: () {
                                          Get.to(() => PublicProfileScreen(
                                              id: liveDealsController
                                                  .liveDealsList[index]
                                                  .founder!
                                                  .id!));
                                        },
                                        borderColor: GetStoreData.getStore
                                                .read('isInvestor')
                                            ? AppColors.primaryInvestor
                                            : AppColors.primary,
                                        borderRadius: 12,
                                        height: 40,
                                        title: "Connect With The Founder"),
                                  ),
                                  sizedTextfield,
                                ],
                              ));
                        },
                      )),
      ),
    );
  }

  Widget heighlists(index) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
      ),
      shrinkWrap: true,
      itemCount: liveDealsController.liveDealsList[index].highlights!.length,
      itemBuilder: (BuildContext context, int ind) {
        return Card(
          color: AppColors.white12,
          surfaceTintColor: AppColors.white12,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: AppColors.whiteCard,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        text:
                            "${liveDealsController.liveDealsList[index].highlights![ind].key}",
                        textSize: 12,
                      ),
                      TextWidget(
                        text:
                            "${liveDealsController.liveDealsList[index].highlights![ind].value}",
                        textSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget documentation(index) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: liveDealsController.liveDealsList[index].documents!.length,
      itemBuilder: (BuildContext context, int ind) {
        return InkWell(
          onTap: () {
            Helper.launchUrl(liveDealsController
                .liveDealsList[index].documents![ind].fileUrl!);
          },
          child: Card(
            color: AppColors.white12,
            surfaceTintColor: AppColors.white12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  Icon(
                    Icons.attach_file_outlined,
                    color: AppColors.whiteCard,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text:
                              "${liveDealsController.liveDealsList[index].documents![ind].fileName}",
                          textSize: 12,
                        ),
                        TextWidget(
                          text:
                              "${liveDealsController.liveDealsList[index].documents![ind].folderName}",
                          textSize: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget productshowcase(index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextWidget(
              text:
                  "${liveDealsController.liveDealsList[index].productDescription}",
              textSize: 12,
              maxLine: 5),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 110,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:
                liveDealsController.liveDealsList[index].productImages!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int ind) {
              return Container(
                  height: 115,width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(liveDealsController
                              .liveDealsList[index].productImages![ind]))));
            },
          ),
        ),
      ],
    );
  }

  Widget aboutFounder(index) {
    return Column(
      children: [
        Card(
          color: AppColors.white12,
          surfaceTintColor: AppColors.white12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        "${liveDealsController.liveDealsList[index].founder!.profilePicture}")),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text:
                            "${liveDealsController.liveDealsList[index].founder!.firstName} ${liveDealsController.liveDealsList[index].founder!.lastName} ",
                        textSize: 14),
                    const SizedBox(height: 2),
                    TextWidget(
                        text:
                            "${liveDealsController.liveDealsList[index].founder!.designation}",
                        textSize: 12),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextWidget(
              text: "${liveDealsController.liveDealsList[index].founder!.bio}",
              textSize: 12,
              maxLine: 6),
        ),
      ],
    );
  }

  sqaureCard(
      {required String img, required String title, required String subTitle}) {
    return Expanded(
      child: Card(
        color: AppColors.white12,
        surfaceTintColor: AppColors.white12,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                img,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: TextWidget(
                        text: title,
                        align: TextAlign.center,
                        maxLine: 2,
                        fontWeight: FontWeight.w500,
                        textSize: 12),
                  ),
                ],
              ),
              TextWidget(text: subTitle, textSize: 12)
            ],
          ),
        ),
      ),
    );
  }
}

int? _selectedIndex;
final List<ChartData> _chartData = [
  ChartData('Blue', 40),
  ChartData('Green', 30),
  ChartData('Red', 30),
];

class ChartData {
  final String label;
  final num value;

  ChartData(this.label, this.value);
}
