import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/communityMeetingBookingsScreen/community_meeting_bookings_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityMeetingsScreen extends StatefulWidget {
  const CommunityMeetingsScreen({super.key});

  @override
  State<CommunityMeetingsScreen> createState() =>
      _CommunityMeetingScreenState();
}

class _CommunityMeetingScreenState extends State<CommunityMeetingsScreen> {
  CommunityMeetingsController communityMeetings =
      Get.put(CommunityMeetingsController());
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityMeetings.getCommunityMeetings().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  bool isBooked = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() => communityMeetings.isLoading.value
        ? Helper.pageLoading()
        : communityMeetings.communityMeetingsList.isEmpty
            ? const Center(
                child: TextWidget(text: "No Meetings Available", textSize: 16))
            : ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: communityMeetings.communityMeetingsList.length,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text:
                                    "${communityMeetings.communityMeetingsList[index].title}",
                                textSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.mobile_screen_share_rounded,
                                  color: AppColors.white,
                                ),
                                onPressed: () {
                                  sharePostPopup(
                                      context, "", "share meeting details");
                                },
                              )
                            ],
                          ),
                          sizedTextfield,
                          HtmlWidget(
                            "${communityMeetings.communityMeetingsList[index].description}",
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: AppColors.white,
                            ),
                          ),
                          // TextWidget(
                          //   text: communityMeetings
                          //       .communityMeetingsList[index].description,
                          //   textSize: 15,
                          // ),
                          sizedTextfield,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                  text:
                                      "Duration : ${communityMeetings.communityMeetingsList[index].duration} minutes",
                                  textSize: 16),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                color: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(
                                    text: communityMeetings
                                                .communityMeetingsList[index]
                                                .amount ==
                                            0
                                        ? "Free"
                                        : "\u{20B9} ${communityMeetings.communityMeetingsList[index].amount}",
                                    textSize: 10,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                          sizedTextfield,
                          if (communityMeetings
                              .communityMeetingsList[index].topics!.isNotEmpty)
                            Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: List.generate(
                                  communityMeetings.communityMeetingsList[index]
                                      .topics!.length, (innerIndex) {
                                return InkWell(
                                  onTap: () {},
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    color: AppColors.white12,
                                    surfaceTintColor: AppColors.white12,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: TextWidget(
                                          text: communityMeetings
                                              .communityMeetingsList[index]
                                              .topics![innerIndex],
                                          textSize: 14),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (isAdmin)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppButton.primaryButton(
                                    onButtonPressed: () {
                                      Get.to(() =>
                                          CommunityMeetingBookingsScreen(
                                              index: index));
                                    },
                                    title:
                                        "View Bookings (${communityMeetings.communityMeetingsList[index].bookings!.length})",
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                    onPressed: () {
                                      addServiceIndex = 1;
                                      Get.to(() => CommunityAddServiceScreen(
                                            isEdit: true,
                                            index: index,
                                            isPriorityDM: false,
                                            isMeeting: true,
                                            isEvent: false,
                                            isWebinar: false,
                                            meetingId: communityMeetings
                                                .communityMeetingsList[index]
                                                .id,
                                          ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppColors.white,
                                    )),
                                const SizedBox(width: 8),
                                IconButton(
                                    onPressed: () {
                                      showCustomPopup(
                                        context: context,
                                        title: "Delete this meeting",
                                        message:
                                            "Are you sure you\n want to delete this meeting?",
                                        button1Text: "Cancel",
                                        button2Text: "OK",
                                        icon: Icons.delete,
                                        onButton1Pressed: () {
                                          Get.back();
                                        },
                                        onButton2Pressed: () {
                                          communityMeetings
                                              .deleteCommunityMeeting(
                                                  communityMeetings
                                                      .communityMeetingsList[
                                                          index]
                                                      .id
                                                      .toString());
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.white,
                                    )),
                              ],
                            ),
                          if (!isAdmin)
                            AppButton.primaryButton(
                              onButtonPressed: () {
                                DateTime customDate = DateTime(2023, 12, 31);
                                selectDate(context, customDate);
                              },
                              title: "Book Meeting",
                            ),
                          if (isBooked)
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: AppColors.green,
                                  width: 1,
                                ),
                              ),
                              color: AppColors.green.withOpacity(0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    AppButton.primaryButton(
                                        onButtonPressed: () {},
                                        title: "Booked!",
                                        bgColor: AppColors.green700),
                                    sizedTextfield,
                                    const TextWidget(
                                      text: "March 13, 2024",
                                      textSize: 16,
                                    ),
                                    sizedTextfield,
                                    const TextWidget(
                                      text: "09:00 - 09:30",
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
