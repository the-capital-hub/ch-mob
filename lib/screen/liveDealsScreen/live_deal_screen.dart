import 'package:capitalhub_crm/controller/liveDealsController/live_deals_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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

class _LiveDealScreenState extends State<LiveDealScreen> {
  LiveDealsController liveDealsController = Get.put(LiveDealsController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      liveDealsController.getLiveDeals();
    });
    super.initState();
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
                                                        const TextWidget(
                                                            text: "300",
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
                                                      const TextWidget(
                                                          text: "bengaluru",
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
                                      height: 70,
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
                                  Row(
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
                                                  .founderId!));
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
