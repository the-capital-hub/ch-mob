import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/communityBookingDetailsScreen/community_booking_details_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/communityScheduleEventsScreen/community_schedule_events_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityEventsScreen/communitySelectAvailabilityScreen/community_select_availability_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dilogue/custom_dialogue.dart';
import 'package:capitalhub_crm/widget/dilogue/share_dilogue.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityEventsScreen extends StatefulWidget {
  const CommunityEventsScreen({super.key});

  @override
  State<CommunityEventsScreen> createState() => _CommunityEventsScreenState();
}

class _CommunityEventsScreenState extends State<CommunityEventsScreen> {
  CommunityWebinarsController communityWebinars =
      Get.put(CommunityWebinarsController());
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());
  bool _isExpanded = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityWebinars.getCommunityWebinars().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            communityWebinars.formattedDate = "";
            communityWebinars.selectedDayName = "";
            communityWebinars.selectedDayIndex = 0;
            communityWebinars.isDaySelected = false;
            communityWebinars.slot = "";
            communityWebinars.startTime = "";
            communityWebinars.endTime = "";
          });
        });
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
    return Obx(() => communityWebinars.isLoading.value
        ? Helper.pageLoading()
        : communityWebinars.communityWebinarsList.isEmpty
            ? const Center(
                child: TextWidget(
                    text: "No Community Events Available", textSize: 16))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: communityWebinars.communityWebinarsList.length,
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
                                Row(
                                  children: [
                                    TextWidget(
                                        text: communityWebinars
                                            .communityWebinarsList[index]
                                            .title!,
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
                                                    eventId: communityWebinars
                                                        .communityWebinarsList[
                                                            index]
                                                        .eventId,
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
                                                Get.back();
                                                Helper.loader(context);
                                                communityEvents
                                                    .disableCommunityEvent(
                                                        communityWebinars
                                                            .communityWebinarsList[
                                                                index]
                                                            .eventId);
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
                                            sharePostPopup(
                                                context,
                                                "",
                                                communityWebinars
                                                    .communityWebinarsList[
                                                        index]
                                                    .eventSharelink!);
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
                                        sharePostPopup(
                                            context,
                                            "",
                                            communityWebinars
                                                .communityWebinarsList[index]
                                                .eventSharelink!);
                                      },
                                    ),
                                  ],
                                ),
                                // communityWebinars.communityWebinarsList
                                //         [index].isActive
                                //     ? const SizedBox()
                                //     : TextWidget(
                                //         text: "This meeting is cancelled.",
                                //         textSize: 16,
                                //         color: AppColors.grey,
                                //       ),
                                const SizedBox(height: 8),
                                // HtmlWidget(
                                //   communityWebinars.communityWebinarsList[index]
                                //       .description!,
                                //   textStyle: TextStyle(
                                //     fontSize: 16,
                                //     color: AppColors.white,
                                //   ),
                                // ),
                                HtmlWidget(
                                  _isExpanded
                                      ? "${communityWebinars.communityWebinarsList[index].description!}"
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
                                              color: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary),
                                          child: Center(
                                            child: Image.asset(
                                              PngAssetPath.meetingIcon,
                                              color: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.black
                                                  : AppColors.white,
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
                                                text:
                                                    "${communityWebinars.communityWebinarsList[index].duration} Minutes",
                                                textSize: 15),
                                            TextWidget(
                                                text:
                                                    "${communityWebinars.communityWebinarsList[index].bookings!.length} Bookings",
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
                                                  text: communityWebinars
                                                              .communityWebinarsList[
                                                                  index]
                                                              .price ==
                                                          0
                                                      ? "Free"
                                                      : "\u{20B9}${communityWebinars.communityWebinarsList[index].price}",
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
                                            CommunityBookingDetailsScreen(
                                                index: index));
                                      },
                                      title: "View All Bookings"),
                                if (!isAdmin)
                                  AppButton.primaryButton(
                                      onButtonPressed: () {
                                        Get.to(() => SelectAvailabilityScreen(
                                            index: index));
                                        //     Get.to(() =>
                                        // CommunityScheduleEventsScreen(
                                        //     index: index));
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
