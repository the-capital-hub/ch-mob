import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityMeetingsScreen/communityBookAMeetingScreen/community_book_a_meeting_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityMeetingsScreen/communityMeetingBookingsScreen/community_meeting_bookings_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityMeetingsScreen/communitySelectTimeSlotScreen/community_select_time_slot_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityMeetingsScreen/community_add_meeting_screen.dart';
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

import '../../../../../utils/getStore/get_store.dart';

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
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => CommunityAddMeetingScreen(
                        isEdit: false,
                      ));
                },
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.add, color: AppColors.white),
              )
            : null,
        backgroundColor: AppColors.transparent,
        body: Obx(() => communityMeetings.isLoading.value
            ? Helper.pageLoading()
            : communityMeetings.communityMeetingsList.isEmpty
                ? const Center(
                    child:
                        TextWidget(text: "No Meetings Available", textSize: 16))
                : ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 6),
                    padding: EdgeInsets.zero,
                    itemCount: communityMeetings.communityMeetingsList.length,
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text:
                                              "${communityMeetings.communityMeetingsList[index].title}",
                                          textSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(height: 6),
                                        HtmlWidget(
                                          _isExpanded
                                              ? "${communityMeetings.communityMeetingsList[index].description}"
                                              : communityMeetings
                                                          .communityMeetingsList[
                                                              index]
                                                          .description!
                                                          .length >
                                                      200
                                                  ? "${communityMeetings.communityMeetingsList[index].description!.substring(0, 200)} ..."
                                                  : communityMeetings
                                                      .communityMeetingsList[
                                                          index]
                                                      .description!,
                                          textStyle: TextStyle(
                                              fontSize: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      375) *
                                                  12,
                                              color: AppColors.white),
                                        ),
                                        if (communityMeetings
                                                .communityMeetingsList[index]
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
                                                _isExpanded
                                                    ? "Read Less"
                                                    : "Read More",
                                                style: const TextStyle(
                                                    color: AppColors.blue,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        const SizedBox(height: 6),
                                        TextWidget(
                                            text:
                                                "Response Time: ${communityMeetings.communityMeetingsList[index].duration} minutes",
                                            textSize: 16),
                                        const SizedBox(height: 6),
                                        if (communityMeetings
                                            .communityMeetingsList[index]
                                            .topics!
                                            .isNotEmpty)
                                          Wrap(
                                            spacing: 4.0,
                                            runSpacing: 4.0,
                                            children: List.generate(
                                                communityMeetings
                                                    .communityMeetingsList[
                                                        index]
                                                    .topics!
                                                    .length, (innerIndex) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  color: AppColors.white12,
                                                  surfaceTintColor:
                                                      AppColors.white12,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    child: TextWidget(
                                                        text: communityMeetings
                                                            .communityMeetingsList[
                                                                index]
                                                            .topics![innerIndex],
                                                        textSize: 14),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          sharePostPopup(
                                              context,
                                              "",
                                              communityMeetings
                                                  .communityMeetingsList[index]
                                                  .meetingSharelink!);
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
                                      const SizedBox(height: 6),
                                      if (isAdmin)
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => CommunityAddMeetingScreen(
                                                isEdit: true,
                                                communityMeetings:
                                                    communityMeetings
                                                            .communityMeetingsList[
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
                                      const SizedBox(height: 6),
                                      if (isAdmin)
                                        InkWell(
                                          onTap: () {
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
                                                Get.back();
                                                Helper.loader(context);
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
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    margin: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    color: AppColors.primary,
                                    child: SizedBox(
                                      width: 80,
                                      height: 40,
                                      child: Center(
                                        child: TextWidget(
                                          text: communityMeetings
                                                      .communityMeetingsList[
                                                          index]
                                                      .amount ==
                                                  0
                                              ? "Free"
                                              : "\u{20B9} ${communityMeetings.communityMeetingsList[index].amount}",
                                          textSize: 14,
                                          color: AppColors.whiteCard,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  if (isAdmin)
                                    Expanded(
                                      child: AppButton.outlineButton(
                                        borderColor: GetStoreData.getStore
                                                .read('isInvestor')
                                            ? AppColors.primaryInvestor
                                            : AppColors.primary,
                                        height: 40,
                                        onButtonPressed: () {
                                          Get.to(() =>
                                              CommunityMeetingBookingsScreen(
                                                  index: index));
                                        },
                                        title:
                                            "View Bookings (${communityMeetings.communityMeetingsList[index].bookings!.length})",
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Row(
                                        children: [
                                          if (communityMeetings
                                              .communityMeetingsList[index]
                                              .isExpired!)
                                            Expanded(
                                              child: Card(
                                                margin: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  side: const BorderSide(
                                                    color: AppColors.redColor,
                                                    width: 1,
                                                  ),
                                                ),
                                                color: AppColors.redColor
                                                    .withOpacity(0.3),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 9),
                                                  child: Center(
                                                    child: TextWidget(
                                                      text:
                                                          "Meeting Time Expired",
                                                      textSize: 16,
                                                      color: AppColors.redColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (!(communityMeetings
                                                  .communityMeetingsList[index]
                                                  .isExpired! ||
                                              communityMeetings
                                                  .communityMeetingsList[index]
                                                  .isBookedByMe!))
                                            Expanded(
                                              child: AppButton.primaryButton(
                                                height: 40,
                                                onButtonPressed: () {
                                                  Get.to(() =>
                                                      CommunityBookAMeetingScreen(
                                                        index: index,
                                                      ));
                                                },
                                                title: "Book Meeting",
                                              ),
                                            ),
                                          if (communityMeetings
                                              .communityMeetingsList[index]
                                              .isBookedByMe!) ...[
                                            Expanded(
                                              child: AppButton.primaryButton(
                                                  height: 40,
                                                  onButtonPressed: () {},
                                                  title: "Booked!",
                                                  bgColor: AppColors.green700),
                                            )
                                          ]
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          context,
                                          "",
                                          communityMeetings
                                              .communityMeetingsList[index]
                                              .meetingSharelink!);
                                    },
                                  )
                                ],
                              ),
                              sizedTextfield,
                              // HtmlWidget(
                              //   // "${communityMeetings.communityMeetingsList[index].description}",
                              //    communityMeetings.communityMeetingsList[index].description!.replaceAll(RegExp(r'\n\s*\n'), '\n'),
                              //   textStyle: TextStyle(
                              //     fontSize: 15,
                              //     color: AppColors.white,
                              //   ),
                              // ),
                              // TextWidget(
                              //   text: communityMeetings
                              //       .communityMeetingsList[index].description,
                              //   textSize: 15,
                              // ),
                              HtmlWidget(
                                _isExpanded
                                    ? "${communityMeetings.communityMeetingsList[index].description!.replaceAll(RegExp(r'\n\s*\n'), '\n')}"
                                    : communityMeetings
                                                .communityMeetingsList[index]
                                                .description!
                                                .replaceAll(
                                                    RegExp(r'\n\s*\n'), '\n')
                                                .length >
                                            200
                                        ? "${communityMeetings.communityMeetingsList[index].description!.replaceAll(RegExp(r'\n\s*\n'), '\n').substring(0, 200)} ..."
                                        : communityMeetings
                                            .communityMeetingsList[index]
                                            .description!
                                            .replaceAll(
                                                RegExp(r'\n\s*\n'), '\n'),
                                textStyle: TextStyle(
                                    fontSize:
                                        (MediaQuery.of(context).size.width /
                                                375) *
                                            12,
                                    color: AppColors.white),
                              ),
                              if (communityMeetings
                                      .communityMeetingsList[index].description!
                                      .replaceAll(RegExp(r'\n\s*\n'), '\n')
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

                              sizedTextfield,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                      text:
                                          "Duration : ${communityMeetings.communityMeetingsList[index].duration} minutes",
                                      textSize: 16),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextWidget(
                                        text: communityMeetings
                                                    .communityMeetingsList[
                                                        index]
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
                              if (communityMeetings.communityMeetingsList[index]
                                  .topics!.isNotEmpty) ...[
                                Wrap(
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: List.generate(
                                      communityMeetings
                                          .communityMeetingsList[index]
                                          .topics!
                                          .length, (innerIndex) {
                                    return InkWell(
                                      onTap: () {},
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
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
                              ],
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
                                          Get.to(() => CommunityAddMeetingScreen(
                                              isEdit: true,
                                              communityMeetings:
                                                  communityMeetings
                                                          .communityMeetingsList[
                                                      index]));
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
                                              Get.back();
                                              Helper.loader(context);
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
                              if (communityMeetings
                                  .communityMeetingsList[index].isExpired!) ...[
                                sizedTextfield,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          side: const BorderSide(
                                            color: AppColors.redColor,
                                            width: 1,
                                          ),
                                        ),
                                        color:
                                            AppColors.redColor.withOpacity(0.3),
                                        child: const Padding(
                                          padding: EdgeInsets.all(12),
                                          child: Center(
                                            child: TextWidget(
                                              text: "Meeting Time Expired",
                                              textSize: 16,
                                              color: AppColors.redColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizedTextfield,
                              ],

                              if (!isAdmin &&
                                  !communityMeetings
                                      .communityMeetingsList[index].isExpired!)
                                AppButton.primaryButton(
                                  onButtonPressed: () {
                                    // Get.to(() => CommunitySelectTimeSlotScreen(
                                    //       index: index,
                                    //     ));
                                    Get.to(() => CommunityBookAMeetingScreen(
                                          index: index,
                                        ));
                                  },
                                  title: "Book Meeting",
                                ),
                              if (communityMeetings.communityMeetingsList[index]
                                  .isBookedByMe!) ...[
                                sizedTextfield,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                            color: AppColors.green,
                                            width: 1,
                                          ),
                                        ),
                                        color: AppColors.green.withOpacity(0.3),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                AppButton.primaryButton(
                                                    onButtonPressed: () {},
                                                    title: "Booked!",
                                                    bgColor:
                                                        AppColors.green700),
                                                sizedTextfield,
                                                TextWidget(
                                                  text: communityMeetings
                                                      .communityMeetingsList[
                                                          index]
                                                      .availability![0]
                                                      .day!,
                                                  textSize: 16,
                                                ),
                                                sizedTextfield,
                                                TextWidget(
                                                  text:
                                                      "${communityMeetings.communityMeetingsList[index].availability![0].slots![0].startTime} - ${communityMeetings.communityMeetingsList[index].availability![0].slots![0].endTime}",
                                                  textSize: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }
}
