import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityAboutController/community_about_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../exploreCommunityScreen/purchase_community_screen.dart';
import '../communityLandingScreen/community_landing_screen.dart';

class CommunityAboutScreen extends StatefulWidget {
  bool isPublic;
  int index;
  CommunityAboutScreen(
      {required this.isPublic, required this.index, super.key});

  @override
  State<CommunityAboutScreen> createState() => _CommunityAboutScreenState();
}

class _CommunityAboutScreenState extends State<CommunityAboutScreen> {
  CommunityController allCommunities = Get.put(CommunityController());
  List<String> postsFilter = ['All Posts', 'Admin Posts', 'Member Posts'];
  CommunityProductsAndMembersController communityProducts =
      Get.put(CommunityProductsAndMembersController());
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());
  CommunityAboutController aboutCommunity = Get.put(CommunityAboutController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.wait([
        // communityProducts.getCommunityProductsandMembers(),
        // communityEvents.getCommunityEvents(),
        aboutCommunity.getAboutCommunity()
      ]).then((values) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  final List<Color> containerColors = [
    AppColors.lightBlue,
    AppColors.navyBlue,
    AppColors.oliveGreen
  ];
  bool isPostsVisible = false;
  bool isProductsVisible = false;
  bool isEventsVisible = false;

  _joinNowTap(index) async {
    Helper.loader(context);
    createdCommunityId = allCommunities.allCommunitiesDetails[index].id;
    communityLogo = allCommunities.allCommunitiesDetails[index].image;
    communityName = allCommunities.allCommunitiesDetails[index].community;
    isAdmin = allCommunities.allCommunitiesDetails[index].role == "Admin"
        ? true
        : false;
    await allCommunities.joinCommunity();
    Get.to(() => const CommunityLandingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: SafeArea(
            child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Obx(
            () => aboutCommunity.isLoading.value
                ? Helper.pageLoading()
                : aboutCommunity.aboutCommunityList.isEmpty
                    ? Center(
                        child: TextWidget(
                        text: "No About Community Available",
                        textSize: 16,
                        color: AppColors.grey,
                      ))
                    : SingleChildScrollView(
                        child: Column(children: [
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(aboutCommunity
                                      .aboutCommunityList[0].community!.banner
                                      .toString()),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.black.withOpacity(0.25),
                                    BlendMode.darken,
                                  ),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.black,
                                    AppColors.brown,
                                    AppColors.purple,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: AppColors.transparent,
                                    foregroundImage: NetworkImage(aboutCommunity
                                        .aboutCommunityList[0].community!.image
                                        .toString()),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const TextWidget(
                                    text: "Welcome to the",
                                    textSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    text: aboutCommunity
                                        .aboutCommunityList[0].community!.name
                                        .toString(),
                                    textSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.redColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                if (widget.isPublic) ...[
                                  AppButton.primaryButton(
                                      onButtonPressed: () async {
                                        if (aboutCommunity.aboutCommunityList[0]
                                                .community!.amount ==
                                            0) {
                                          _joinNowTap(widget.index);
                                        } else {
                                          Get.to(() => CommunityPurchaseScreen(
                                              index: widget.index));
                                        }
                                      },
                                      title: "Join Community"),
                                  const SizedBox(height: 12),
                                ],
                                TextWidget(
                                  text: "About Community",
                                  textSize: 16,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 6),
                                HtmlWidget(
                                  aboutCommunity
                                      .aboutCommunityList[0].community!.about
                                      .toString(),
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextWidget(
                                  text: "Community Admin",
                                  textSize: 16,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 6),
                                Card(
                                    margin: EdgeInsets.zero,
                                    color: AppColors.blackCard,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 80,
                                            child: Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: NetworkImage(
                                                      aboutCommunity
                                                          .aboutCommunityList[0]
                                                          .admin!
                                                          .profilePicture
                                                          .toString()),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                TextWidget(
                                                  text:
                                                      "${aboutCommunity.aboutCommunityList[0].admin!.firstName} ${aboutCommunity.aboutCommunityList[0].admin!.lastName}",
                                                  textSize: 16,
                                                  maxLine: 3,
                                                  align: TextAlign.center,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                TextWidget(
                                                  text: aboutCommunity
                                                      .aboutCommunityList[0]
                                                      .admin!
                                                      .bio
                                                      .toString(),
                                                  textSize: 12,
                                                  maxLine: 7,
                                                  align: TextAlign.start,
                                                ),
                                                const SizedBox(height: 4),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: TextWidget(
                                                      text: aboutCommunity
                                                          .aboutCommunityList[0]
                                                          .admin!
                                                          .designation
                                                          .toString(),
                                                      align: TextAlign.end,
                                                      textSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                  text: "Terms and Conditions",
                                  textSize: 16,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 6),
                                aboutCommunity.aboutCommunityList[0].community!
                                        .termsAndConditions!.isEmpty
                                    ? SizedBox(
                                        height: 100,
                                        child: Center(
                                          child: TextWidget(
                                            text:
                                                "No Terms and Conditions Available",
                                            textSize: 16,
                                            color: AppColors.white38,
                                          ),
                                        ))
                                    : const SizedBox(),
                                for (int i = 0;
                                    i <
                                        aboutCommunity
                                            .aboutCommunityList[0]
                                            .community!
                                            .termsAndConditions!
                                            .length;
                                    i++)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const TextWidget(
                                          text: "•  ", textSize: 14),
                                      Expanded(
                                        child: TextWidget(
                                            maxLine: 3,
                                            text: aboutCommunity
                                                .aboutCommunityList[0]
                                                .community!
                                                .termsAndConditions![i],
                                            textSize: 14),
                                      ),
                                    ],
                                  ),
                                const SizedBox(
                                  height: 12,
                                ),
                                if (widget.isPublic) ...[
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: "Recent Posts From Admin",
                                        textSize: 16,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isPostsVisible = !isPostsVisible;
                                            });
                                          },
                                          icon: isPostsVisible
                                              ? Icon(Icons.keyboard_arrow_up,
                                                  color: AppColors.whiteShade)
                                              : Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors.whiteShade,
                                                ))
                                    ],
                                  ),
                                  if (isPostsVisible)
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  if (isPostsVisible)
                                    aboutCommunity
                                            .aboutCommunityPostsList.isEmpty
                                        ? Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                                height: 100,
                                                child: Center(
                                                  child: TextWidget(
                                                    text:
                                                        "No Community Posts Available",
                                                    textSize: 14,
                                                    color: AppColors.white54,
                                                  ),
                                                )),
                                          )
                                        : ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 12,
                                              );
                                            },
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: aboutCommunity
                                                .aboutCommunityPostsList.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                margin: EdgeInsets.zero,
                                                color: AppColors.blackCard,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            foregroundImage:
                                                                NetworkImage(
                                                              aboutCommunity
                                                                  .aboutCommunityPostsList[
                                                                      index]
                                                                  .user!
                                                                  .profilePicture
                                                                  .toString(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Expanded(
                                                            child: TextWidget(
                                                                text: aboutCommunity
                                                                    .aboutCommunityPostsList[
                                                                        index]
                                                                    .createdAt
                                                                    .toString(),
                                                                textSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color:
                                                            AppColors.white38,
                                                      ),
                                                      HtmlWidget(
                                                        aboutCommunity
                                                            .aboutCommunityPostsList[
                                                                index]
                                                            .description!,
                                                        textStyle: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      if (aboutCommunity
                                                          .aboutCommunityPostsList[
                                                              index]
                                                          .image!
                                                          .isNotEmpty)
                                                        Container(
                                                          height: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            aboutCommunity.aboutCommunityPostsList[index].image.toString(),
                                                                          ),
                                                                          fit: BoxFit
                                                                              .fill),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      TextWidget(
                                        text: "Community Products",
                                        textSize: 16,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isProductsVisible =
                                                  !isProductsVisible;
                                            });
                                          },
                                          icon: isProductsVisible
                                              ? Icon(
                                                  Icons.keyboard_arrow_up,
                                                  color: AppColors.whiteShade,
                                                )
                                              : Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: AppColors.whiteShade,
                                                ))
                                    ],
                                  ),
                                  if (isProductsVisible)
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  if (isProductsVisible)
                                    aboutCommunity
                                            .aboutCommunityProductsList.isEmpty
                                        ? Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                                height: 100,
                                                child: Center(
                                                  child: TextWidget(
                                                    text:
                                                        "No Community Products Available",
                                                    textSize: 14,
                                                    color: AppColors.white54,
                                                  ),
                                                )),
                                          )
                                        : ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                height: 12,
                                              );
                                            },
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: aboutCommunity
                                                .aboutCommunityProductsList
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                margin: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                color: AppColors.blackCard,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Stack(children: [
                                                        Container(
                                                          height: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                          image:
                                                                              NetworkImage(
                                                                            aboutCommunity.aboutCommunityProductsList[index].image.toString(),
                                                                          ),
                                                                          fit: BoxFit
                                                                              .fill),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                        ),
                                                        Positioned(
                                                          top: -4,
                                                          left: -4,
                                                          child: Card(
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          12),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          12)),
                                                            ),
                                                            color: GetStoreData
                                                                    .getStore
                                                                    .read(
                                                                        'isInvestor')
                                                                ? AppColors
                                                                    .primaryInvestor
                                                                : AppColors
                                                                    .primary,
                                                            child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        4),
                                                                child:
                                                                    TextWidget(
                                                                  text: aboutCommunity
                                                                          .aboutCommunityProductsList[
                                                                              index]
                                                                          .isFree!
                                                                      ? "Free"
                                                                      : "\u{20B9}${aboutCommunity.aboutCommunityProductsList[index].amount}/-",
                                                                  textSize: 16,
                                                                  color: GetStoreData
                                                                          .getStore
                                                                          .read(
                                                                              'isInvestor')
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .white,
                                                                )),
                                                          ),
                                                        ),
                                                      ]),
                                                      sizedTextfield,
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 12,
                                                                right: 16),
                                                        child: TextWidget(
                                                          text: aboutCommunity
                                                              .aboutCommunityProductsList[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          textSize: 16,
                                                          maxLine: 2,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 12,
                                                                right: 16),
                                                        child: HtmlWidget(
                                                          aboutCommunity
                                                              .aboutCommunityProductsList[
                                                                  index]
                                                              .description
                                                              .toString(),
                                                          textStyle: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets
                                                      //       .symmetric(
                                                      //       horizontal: 50,
                                                      //       vertical: 12),
                                                      //   child:
                                                      //       AppButton.primaryButton(
                                                      //           onButtonPressed:
                                                      //               () {
                                                      //             if (aboutCommunity
                                                      //                 .aboutCommunityProductsList[
                                                      //                     index]
                                                      //                 .isFree!) {
                                                      //               showDialog(
                                                      //                 context:
                                                      //                     context,
                                                      //                 builder:
                                                      //                     (BuildContext
                                                      //                         context) {
                                                      //                   return AlertDialog(
                                                      //                     backgroundColor:
                                                      //                         AppColors
                                                      //                             .blackCard,
                                                      //                     title: const Align(
                                                      //                         alignment: Alignment.center,
                                                      //                         child: TextWidget(
                                                      //                           text:
                                                      //                               'Resource URLs',
                                                      //                           textSize:
                                                      //                               25,
                                                      //                           fontWeight:
                                                      //                               FontWeight.bold,
                                                      //                         )),
                                                      //                     content:
                                                      //                         Column(
                                                      //                       crossAxisAlignment:
                                                      //                           CrossAxisAlignment.start,
                                                      //                       mainAxisSize:
                                                      //                           MainAxisSize.min,
                                                      //                       children: [
                                                      //                         for (var i = 0;
                                                      //                             i < aboutCommunity.aboutCommunityProductsList[index].urls!.length;
                                                      //                             i++)
                                                      //                           TextWidget(
                                                      //                             text: aboutCommunity.aboutCommunityProductsList[index].urls![i],
                                                      //                             textSize: 16,
                                                      //                             color: AppColors.primary,
                                                      //                           ),
                                                      //                       ],
                                                      //                     ),
                                                      //                     actions: [
                                                      //                       AppButton
                                                      //                           .primaryButton(
                                                      //                         bgColor:
                                                      //                             AppColors.primary,
                                                      //                         title:
                                                      //                             'Close',
                                                      //                         onButtonPressed:
                                                      //                             () {
                                                      //                           Navigator.of(context).pop();
                                                      //                         },
                                                      //                       ),
                                                      //                     ],
                                                      //                   );
                                                      //                 },
                                                      //               );
                                                      //             } else {
                                                      //               Get.to(() =>
                                                      //                   PurchaseScreen(
                                                      //                       index:
                                                      //                           index));
                                                      //             }
                                                      //           },
                                                      //           title: aboutCommunity
                                                      //                   .aboutCommunityProductsList[
                                                      //                       index]
                                                      //                   .isFree!
                                                      //               ? "Access Resource"
                                                      //               : "Buy \u{20B9}${aboutCommunity.aboutCommunityProductsList[index].amount} "),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  // const SizedBox(
                                  //   height: 12,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     TextWidget(
                                  //       text: "Upcoming Events",
                                  //       textSize: 16,
                                  //       color: AppColors.grey,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //     Spacer(),
                                  //     IconButton(
                                  //         onPressed: () {
                                  //           setState(() {
                                  //             isEventsVisible =
                                  //                 !isEventsVisible;
                                  //           });
                                  //         },
                                  //         icon: isEventsVisible
                                  //             ? Icon(
                                  //                 Icons.keyboard_arrow_up,
                                  //                 color: AppColors.whiteShade,
                                  //               )
                                  //             : Icon(
                                  //                 Icons.keyboard_arrow_down,
                                  //                 color: AppColors.whiteShade,
                                  //               ))
                                  //   ],
                                  // ),
                                  // if (isEventsVisible)
                                  //   const SizedBox(
                                  //     height: 12,
                                  //   ),
                                  // if (isEventsVisible)
                                  //   aboutCommunity
                                  //           .aboutCommunityEventsList.isEmpty
                                  //       ? Align(
                                  //           alignment: Alignment.center,
                                  //           child: SizedBox(
                                  //               height: 100,
                                  //               child: Center(
                                  //                 child: TextWidget(
                                  //                   text:
                                  //                       "No Community Events Available",
                                  //                   textSize: 14,
                                  //                   color: AppColors.white54,
                                  //                 ),
                                  //               )),
                                  //         )
                                  //       : ListView.separated(
                                  //           separatorBuilder: (context, index) {
                                  //             return const SizedBox(
                                  //               height: 12,
                                  //             );
                                  //           },
                                  //           physics:
                                  //               NeverScrollableScrollPhysics(),
                                  //           itemCount: aboutCommunity
                                  //               .aboutCommunityEventsList
                                  //               .length,
                                  //           shrinkWrap: true,
                                  //           itemBuilder: (context, index) {
                                  //             Color containerColor =
                                  //                 containerColors[index %
                                  //                     containerColors.length];

                                  //             return Card(
                                  //               margin: EdgeInsets.zero,
                                  //               shape: RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           6)),
                                  //               color: containerColor,
                                  //               child: Padding(
                                  //                 padding: const EdgeInsets.all(
                                  //                     12.0),
                                  //                 child: Column(
                                  //                   crossAxisAlignment:
                                  //                       CrossAxisAlignment
                                  //                           .start,
                                  //                   children: [
                                  //                     TextWidget(
                                  //                         text: aboutCommunity
                                  //                             .aboutCommunityEventsList[
                                  //                                 index]
                                  //                             .title
                                  //                             .toString(),
                                  //                         textSize: 25),
                                  //                     // communityEvents.communityEventsList[0].webinars[index].isActive?const SizedBox():
                                  //                     // TextWidget(text: "This meeting is cancelled.", textSize: 16,color: AppColors.grey,),
                                  //                     const SizedBox(height: 8),
                                  //                     Card(
                                  //                       color:
                                  //                           AppColors.white38,
                                  //                       child: Padding(
                                  //                         padding:
                                  //                             const EdgeInsets
                                  //                                 .all(8.0),
                                  //                         child: Row(
                                  //                           children: [
                                  //                             Container(
                                  //                               padding:
                                  //                                   const EdgeInsets
                                  //                                       .all(
                                  //                                       8.0),
                                  //                               decoration: BoxDecoration(
                                  //                                   borderRadius:
                                  //                                       BorderRadius
                                  //                                           .circular(
                                  //                                               7),
                                  //                                   color: GetStoreData.getStore.read(
                                  //                                           'isInvestor')
                                  //                                       ? AppColors
                                  //                                           .primaryInvestor
                                  //                                       : AppColors
                                  //                                           .primary),
                                  //                               child: Center(
                                  //                                 child: Image
                                  //                                     .asset(
                                  //                                   PngAssetPath
                                  //                                       .meetingIcon,
                                  //                                   color: GetStoreData.getStore.read(
                                  //                                           'isInvestor')
                                  //                                       ? AppColors
                                  //                                           .black
                                  //                                       : AppColors
                                  //                                           .white,
                                  //                                   height: 22,
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                             const SizedBox(
                                  //                                 width: 8),
                                  //                             Column(
                                  //                               crossAxisAlignment:
                                  //                                   CrossAxisAlignment
                                  //                                       .start,
                                  //                               children: [
                                  //                                 TextWidget(
                                  //                                     text:
                                  //                                         "${aboutCommunity.aboutCommunityEventsList[index].duration}",
                                  //                                     textSize:
                                  //                                         15),
                                  //                                 const TextWidget(
                                  //                                     text:
                                  //                                         "Video Meeting",
                                  //                                     textSize:
                                  //                                         15),
                                  //                               ],
                                  //                             ),
                                  //                             const Spacer(),
                                  //                             Container(
                                  //                               padding: const EdgeInsets
                                  //                                   .symmetric(
                                  //                                   horizontal:
                                  //                                       5,
                                  //                                   vertical:
                                  //                                       5),
                                  //                               decoration:
                                  //                                   BoxDecoration(
                                  //                                 borderRadius:
                                  //                                     BorderRadius
                                  //                                         .circular(
                                  //                                             20),
                                  //                                 border: Border.all(
                                  //                                     color: AppColors
                                  //                                         .white,
                                  //                                     width: 1),
                                  //                               ),
                                  //                               child: Row(
                                  //                                 mainAxisAlignment:
                                  //                                     MainAxisAlignment
                                  //                                         .center,
                                  //                                 children: [
                                  //                                   TextWidget(
                                  //                                       text:
                                  //                                           "Rs ${aboutCommunity.aboutCommunityEventsList[index].price} +",
                                  //                                       textSize:
                                  //                                           12),
                                  //                                   const SizedBox(
                                  //                                       width:
                                  //                                           5),
                                  //                                   Icon(
                                  //                                       Icons
                                  //                                           .arrow_forward,
                                  //                                       color: AppColors
                                  //                                           .white,
                                  //                                       size:
                                  //                                           12),
                                  //                                 ],
                                  //                               ),
                                  //                             ),
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     sizedTextfield,
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             );
                                  //           },
                                  //         ),
                                ],
                              ]),
                        ),
                      ])),
          ),
        )));
  }
}
