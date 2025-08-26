import 'package:capitalhub_crm/controller/exploreController/explore_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/utils/helper/placeholder.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../utils/constant/app_var.dart';
import '../../utils/constant/asset_constant.dart';
import '../../utils/helper/helper.dart';
import '../subscriptionScreen/subscription_screen.dart';

class VCsProfileScreen extends StatefulWidget {
  String vcId;
  VCsProfileScreen({super.key, required this.vcId});

  @override
  State<VCsProfileScreen> createState() => _VCsProfileScreenState();
}

class _VCsProfileScreenState extends State<VCsProfileScreen> {
  ExploreController exploreController = Get.put(ExploreController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      exploreController.vcDeatilPost(context, vcId: widget.vcId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => exploreController.isLoading.value
        ? ShimmerLoader.buildShimmerBlincProfile()
        : Container(
            decoration: bgDec,
            child: Scaffold(
              backgroundColor: AppColors.transparent,
              appBar:
                  HelperAppBar.appbarHelper(title: "Profile", autoAction: true),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Column(
                      children: [
                        sizedTextfield,
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "${exploreController.vcDetails.logo}"),
                          radius: 45,
                        ),
                        sizedTextfield,
                        TextWidget(
                            text: "${exploreController.vcDetails.name}",
                            textSize: 20,
                            fontWeight: FontWeight.w500),
                        sizedTextfield,
                        TextWidget(
                          text: "${exploreController.vcDetails.description}",
                          textSize: 14,
                          align: TextAlign.center,
                          maxLine: 10,
                        ),
                        sizedTextfield,
                        InkWell(
                          onTap: () {
                            Helper.launchUrl(
                                exploreController.vcDetails.linkedin!);
                          },
                          splashColor: AppColors.transparent,
                          child: Card(
                            color: AppColors.linkedInBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    'https://ch-social-link-logo.s3.ap-south-1.amazonaws.com/linkedin.png',
                                    height: 30,
                                  ),
                                  const SizedBox(width: 6),
                                  const TextWidget(
                                    text: "Linkedin",
                                    textSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        // InkWell(
                        //   onTap: () {
                        //     Get.to(() => const VcApplyForFundScreen());
                        //   },
                        //   splashColor: AppColors.transparent,
                        //   child: Card(
                        //     color: AppColors.purple,
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(100)),
                        //     child: const Padding(
                        //       padding: EdgeInsets.symmetric(
                        //           horizontal: 12.0, vertical: 9.5),
                        //       child: TextWidget(
                        //         text: "Apply for funds",
                        //         textSize: 14,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        sizedTextfield,
                        SizedBox(
                          width: Get.width,
                          child: Card(
                            color: AppColors.blackCard,
                            surfaceTintColor: AppColors.blackCard,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: AppColors.purple, // Border color
                                width: 2.0, // Border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TextWidget(
                                      text: "Best Way to Get in Touch",
                                      textSize: 15,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextWidget(
                                              text: GetStoreData.getStore
                                                      .read('isSubscribed')
                                                  ? exploreController
                                                      .vcDetails.email!
                                                  : "xxxxx@xxx.com",
                                              maxLine: 3,
                                              textSize: 15)),
                                      const SizedBox(width: 8),
                                      if (!GetStoreData.getStore
                                          .read('isSubscribed'))
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => SubscriptionScreen(
                                                    fromCampaign: false))!
                                                .whenComplete(() {
                                              setState(() {});
                                            });
                                          },
                                          child: const TextWidget(
                                              text: "Show Mail",
                                              textSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primary),
                                        )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: AppColors.white38,
                                    height: 16,
                                  ),
                                  const TextWidget(
                                      text: "Stage Focus",
                                      textSize: 15,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 4.0,
                                    runSpacing: 4.0,
                                    children: List.generate(
                                        exploreController.vcDetails.stageFocus!
                                            .length, (ind) {
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
                                                  .vcDetails.stageFocus![ind],
                                              textSize: 15,
                                              color: AppColors.white,
                                            )),
                                      );
                                    }),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: AppColors.white38,
                                    height: 16,
                                  ),
                                  const TextWidget(
                                      text: "Sector Focus",
                                      textSize: 15,
                                      fontWeight: FontWeight.w500),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 4.0,
                                    runSpacing: 4.0,
                                    children: List.generate(
                                        exploreController.vcDetails.sectorFocus!
                                            .length, (ind) {
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
                                                  .vcDetails.sectorFocus![ind],
                                              textSize: 15,
                                              color: AppColors.white,
                                            )),
                                      );
                                    }),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                    color: AppColors.white38,
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                                text: "  Ticket Size",
                                                textSize: 15,
                                                fontWeight: FontWeight.w500),
                                            const SizedBox(height: 6),
                                            Card(
                                              color: AppColors.white12,
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 6),
                                                  child: TextWidget(
                                                    text:
                                                        "${exploreController.vcDetails.ticketSize}",
                                                    textSize: 14,
                                                    color: AppColors.white,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                                text: "  Total Portfolio",
                                                textSize: 15,
                                                fontWeight: FontWeight.w500),
                                            const SizedBox(height: 6),
                                            Card(
                                              color: AppColors.white12,
                                              surfaceTintColor:
                                                  AppColors.white12,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 6),
                                                  child: TextWidget(
                                                    text:
                                                        "${exploreController.vcDetails.totalPortfolio} companies",
                                                    textSize: 15,
                                                    color: AppColors.white,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(height: 8),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           const TextWidget(
                                  //               text: "  Current Fund Corpus",
                                  //               textSize: 15,
                                  //               fontWeight: FontWeight.w500),
                                  //           const SizedBox(height: 6),
                                  //           Card(
                                  //             color: AppColors.white12,
                                  //             surfaceTintColor:
                                  //                 AppColors.white12,
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         100)),
                                  //             child: Padding(
                                  //                 padding: const EdgeInsets
                                  //                     .symmetric(
                                  //                     horizontal: 18.0,
                                  //                     vertical: 6),
                                  //                 child: TextWidget(
                                  //                   text:
                                  //                       "${exploreController.vcDetails.currentFundCorpus}",
                                  //                   textSize: 15,
                                  //                   color: AppColors.white,
                                  //                 )),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.start,
                                  //         children: [
                                  //           const TextWidget(
                                  //               text: "  Total Fund Corpus",
                                  //               textSize: 15,
                                  //               fontWeight: FontWeight.w500),
                                  //           const SizedBox(height: 6),
                                  //           Card(
                                  //             color: AppColors.white12,
                                  //             surfaceTintColor:
                                  //                 AppColors.white12,
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(
                                  //                         100)),
                                  //             child: Padding(
                                  //                 padding: const EdgeInsets
                                  //                     .symmetric(
                                  //                     horizontal: 18.0,
                                  //                     vertical: 6),
                                  //                 child: TextWidget(
                                  //                   text:
                                  //                       "${exploreController.vcDetails.totalFundCorpus}",
                                  //                   textSize: 15,
                                  //                   color: AppColors.white,
                                  //                 )),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        sizedTextfield,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                              text: "Team Members",
                              textSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        sizedTextfield,
                        SizedBox(
                          height: 175,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                exploreController.vcDetails.people!.length,
                            itemBuilder: (context, ind) {
                              // final item = companyController.teamMember[index];
                              return Container(
                                width: 180,
                                height: 175,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.blackCard,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 2),
                                    TextWidget(
                                        text:
                                            "${exploreController.vcDetails.people![ind].cName}",
                                        textSize: 15,
                                        fontWeight: FontWeight.w500),
                                    Divider(
                                        height: 18, color: AppColors.white12),
                                    Expanded(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Icon(Icons.mail_outline_outlined,
                                              size: 18,
                                              color: AppColors.white54),
                                          const SizedBox(width: 10),
                                          Expanded(
                                              child: TextWidget(
                                                  text:
                                                      "${exploreController.vcDetails.people![ind].cEmail}",
                                                  fontWeight: FontWeight.w500,
                                                  textSize: 12,
                                                  maxLine: 4))
                                        ])),
                                    Divider(
                                        height: 18, color: AppColors.white12),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          if (exploreController
                                              .vcDetails
                                              .people![ind]
                                              .cLinkedin!
                                              .isEmpty) {
                                            HelperSnackBar.snackBar("Error",
                                                "No LinkedIn profile available");
                                            return;
                                          }
                                          Helper.launchUrl(
                                              "${exploreController.vcDetails.people![ind].cLinkedin}");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 4),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: AppColors.linkedInBlue),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                  PngAssetPath.linkedinIcon,
                                                  height: 20),
                                              const SizedBox(width: 6),
                                              const TextWidget(
                                                  text: "Linkedin",
                                                  textSize: 12),
                                              const SizedBox(width: 6),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
  }
}
