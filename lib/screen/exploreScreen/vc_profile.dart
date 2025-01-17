import 'package:capitalhub_crm/controller/exploreController/explore_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../utils/constant/app_var.dart';
import '../../utils/helper/helper.dart';

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
        ? Helper.pageLoading()
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
                                    'https://thecapitalhub.s3.ap-south-1.amazonaws.com/linkedin.png',
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
                        InkWell(
                          onTap: () {
                            // Helper.launchUrl(exploreController
                            //     .investorExploreList[index].linkedin!);
                          },
                          splashColor: AppColors.transparent,
                          child: Card(
                            color: AppColors.purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 9.5),
                              child: TextWidget(
                                text: "Apply for funds",
                                textSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
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
                                  Card(
                                    color: AppColors.white12,
                                    surfaceTintColor: AppColors.white12,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 6),
                                        child: TextWidget(
                                          text: "Contact",
                                          textSize: 15,
                                          color: AppColors.white,
                                        )),
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
                                                    textSize: 15,
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
                                                        "${exploreController.vcDetails.totalPortfolio}",
                                                    textSize: 15,
                                                    color: AppColors.white,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                                text: "  Current Fund Corpus",
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
                                                        "${exploreController.vcDetails.currentFundCorpus}",
                                                    textSize: 15,
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
                                                text: "  Total Fund Corpus",
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
                                                        "${exploreController.vcDetails.totalFundCorpus}",
                                                    textSize: 15,
                                                    color: AppColors.white,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));
  }
}
