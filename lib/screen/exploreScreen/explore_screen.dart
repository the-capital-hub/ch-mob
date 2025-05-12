import 'dart:developer';
import 'dart:ui';

import 'package:capitalhub_crm/controller/exploreController/explore_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/exploreScreen/ai_search_bottomsheet.dart';
import 'package:capitalhub_crm/screen/exploreScreen/filter_explore_screen.dart';
import 'package:capitalhub_crm/screen/exploreScreen/vc_profile.dart';
import 'package:capitalhub_crm/screen/publicProfileScreen/public_profile_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/campaignDilogue/add_list_investor_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/getStore/get_store.dart';
import '../../utils/helper/placeholder.dart';
import '../drawerScreen/drawer_screen_inv.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  ExploreController exploreController = Get.put(ExploreController());

  @override
  void initState() {
    super.initState();
    exploreController.selectedType = "startup";
    exploreController.tabController = TabController(length: 4, vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      exploreController.getExploreCollection();
    });
  }

  @override
  void dispose() {
    exploreController.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            backgroundColor: AppColors.transparent,
            drawer: GetStoreData.getStore.read('isInvestor')
                ? const DrawerWidgetInvestor()
                : const DrawerWidget(),
            appBar: HelperAppBar.appbarHelper(
                title: "Explore", hideBack: true, autoAction: true),
            body: Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MyCustomTextField.textField(
                    //     hintText: "Search",
                    //     controller: searchController,
                    //     borderRadius: 12,
                    //     prefixIcon: Icon(
                    //       Icons.search,
                    //       color: AppColors.white54,
                    //     )),
                    Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            controller: exploreController.tabController,
                            dividerHeight: 0,
                            indicator: BoxDecoration(
                              color: GetStoreData.getStore.read('isInvestor')
                                  ? AppColors.primaryInvestor
                                  : AppColors.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            indicatorPadding: const EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 5.0),
                            indicatorSize: TabBarIndicatorSize.tab,
                            onTap: (val) {
                              exploreController.cleaarFilter();
                              if (val == 0) {
                                exploreController.selectedType = "startup";
                                exploreController.getExploreCollection();
                              } else if (val == 1) {
                                exploreController.selectedType = "founder";
                                exploreController.getExploreCollection();
                              } else if (val == 2) {
                                selectedInvestorIds.clear();
                                exploreController.selectedType = "investor";
                                exploreController.getExploreCollection();
                              } else if (val == 3) {
                                selectedVcsIds.clear();
                                exploreController.selectedType = "vc";
                                exploreController.getExploreCollection();
                              }
                            },
                            tabs: const [
                              Tab(text: "Startup"),
                              Tab(text: "Founder"),
                              Tab(text: "Investors"),
                              Tab(text: "VCs"),
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
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            Get.to(() => const FilterExploreScreen());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.whiteCard),
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.all(2),
                              child: Icon(Icons.filter_alt_outlined,
                                  size: 20, color: AppColors.white)),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                    //   child: TextWidget(
                    //       text: "Startup Results",
                    //       textSize: 16,
                    //       fontWeight: FontWeight.w500),
                    // ),
                    Expanded(
                      child: exploreController.isLoading.value
                          ? ShimmerLoader.shimmerLoadingExplore()
                          : TabBarView(
                              controller: exploreController.tabController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                  startupTab(),
                                  founderTab(),
                                  investorTab(),
                                  vcsTab(),
                                ]),
                    ),
                  ],
                ),
              ),
            )));
  }

  startupTab() {
    return exploreController.startupExploreList.isEmpty
        ? const Center(
            child: TextWidget(
              text: "No Data Found",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        : ListView.separated(
            itemCount: exploreController.startupExploreList.length,
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
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(exploreController
                                          .startupExploreList[index].logo!))),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        "${exploreController.startupExploreList[index].company}",
                                    textSize: 15,
                                    maxLine: 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text:
                                        "${exploreController.startupExploreList[index].tagline}",
                                    textSize: 12,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text:
                                        "${exploreController.startupExploreList[index].location}${exploreController.startupExploreList[index].startedAtDate == "" ? "" : ", Founded in ${exploreController.startupExploreList[index].startedAtDate}"} ${exploreController.startupExploreList[index].lastFunding == "" ? "" : ", Last Funding in ${exploreController.startupExploreList[index].lastFunding}"}",
                                    textSize: 10,
                                    maxLine: 2,
                                    fontWeight: FontWeight.w300,
                                  )
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
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: SizedBox(
                          width: Get.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: AppColors.white12,
                            surfaceTintColor: AppColors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                      text: "About the company :",
                                      textSize: 14,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text:
                                        "${exploreController.startupExploreList[index].description}",
                                    textSize: 12,
                                    maxLine: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 6),
                        child: TextWidget(
                            text: "Market Size",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            sqaureCard(
                                img: PngAssetPath.tamIcon,
                                subTitle:
                                    "${exploreController.startupExploreList[index].tam}",
                                title: "TAM"),
                            sqaureCard(
                                img: PngAssetPath.samIcon,
                                subTitle:
                                    "${exploreController.startupExploreList[index].sam}",
                                title: "SAM"),
                            sqaureCard(
                                img: PngAssetPath.somIcon,
                                subTitle:
                                    "${exploreController.startupExploreList[index].som}",
                                title: "SOM"),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: TextWidget(
                            text: "Current Funding",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          sqaureCard(
                              img: PngAssetPath.fundingAskIcon,
                              subTitle:
                                  "${exploreController.startupExploreList[index].fundAsk}",
                              title: "Fund Ask"),
                          sqaureCard(
                              img: PngAssetPath.valuationIcon,
                              subTitle:
                                  "${exploreController.startupExploreList[index].valuation}",
                              title: "Valuation"),
                          sqaureCard(
                              img: PngAssetPath.fundingRaisedIcon,
                              subTitle:
                                  "${exploreController.startupExploreList[index].raisedFunds}",
                              title: "Funds raised"),
                        ],
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: TextWidget(
                            text: "Public Links",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 42,
                        child: ListView.separated(
                          itemCount: exploreController
                              .startupExploreList[index].socialLinks!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, ind) {
                            return const SizedBox(width: 3);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int ind) {
                            return InkWell(
                              onTap: () {
                                Helper.launchUrl(exploreController
                                    .startupExploreList[index]
                                    .socialLinks![ind]
                                    .link!);
                              },
                              child: Card(
                                color: AppColors.white12,
                                surfaceTintColor: AppColors.white12,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        exploreController
                                            .startupExploreList[index]
                                            .socialLinks![ind]
                                            .logo!,
                                        height: 25,
                                      ),
                                      const SizedBox(width: 8),
                                      TextWidget(
                                          text:
                                              "${exploreController.startupExploreList[index].socialLinks![ind].name}",
                                          textSize: 12)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      //   child: TextWidget(
                      //       text: "Feedback",
                      //       textSize: 16,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      // SizedBox(
                      //   height: 130,
                      //   child: ListView.separated(
                      //     itemCount: 5,
                      //     shrinkWrap: true,
                      //     separatorBuilder: (context, index) {
                      //       return const SizedBox(width: 3);
                      //     },
                      //     padding: const EdgeInsets.symmetric(horizontal: 6),
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Card(
                      //         color: AppColors.white12,
                      //         surfaceTintColor: AppColors.white12,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(12.0),
                      //           child: SizedBox(
                      //             width: Get.width / 2,
                      //             child: const Column(
                      //               children: [
                      //                 Row(
                      //                   children: [
                      //                     CircleAvatar(
                      //                       radius: 20,
                      //                       backgroundImage: NetworkImage(
                      //                           'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                      //                     ),
                      //                     SizedBox(width: 8),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         TextWidget(
                      //                             text: "Tom Holder", textSize: 14),
                      //                         SizedBox(height: 2),
                      //                         Row(
                      //                           children: [
                      //                             Icon(Icons.star,
                      //                                 color: Colors.amber, size: 16),
                      //                             TextWidget(
                      //                                 text: "4.5 (12)", textSize: 12)
                      //                           ],
                      //                         )
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //                 SizedBox(height: 4),
                      //                 TextWidget(
                      //                   text:
                      //                       "This is my first review and also every website and app working very good and there is not lag on website or app.",
                      //                   textSize: 12,
                      //                   maxLine: 3,
                      //                 )
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      //   child: TextWidget(
                      //       text: "Founding Team",
                      //       textSize: 16,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      // SizedBox(
                      //   height: 118,
                      //   child: ListView.separated(
                      //     itemCount: 5,
                      //     shrinkWrap: true,
                      //     separatorBuilder: (context, index) {
                      //       return const SizedBox(width: 3);
                      //     },
                      //     padding: const EdgeInsets.symmetric(horizontal: 6),
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Card(
                      //         color: AppColors.white12,
                      //         surfaceTintColor: AppColors.white12,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(12.0),
                      //           child: SizedBox(
                      //             width: Get.width / 2,
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 const Row(
                      //                   children: [
                      //                     CircleAvatar(
                      //                       radius: 20,
                      //                       backgroundImage: NetworkImage(
                      //                           'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg'),
                      //                     ),
                      //                     SizedBox(width: 8),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         TextWidget(
                      //                             text: "Abhishek Raj", textSize: 14),
                      //                         SizedBox(height: 2),
                      //                         TextWidget(
                      //                             text: "28 Years", textSize: 12)
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //                 const SizedBox(height: 8),
                      //                 Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     const Expanded(
                      //                       child: Column(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                         children: [
                      //                           TextWidget(
                      //                               text: "Designation",
                      //                               textSize: 13),
                      //                           SizedBox(height: 4),
                      //                           TextWidget(
                      //                               text: "CEO & Founder",
                      //                               textSize: 13),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                     Card(
                      //                       color: AppColors.primary,
                      //                       surfaceTintColor: AppColors.primary,
                      //                       shape: RoundedRectangleBorder(
                      //                           borderRadius:
                      //                               BorderRadius.circular(4)),
                      //                       child: const Padding(
                      //                         padding: EdgeInsets.symmetric(
                      //                             horizontal: 8.0, vertical: 4),
                      //                         child: TextWidget(
                      //                             text: "Connect now", textSize: 10),
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: TextWidget(
                            text: "Key Focusing Area",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: List.generate(
                              exploreController.startupExploreList[index]
                                  .keyFocus!.length, (ind) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: AppColors.white12,
                              surfaceTintColor: AppColors.white12,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: TextWidget(
                                    text: exploreController
                                        .startupExploreList[index]
                                        .keyFocus![ind],
                                    textSize: 14),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (GetStoreData.getStore.read('isInvestor'))
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                  child: AppButton.primaryButton(
                                      borderRadius: 12,
                                      height: 40,
                                      onButtonPressed: () {
                                        if (exploreController
                                                .isButtonLoading.value ==
                                            false) {
                                          exploreController
                                              .intrestedUnintrestedPost(
                                            id: exploreController
                                                .startupExploreList[index].id!,
                                          )
                                              .then((val) {
                                            if (val) {
                                              if (exploreController
                                                      .startupExploreList[index]
                                                      .myInterest ==
                                                  "Interested") {
                                                exploreController
                                                    .startupExploreList[index]
                                                    .myInterest = "Uninterest";
                                              } else {
                                                exploreController
                                                    .startupExploreList[index]
                                                    .myInterest = "Interested";
                                              }
                                              setState(() {});
                                            }
                                          });
                                        }
                                      },
                                      title: exploreController
                                          .startupExploreList[index]
                                          .myInterest!)),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: AppButton.primaryButton(
                                      borderRadius: 12,
                                      height: 40,
                                      onButtonPressed: () {
                                        if (exploreController
                                                .startupExploreList[index]
                                                .oneLinkRequestStatus ==
                                            "Request for OneLink") {
                                          Helper.loader(context);
                                          exploreController
                                              .onelinkSent(
                                                  id: exploreController
                                                      .startupExploreList[index]
                                                      .id!)
                                              .then((val) {
                                            if (val) {
                                              exploreController
                                                      .startupExploreList[index]
                                                      .oneLinkRequestStatus =
                                                  "pending";
                                              setState(() {});
                                            }
                                          });
                                        }
                                      },
                                      title: exploreController
                                          .startupExploreList[index]
                                          .oneLinkRequestStatus!
                                          .capitalizeFirst!))
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: AppButton.outlineButton(
                            onButtonPressed: () {
                              Get.to(() => PublicProfileScreen(
                                  id: exploreController
                                      .startupExploreList[index].founderId!));
                            },
                            borderColor:
                                GetStoreData.getStore.read('isInvestor')
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
          );
  }

  founderTab() {
    return exploreController.founderExploreList.isEmpty
        ? const Center(
            child: TextWidget(
              text: "No Data Found",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        : ListView.separated(
            itemCount: exploreController.founderExploreList.length,
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
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(exploreController
                                          .founderExploreList[index]
                                          .profilePicture!))),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextWidget(
                                        text:
                                            "${exploreController.founderExploreList[index].name}",
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
                                        "${exploreController.founderExploreList[index].designation}",
                                    textSize: 12,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text:
                                        "${exploreController.founderExploreList[index].company} | ${exploreController.founderExploreList[index].location} | Founded in ${exploreController.founderExploreList[index].startedAtDate} | Last funding in ${exploreController.founderExploreList[index].lastFunding}",
                                    textSize: 10,
                                    fontWeight: FontWeight.w300,
                                  )
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
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: AppColors.white12,
                          surfaceTintColor: AppColors.white12,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextWidget(
                                    text: "Bio :",
                                    textSize: 14,
                                    fontWeight: FontWeight.w500),
                                const SizedBox(height: 4),
                                TextWidget(
                                  text:
                                      "${exploreController.founderExploreList[index].bio}",
                                  textSize: 12,
                                  maxLine: 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 6),
                        child: TextWidget(
                            text: "Personal Information",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: "Company Name",
                              textSize: 12,
                              color: AppColors.grey,
                            ),
                            const SizedBox(height: 2),
                            TextWidget(
                                text:
                                    "${exploreController.founderExploreList[index].company}",
                                textSize: 13),
                            const SizedBox(height: 6),
                            if (exploreController.founderExploreList[index]
                                .education!.isNotEmpty)
                              TextWidget(
                                text: "Education",
                                textSize: 12,
                                color: AppColors.grey,
                              ),
                            if (exploreController.founderExploreList[index]
                                .education!.isNotEmpty)
                              const SizedBox(height: 2),
                            if (exploreController.founderExploreList[index]
                                .education!.isNotEmpty)
                              TextWidget(
                                  text:
                                      "${exploreController.founderExploreList[index].education}",
                                  textSize: 13),
                            const SizedBox(height: 6),
                            TextWidget(
                              text: "Experience",
                              textSize: 12,
                              color: AppColors.grey,
                            ),
                            const SizedBox(height: 2),
                            TextWidget(
                                text:
                                    "${exploreController.founderExploreList[index].experience}",
                                textSize: 13),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: TextWidget(
                            text: "Company Details",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(exploreController
                                          .founderExploreList[index]
                                          .companyLogo!))),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                        "${exploreController.founderExploreList[index].company}",
                                    maxLine: 3,
                                    textSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(height: 4),
                                  // TextWidget(
                                  //   text:
                                  //       "The Finance Company | Investment | Start Up",
                                  //   textSize: 12,
                                  // ),
                                  TextWidget(
                                    text:
                                        "${exploreController.founderExploreList[index].location}  Founded in ${exploreController.founderExploreList[index].startedAtDate}  Last Funding in ${exploreController.founderExploreList[index].lastFunding}",
                                    textSize: 10,
                                    maxLine: 3,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  const SizedBox(height: 4),
                                  TextWidget(
                                    text:
                                        "Stage of funding ${exploreController.founderExploreList[index].companyStage} Sector ${exploreController.founderExploreList[index].companySector}",
                                    textSize: 10,
                                    maxLine: 3,
                                    fontWeight: FontWeight.w300,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 6),
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: AppColors.white12,
                            surfaceTintColor: AppColors.white12,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                      text: "About :", textSize: 14),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextWidget(
                                    text:
                                        "${exploreController.founderExploreList[index].description}",
                                    textSize: 12,
                                    maxLine: 6,
                                  )
                                ],
                              ),
                            )),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: TextWidget(
                            text: "Public Links",
                            textSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 42,
                        child: ListView.separated(
                          itemCount: exploreController
                              .founderExploreList[index].socialLinks!.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, ind) {
                            return const SizedBox(width: 3);
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int ind) {
                            return InkWell(
                              onTap: () {
                                if (exploreController.founderExploreList[index]
                                        .socialLinks![ind].name ==
                                    "email") {
                                  Helper.launchMail(exploreController
                                      .founderExploreList[index]
                                      .socialLinks![ind]
                                      .link!);
                                } else {
                                  Helper.launchUrl(exploreController
                                      .founderExploreList[index]
                                      .socialLinks![ind]
                                      .link!);
                                }
                              },
                              child: Card(
                                color: AppColors.white12,
                                surfaceTintColor: AppColors.white12,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        exploreController
                                            .founderExploreList[index]
                                            .socialLinks![ind]
                                            .logo!,
                                        height: 25,
                                      ),
                                      const SizedBox(width: 8),
                                      TextWidget(
                                          text:
                                              "${exploreController.founderExploreList[index].socialLinks![ind].name}",
                                          textSize: 12)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: AppButton.outlineButton(
                            onButtonPressed: () {
                              Get.to(() => PublicProfileScreen(
                                  id: exploreController
                                      .founderExploreList[index].founderId!));
                            },
                            borderColor:
                                GetStoreData.getStore.read('isInvestor')
                                    ? AppColors.primaryInvestor
                                    : AppColors.primary,
                            borderRadius: 12,
                            height: 40,
                            title: "Connect with the Founder"),
                      ),
                      sizedTextfield,
                    ],
                  ));
            },
          );
  }

  bool isAllChecked = false;
  List<String> selectedInvestorIds = [];

  investorTab() {
    return exploreController.investorExploreList.isEmpty
        ? const Center(
            child: TextWidget(
              text: "No Data Found",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (GetStoreData.getStore.read('isInvestor') == false)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: isAllChecked,
                      onChanged: (value) {
                        setState(() {
                          isAllChecked = value!;
                          selectedInvestorIds.clear();

                          for (var investor
                              in exploreController.investorExploreList) {
                            investor.isChecked = isAllChecked;
                            if (isAllChecked) {
                              selectedInvestorIds.add(investor.investorId!);
                            }
                          }
                        });
                      },
                      side: BorderSide(color: AppColors.grey, width: 1.5),
                      activeColor: AppColors.primary,
                      checkColor: AppColors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    const TextWidget(
                      text: "Select All",
                      textSize: 12,
                    ),
                    const Spacer(),
                    selectedInvestorIds.isNotEmpty
                        ? InkWell(
                            onTap: () {
                              exploreController.getCampaignLists();
                              addInvestorPopup(
                                      context, selectedInvestorIds, true)
                                  .then((val) {
                                if (val) {
                                  selectedInvestorIds.clear();
                                  for (var investor in exploreController
                                      .investorExploreList) {
                                    investor.isChecked = false;
                                  }
                                  isAllChecked = false;
                                  setState(() {});
                                }
                              });
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(6)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: TextWidget(
                                    text:
                                        "+ ADD (${selectedInvestorIds.length})",
                                    textSize: 12,
                                    fontWeight: FontWeight.w500)),
                          )
                        : TextButton.icon(
                            onPressed: () {
                              showInvestorSearchSheet(context);
                            },
                            label: TextWidget(
                                text: "AI Search",
                                color: AppColors.whiteCard,
                                textSize: 12),
                            iconAlignment: IconAlignment.end,
                            icon: Icon(
                              Icons.person_search,
                              color: AppColors.whiteCard,
                              size: 18,
                            ),
                          ),
                  ],
                ),
              // if (GetStoreData.getStore.read('isInvestor') == false)
                // const SizedBox(height: 4),
              Expanded(
                child: ListView.separated(
                  itemCount: exploreController.investorExploreList.length,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                exploreController
                                                    .investorExploreList[index]
                                                    .profilePicture!))),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text:
                                              "${exploreController.investorExploreList[index].name}",
                                          textSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(height: 2),
                                        TextWidget(
                                          text:
                                              "${exploreController.investorExploreList[index].name}",
                                          textSize: 12,
                                        ),
                                        const SizedBox(height: 2),
                                        TextWidget(
                                          text:
                                              "${exploreController.investorExploreList[index].designation} of ${exploreController.investorExploreList[index].companyName}",
                                          textSize: 10,
                                          fontWeight: FontWeight.w300,
                                        )
                                      ],
                                    ),
                                  ),
                                  if (GetStoreData.getStore
                                          .read('isInvestor') ==
                                      false)
                                    Checkbox(
                                      value: exploreController
                                          .investorExploreList[index].isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          exploreController
                                              .investorExploreList[index]
                                              .isChecked = value!;
                                          if (value) {
                                            selectedInvestorIds.add(
                                                exploreController
                                                    .investorExploreList[index]
                                                    .investorId!);
                                          } else {
                                            selectedInvestorIds.remove(
                                                exploreController
                                                    .investorExploreList[index]
                                                    .investorId!);
                                          }
                                          isAllChecked =
                                              selectedInvestorIds.length ==
                                                  exploreController
                                                      .investorExploreList
                                                      .length;
                                        });
                                      },
                                      side: BorderSide(
                                          color: AppColors.grey, width: 1.5),
                                      activeColor: AppColors.primary,
                                      checkColor: AppColors.white,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 0.5,
                              color: AppColors.white38,
                              height: 0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: SizedBox(
                                width: Get.width,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
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
                                              "${exploreController.investorExploreList[index].designation}",
                                          textSize: 12,
                                          maxLine: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  sqaureCard(
                                      img: PngAssetPath.samIcon,
                                      title: "Recent Investment",
                                      subTitle: exploreController
                                          .investorExploreList[index]
                                          .recentInvestment!),
                                  sqaureCard(
                                      img: PngAssetPath.tamIcon,
                                      title: "Ave Recent Investments",
                                      subTitle: exploreController
                                          .investorExploreList[index]
                                          .recentInvestment!),
                                  sqaureCard(
                                      img: PngAssetPath.fundingAskIcon,
                                      title: "Avg Age of Startup",
                                      subTitle: exploreController
                                          .investorExploreList[index]
                                          .recentInvestment!),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: TextWidget(
                                  text: "Public Links",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: SizedBox(
                                  height: 42,
                                  child: InkWell(
                                    onTap: () {
                                      Helper.launchUrl(exploreController
                                          .investorExploreList[index]
                                          .linkedin!);
                                    },
                                    child: Card(
                                      color: AppColors.white12,
                                      surfaceTintColor: AppColors.white12,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              'https://ch-social-link-logo.s3.ap-south-1.amazonaws.com/linkedin.png',
                                              height: 25,
                                            ),
                                            const SizedBox(width: 6),
                                            const TextWidget(
                                                text: "Linkedin", textSize: 12)
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: TextWidget(
                                  text: "Company Invested",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Wrap(
                                spacing: 4.0,
                                runSpacing: 4.0,
                                children: List.generate(
                                    exploreController.investorExploreList[index]
                                        .startupsInvested!.length, (ind) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    color: AppColors.white12,
                                    surfaceTintColor: AppColors.white12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.network(
                                              exploreController
                                                      .investorExploreList[
                                                          index]
                                                      .startupsInvested![ind]
                                                      .logo ??
                                                  "",
                                              height: 12),
                                          const SizedBox(width: 6),
                                          TextWidget(
                                              text:
                                                  '${exploreController.investorExploreList[index].startupsInvested![ind].name}',
                                              textSize: 14),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: AppButton.outlineButton(
                                  onButtonPressed: () {
                                    Get.to(() => PublicProfileScreen(
                                        id: exploreController
                                            .investorExploreList[index]
                                            .investorId!));
                                  },
                                  borderColor:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                  borderRadius: 12,
                                  height: 40,
                                  title: "Connect with the Investor"),
                            ),
                            sizedTextfield,
                          ],
                        ));
                  },
                ),
              ),
            ],
          );
  }

  bool isAllCheckedVc = false;
  List<String> selectedVcsIds = [];
  vcsTab() {
    return exploreController.vcExploreList.isEmpty
        ? const Center(
            child: TextWidget(
              text: "No Data Found",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        : Column(
            children: [
              if (GetStoreData.getStore.read('isInvestor') == false)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: isAllCheckedVc,
                      onChanged: (value) {
                        setState(() {
                          isAllCheckedVc = value!;
                          selectedVcsIds.clear();

                          for (var vc in exploreController.vcExploreList) {
                            vc.isChecked = isAllCheckedVc;
                            if (isAllCheckedVc) {
                              selectedVcsIds.add(vc.id!);
                            }
                          }
                        });
                      },
                      side: BorderSide(color: AppColors.grey, width: 1.5),
                      activeColor: AppColors.primary,
                      checkColor: AppColors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    const TextWidget(
                      text: "Select All",
                      textSize: 12,
                    ),
                    const Spacer(),
                    if (selectedVcsIds.isNotEmpty)
                      InkWell(
                        onTap: () {
                          exploreController.getCampaignLists();
                          addInvestorPopup(context, selectedVcsIds, false)
                              .then((val) {
                            if (val) {
                              selectedVcsIds.clear();
                              for (var vc in exploreController.vcExploreList) {
                                vc.isChecked = false;
                              }
                              isAllCheckedVc = false;
                              setState(() {});
                            }
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(6)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            child: TextWidget(
                                text: "+ ADD (${selectedVcsIds.length})",
                                textSize: 12,
                                fontWeight: FontWeight.w500)),
                      )
                  ],
                ),
              if (GetStoreData.getStore.read('isInvestor') == false)
                const SizedBox(height: 4),
              Expanded(
                child: ListView.separated(
                  itemCount: exploreController.vcExploreList.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => VCsProfileScreen(
                              vcId: exploreController.vcExploreList[index].id!,
                            ));
                      },
                      child: Card(
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
                                                  exploreController
                                                          .vcExploreList[index]
                                                          .logo ??
                                                      ""))),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextWidget(
                                                text:
                                                    "${exploreController.vcExploreList[index].name}",
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
                                                "${exploreController.vcExploreList[index].location} ${exploreController.vcExploreList[index].age} years",
                                            textSize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (GetStoreData.getStore
                                            .read('isInvestor') ==
                                        false)
                                      Checkbox(
                                        value: exploreController
                                            .vcExploreList[index].isChecked,
                                        onChanged: (value) {
                                          setState(() {
                                            exploreController
                                                .vcExploreList[index]
                                                .isChecked = value!;
                                            if (value) {
                                              selectedVcsIds.add(
                                                  exploreController
                                                      .vcExploreList[index]
                                                      .id!);
                                            } else {
                                              selectedVcsIds.remove(
                                                  exploreController
                                                      .vcExploreList[index]
                                                      .id!);
                                            }
                                            isAllCheckedVc =
                                                selectedVcsIds.length ==
                                                    exploreController
                                                        .vcExploreList.length;
                                          });
                                        },
                                        side: BorderSide(
                                            color: AppColors.grey, width: 1.5),
                                        activeColor: AppColors.primary,
                                        checkColor: AppColors.white,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Divider(
                                thickness: 0.5,
                                color: AppColors.white38,
                                height: 0,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Stage Focus",
                                    textSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: List.generate(
                                      exploreController.vcExploreList[index]
                                          .stageFocus!.length, (ind) {
                                    return Card(
                                      color: AppColors.purple,
                                      // surfaceTintColor: AppColors.purple,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 6),
                                          child: TextWidget(
                                            text: exploreController
                                                .vcExploreList[index]
                                                .stageFocus![ind],
                                            textSize: 14,
                                            color: AppColors.white,
                                          )),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: 12),
                              Divider(
                                thickness: 0.5,
                                color: AppColors.white38,
                                height: 0,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Sector Focus",
                                    textSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: List.generate(
                                      exploreController.vcExploreList[index]
                                          .sectorFocus!.length, (ind) {
                                    return Card(
                                      color: AppColors.purple,
                                      // surfaceTintColor: AppColors.purple,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0, vertical: 6),
                                          child: TextWidget(
                                            text: exploreController
                                                .vcExploreList[index]
                                                .sectorFocus![ind],
                                            textSize: 14,
                                            color: AppColors.white,
                                          )),
                                    );
                                  }),
                                ),
                              ),
                              SizedBox(height: 12),
                              Divider(
                                thickness: 0.5,
                                color: AppColors.white38,
                                height: 0,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: TextWidget(
                                    text: "Ticket Size",
                                    textSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: TextWidget(
                                      text:
                                          "${exploreController.vcExploreList[index].ticketSize}",
                                      textSize: 18,
                                      fontWeight: FontWeight.w600)),
                              sizedTextfield,
                            ],
                          )),
                    );
                  },
                ),
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
