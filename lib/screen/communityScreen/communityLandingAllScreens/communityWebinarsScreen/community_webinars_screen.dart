import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/communityRegisterNowScreen/community_register_now_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityWebinarsScreen/communityRegisteredUsersScreen/community_registered_users_screen.dart';
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

class CommunityWebinarsScreen extends StatefulWidget {
  const CommunityWebinarsScreen({super.key});

  @override
  State<CommunityWebinarsScreen> createState() =>
      _CommunityWebinarsScreenState();
}

class _CommunityWebinarsScreenState extends State<CommunityWebinarsScreen> {
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());
  CommunityWebinarsController communityWebinars =
      Get.put(CommunityWebinarsController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityEvents.getCommunityEvents().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  bool isWebinarEnded = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => communityEvents.isLoading.value
        ? Helper.pageLoading()
        : communityEvents.communityEventsData.webinars!.isEmpty
            ? const Center(
                child: TextWidget(text: "No Webinars Available", textSize: 16))
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: communityEvents.communityEventsData.webinars!.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: AppColors.navyBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (communityEvents.communityEventsData
                              .webinars![index].image.isNotEmpty) ...[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        // "https://bettermeetings.expert/wp-content/uploads/engaging-interactive-webinar-best-practices-and-formats.jpg",
                                        communityEvents.communityEventsData
                                            .webinars![index].image,
                                      ),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            sizedTextfield,
                          ],
                          Row(
                            children: [
                              TextWidget(
                                text: communityEvents
                                    .communityEventsData.webinars![index].title,
                                textSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              const Spacer(),
                              if (isAdmin) ...[
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.whiteCard,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    addServiceIndex = 3;
                                    Get.to(() => CommunityAddServiceScreen(
                                          webinarId: communityEvents
                                              .communityEventsData
                                              .webinars![index]
                                              .id,
                                          index: index,
                                          isEdit: true,
                                          isPriorityDM: false,
                                          isMeeting: false,
                                          isEvent: false,
                                          isWebinar: true,
                                        ));
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
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
                                                  communityEvents
                                                      .communityEventsData
                                                      .webinars![index]
                                                      .id);
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.white,
                                    )),
                                // IconButton(
                                //   padding: EdgeInsets.zero,
                                //   icon: Icon(
                                //     Icons.mobile_screen_share_rounded,
                                //     color: AppColors.whiteCard,
                                //   ),
                                //   onPressed: () {
                                //     sharePostPopup(
                                //         context, "", "share webinar detail");
                                //   },
                                // ),
                              ],
                              // if (!isAdmin)
                              //   IconButton(
                              //     padding: EdgeInsets.zero,
                              //     icon: Icon(
                              //       Icons.mobile_screen_share_rounded,
                              //       color: AppColors.whiteCard,
                              //     ),
                              //     onPressed: () {
                              //       sharePostPopup(
                              //           context, "", "share webinar detail");
                              //     },
                              //   ),
                            ],
                          ),
                          sizedTextfield,

                          if (!communityEvents.communityEventsData
                              .webinars![index].isActive) ...[
                            TextWidget(
                              text: "This webinar is cancelled.",
                              textSize: 16,
                              color: AppColors.grey,
                            ),
                            sizedTextfield
                          ],
                          HtmlWidget(
                            communityEvents.communityEventsData.webinars![index]
                                .description,
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: AppColors.white,
                            ),
                          ),
                          // TextWidget(
                          //   text: communityEvents
                          //       .communityWebinarsList[index].description,
                          //   textSize: 16,
                          // ),
                          sizedTextfield,
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: AppColors.white,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              TextWidget(
                                  text: communityEvents.communityEventsData
                                      .webinars![index].date,
                                  textSize: 16)
                            ],
                          ),
                          sizedTextfield,
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: AppColors.white,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                  text: communityEvents.communityEventsData
                                      .webinars![index].duration,
                                  textSize: 16)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: AppColors.white,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                  text:
                                      "${communityEvents.communityEventsData.webinars![index].joinedUsers.length} joined",
                                  textSize: 16)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: AppColors.white,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              TextWidget(
                                  text: communityEvents.communityEventsData
                                              .webinars![index].price ==
                                          "0"
                                      ? "Free"
                                      : "\u{20B9}${communityEvents.communityEventsData.webinars![index].price}",
                                  textSize: 16)
                            ],
                          ),
                          sizedTextfield,

                          if (isAdmin) ...[
                            AppButton.primaryButton(
                                onButtonPressed: () {
                                  Get.to(() => CommunityRegisteredUsersScreen(
                                      index: index));
                                },
                                title: "View Guests"),
                            sizedTextfield,
                          ],
                          if (!isAdmin &&
                              !communityEvents.communityEventsData
                                  .webinars![index].isExpired) ...[
                            AppButton.primaryButton(
                                onButtonPressed: () {
                                  Get.to(() =>
                                      CommunityRegisterNowScreen(index: index));
                                },
                                title: "+ Register Now"),
                            sizedTextfield,
                          ],
                          if (communityEvents
                              .communityEventsData.webinars![index].isExpired)
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(
                                  color: AppColors.redColor,
                                  width: 1,
                                ),
                              ),
                              color: AppColors.redColor.withOpacity(0.3),
                              child: const Padding(
                                padding: EdgeInsets.all(12),
                                child: TextWidget(
                                  text: "Webinar Time Expired",
                                  textSize: 16,
                                  color: AppColors.redColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
