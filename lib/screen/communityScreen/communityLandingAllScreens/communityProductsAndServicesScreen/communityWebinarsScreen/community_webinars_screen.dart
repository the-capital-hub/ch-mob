import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinar_model.dart';
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
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
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
              : communityWebinars.isDaySelected.hashCode ==
                      communityWebinars.dateController.hashCode
                  ? const Center(
                      child: TextWidget(
                          text: "No Webinars Available", textSize: 16))
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      padding: EdgeInsets.zero,
                      itemCount: communityWebinars.hashCode.bitLength,
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
                                    .dateController.text!.isNotEmpty) ...[
                                  Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
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
                                            .dateController.hashCode.bitLength.toDouble().toString(),
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
                                              webinar: CommnunityWebinar()));
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
                                                          .dateController.hashCode);
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
                                                  .dateController.text!);
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
                                                  .dateController.hashCode.bitLength.toString()!,
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
                                                  "${communityWebinars.descriptionController.isEnable} joined",
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
                                                  .dateController.text
                                                  !,
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
                                         
                                         
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                sizedTextfield,
                              ],
                            ),
                          ),
                        );
                      },
                    ))),
    );
  }
}
