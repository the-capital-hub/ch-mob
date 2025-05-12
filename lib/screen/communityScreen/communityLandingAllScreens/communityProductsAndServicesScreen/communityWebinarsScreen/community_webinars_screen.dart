import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityWebinarsScreen/communityRegisterNowScreen/community_register_now_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityWebinarsScreen/communityRegisteredUsersScreen/community_registered_users_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import 'community_add_webinar_screen.dart';

class CommunityWebinarsScreen extends StatefulWidget {
  const CommunityWebinarsScreen({super.key});

  @override
  State<CommunityWebinarsScreen> createState() =>
      _CommunityWebinarsScreenState();
}

class _CommunityWebinarsScreenState extends State<CommunityWebinarsScreen> {
  CommunityWebinarsController communityWebinars =
      Get.put(CommunityWebinarsController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityWebinars.getCommunityWebinar().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  bool isWebinarEnded = false;
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: isAdmin
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(() => CommunityAddWebinarScreen(isEdit: false));
                  },
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Icon(Icons.add, color: AppColors.white),
                )
              : null,
          backgroundColor: AppColors.transparent,
          body: Obx(() => communityWebinars.isLoading.value
              ? Helper.pageLoading()
              : communityWebinars.communityWebinarsList.isEmpty
                  ? const Center(
                      child: TextWidget(
                          text: "No Webinars Available", textSize: 16))
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      padding: EdgeInsets.zero,
                      itemCount: communityWebinars.communityWebinarsList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: AppColors.blackCard,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (communityWebinars
                                    .communityWebinarsList[index]
                                    .image!
                                    .isNotEmpty) ...[
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              // "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                                              communityWebinars
                                                  .communityWebinarsList[index]
                                                  .image!,
                                            ),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                                sizedTextfield,
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextWidget(
                                        maxLine: 1,
                                        text: communityWebinars
                                            .communityWebinarsList[index]
                                            .title!,
                                        textSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (isAdmin) ...[
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => CommunityAddWebinarScreen(
                                              isEdit: true,
                                              webinar: communityWebinars
                                                      .communityWebinarsList[
                                                  index]));
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: AppColors.green700
                                              .withOpacity(0.8),
                                          child: Icon(Icons.edit,
                                              color: AppColors.whiteCard,
                                              size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          showCustomPopup(
                                            context: context,
                                            title: "Delete this webinar",
                                            message:
                                                "Are you sure you\nwant to delete this webinar?",
                                            button1Text: "Cancel",
                                            button2Text: "Ok",
                                            icon: Icons.delete,
                                            onButton1Pressed: () {
                                              Get.back();
                                            },
                                            onButton2Pressed: () {
                                              Get.back();
                                              Helper.loader(context);
                                              communityWebinars
                                                  .deleteCommunityWebinar(
                                                      communityWebinars
                                                          .communityWebinarsList[
                                                              index]
                                                          .id);
                                            },
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: AppColors.redColor
                                              .withOpacity(0.8),
                                          child: Icon(Icons.delete,
                                              color: AppColors.whiteCard,
                                              size: 20),
                                        ),
                                      ),
                                    ],
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () {
                                        sharePostPopup(
                                            context,
                                            "",
                                            communityWebinars
                                                .communityWebinarsList[index]
                                                .webinarSharelink!);
                                      },
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            AppColors.blue.withOpacity(0.8),
                                        child: Icon(
                                            Icons.mobile_screen_share_rounded,
                                            color: AppColors.whiteCard,
                                            size: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                if (!communityWebinars
                                    .communityWebinarsList[index]
                                    .isActive!) ...[
                                  TextWidget(
                                    text: "This webinar is cancelled.",
                                    textSize: 16,
                                    color: AppColors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                                HtmlWidget(
                                  _isExpanded
                                      ? "${communityWebinars.communityWebinarsList[index].description}"
                                      : communityWebinars
                                                  .communityWebinarsList[index]
                                                  .description!
                                                  .length >
                                              200
                                          ? "${communityWebinars.communityWebinarsList[index].description!.substring(0, 200)} ..."
                                          : communityWebinars
                                              .communityWebinarsList[index]
                                              .description!,
                                  textStyle: TextStyle(
                                      fontSize:
                                          (MediaQuery.of(context).size.width /
                                                  375) *
                                              12,
                                      color: AppColors.white),
                                ),
                                if (communityWebinars
                                        .communityWebinarsList[index]
                                        .description!
                                        .length >
                                    200)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isExpanded = !_isExpanded;
                                        });
                                      },
                                      child: Text(
                                        _isExpanded ? "Read Less" : "Read More",
                                        style: const TextStyle(
                                            color: AppColors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: AppColors.white12,
                                            child: Icon(
                                              Icons.calendar_month,
                                              color: AppColors.white,
                                              size: 22,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          TextWidget(
                                              text: communityWebinars
                                                  .communityWebinarsList[index]
                                                  .date!,
                                              textSize: 15)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  AppColors.white12,
                                              child: Icon(
                                                Icons.person,
                                                color: AppColors.white,
                                                size: 22,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          TextWidget(
                                              text:
                                                  "${communityWebinars.communityWebinarsList[index].joinedUsers!.length} joined",
                                              textSize: 15)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  AppColors.white12,
                                              child: Icon(
                                                Icons.schedule,
                                                color: AppColors.white,
                                                size: 22,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          TextWidget(
                                              text: communityWebinars
                                                  .communityWebinarsList[index]
                                                  .duration!,
                                              textSize: 15)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  AppColors.white12,
                                              child: Icon(
                                                Icons.payment,
                                                color: AppColors.white,
                                                size: 22,
                                              )),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          TextWidget(
                                              text: communityWebinars
                                                          .communityWebinarsList[
                                                              index]
                                                          .price ==
                                                      "0"
                                                  ? "Free"
                                                  : "\u{20B9}${communityWebinars.communityWebinarsList[index].price}",
                                              textSize: 16)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                sizedTextfield,
                                if (isAdmin) ...[
                                  AppButton.primaryButton(
                                      height: 40,
                                      onButtonPressed: () {
                                        Get.to(() =>
                                            CommunityRegisteredUsersScreen(
                                                index: index));
                                      },
                                      title: "View Guests"),
                                  const SizedBox(height: 8),
                                ],
                                if (!isAdmin &&
                                    !communityWebinars
                                        .communityWebinarsList[index]
                                        .isExpired!) ...[
                                  AppButton.primaryButton(
                                      height: 40,
                                      onButtonPressed: () {
                                        Get.to(() => CommunityRegisterNowScreen(
                                            index: index));
                                      },
                                      title: "+ Register Now"),
                                  const SizedBox(height: 8),
                                ],
                                if (communityWebinars
                                    .communityWebinarsList[index].isExpired!)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Card(
                                          margin: const EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: const BorderSide(
                                              color: AppColors.redColor,
                                              width: 1,
                                            ),
                                          ),
                                          color: AppColors.redColor
                                              .withOpacity(0.3),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 9),
                                            child: Center(
                                              child: TextWidget(
                                                text: "Webinar Time Expired",
                                                textSize: 16,
                                                color: AppColors.redColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))),
    );
  }
}
