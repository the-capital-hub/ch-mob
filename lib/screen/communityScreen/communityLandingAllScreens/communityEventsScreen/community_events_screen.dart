import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/communityBookingDetailsScreen/community_booking_details_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/communityScheduleEventsScreen/community_schedule_events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CommunityEventsScreen extends StatefulWidget {
  const CommunityEventsScreen({super.key});

  @override
  State<CommunityEventsScreen> createState() => _CommunityEventsScreenState();
}

class _CommunityEventsScreenState extends State<CommunityEventsScreen> {
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityEvents.getCommunityEvents().then((v) {
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
  @override
  Widget build(BuildContext context) {
    return Obx(() => communityEvents.isLoading.value
        ? Helper.pageLoading()
        : communityEvents.communityEventsData.webinars!.isEmpty
            ? const Center(
                child: TextWidget(
                    text: "No Community Events Available", textSize: 16))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          communityEvents.communityEventsData.webinars!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Color containerColor =
                            containerColors[index % containerColors.length];

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: containerColor,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isAdmin)
                                  Row(
                                    children: [
                                      TextWidget(
                                          text: communityEvents
                                              .communityEventsData
                                              .webinars![index]
                                              .title,
                                          textSize: 20),
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
                                            addServiceIndex = 2;
                                            Get.to(
                                                () => CommunityAddServiceScreen(
                                                      eventId: communityEvents
                                                          .communityEventsData
                                                          .webinars![index]
                                                          .id,
                                                      index: index,
                                                      isEdit: true,
                                                      isPriorityDM: false,
                                                      isMeeting: false,
                                                      isEvent: true,
                                                      isWebinar: false,
                                                    ));
                                          },
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showCustomPopup(
                                                context: context,
                                                title: "Disable this event",
                                                message:
                                                    "Are you sure you\nwant to disable this event?",
                                                button1Text: "Cancel",
                                                button2Text: "OK",
                                                icon: Icons.delete,
                                                onButton1Pressed: () {
                                                  Get.back();
                                                },
                                                onButton2Pressed: () {
                                                  communityEvents
                                                      .disableCommunityEvent(
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
                                        if (!isAdmin)
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                              Icons.mobile_screen_share_rounded,
                                              color: AppColors.whiteCard,
                                            ),
                                            onPressed: () {
                                              sharePostPopup(context, "",
                                                  "share event detail");
                                            },
                                          ),
                                      ],
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(
                                          Icons.mobile_screen_share_rounded,
                                          color: AppColors.whiteCard,
                                        ),
                                        onPressed: () {
                                          sharePostPopup(context, "",
                                              "share event detail");
                                        },
                                      ),
                                    ],
                                  ),
                                communityEvents.communityEventsData
                                        .webinars![index].isActive
                                    ? const SizedBox()
                                    : TextWidget(
                                        text: "This meeting is cancelled.",
                                        textSize: 16,
                                        color: AppColors.grey,
                                      ),
                                const SizedBox(height: 8),
                                const TextWidget(
                                    text: "Description", textSize: 16),
                                sizedTextfield,
                                Card(
                                  color: AppColors.white38,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              color: AppColors.primary),
                                          child: Center(
                                            child: Image.asset(
                                              PngAssetPath.meetingIcon,
                                              color: AppColors.white,
                                              height: 22,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                                text: communityEvents
                                                    .communityEventsData
                                                    .webinars![index]
                                                    .duration
                                                    .toString(),
                                                textSize: 15),
                                            const TextWidget(
                                                text: "0 Bookings",
                                                textSize: 15),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: AppColors.white,
                                                width: 1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                  text:
                                                      "Rs ${communityEvents.communityEventsData.webinars![index].price} +",
                                                  textSize: 12),
                                              const SizedBox(width: 5),
                                              Icon(Icons.arrow_forward,
                                                  color: AppColors.white,
                                                  size: 12),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                sizedTextfield,
                                if (isAdmin)
                                  AppButton.primaryButton(
                                      onButtonPressed: () {
                                        Get.to(() =>
                                            const CommunityBookingDetailsScreen());
                                      },
                                      title: "View All Bookings"),
                                if (!isAdmin)
                                  AppButton.primaryButton(
                                      onButtonPressed: () {
                                        Get.to(() =>
                                            const CommunityScheduleEventsScreen());
                                      },
                                      title: "Book Now")
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ));
  }
}
