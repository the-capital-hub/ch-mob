import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityAddServiceScreen/community_add_service_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityEventsScreen/communityBookingDetailsScreen/community_booking_details_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityEventsScreen/communityScheduleEventsScreen/community_schedule_events_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityEventsScreen/communitySelectAvailabilityScreen/community_select_availability_screen.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityEventsScreen/community_add_events_screen.dart';
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
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());
  bool _isExpanded = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      communityEvents.getCommunityEvent().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            communityEvents.formattedDate = "";
            communityEvents.selectedDayName = "";
            communityEvents.selectedDayIndex = 0;
            communityEvents.isDaySelected = false;
            communityEvents.slot = "";
            communityEvents.startTime = "";
            communityEvents.endTime = "";
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                onPressed: () {
                  Get.to(() => CommunityAddEventsScreen(
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
        body: Obx(() => communityEvents.isLoading.value
            ? Helper.pageLoading()
            : communityEvents.communityEventList.isEmpty
                ? const Center(
                    child: TextWidget(
                        text: "No Community Events Available", textSize: 16))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 6),
                          itemCount: communityEvents.communityEventList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: AppColors.blackCard,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        TextWidget(
                                          text: communityEvents
                                              .communityEventList[index].title!,
                                          textSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const Spacer(),
                                        if (isAdmin) ...[
                                          InkWell(
                                            onTap: () {
                                              Get.to(() =>
                                                  CommunityAddEventsScreen(
                                                      isEdit: true,
                                                      events: communityEvents
                                                              .communityEventList[
                                                          index]));
                                            },
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: AppColors
                                                  .green700
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
                                                          communityEvents
                                                              .communityEventList[
                                                                  index]
                                                              .eventId);
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: AppColors
                                                  .redColor
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
                                                communityEvents
                                                    .communityEventList[index]
                                                    .eventSharelink!);
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor:
                                                AppColors.blue.withOpacity(0.8),
                                            child: Icon(
                                                Icons
                                                    .mobile_screen_share_rounded,
                                                color: AppColors.whiteCard,
                                                size: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    HtmlWidget(
                                      _isExpanded
                                          ? communityEvents
                                              .communityEventList[index]
                                              .description!
                                          : communityEvents
                                                      .communityEventList[index]
                                                      .description!
                                                      .length >
                                                  200
                                              ? "${communityEvents.communityEventList[index].description!.substring(0, 200)} ..."
                                              : communityEvents
                                                  .communityEventList[index]
                                                  .description!,
                                      textStyle: TextStyle(
                                          fontSize: (MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  375) *
                                              12,
                                          color: AppColors.white),
                                    ),
                                    if (communityEvents
                                            .communityEventList[index]
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
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    sizedTextfield,
                                    Card(
                                      margin: const EdgeInsets.all(0),
                                      color: AppColors.white12,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  color: GetStoreData.getStore
                                                          .read('isInvestor')
                                                      ? AppColors
                                                          .primaryInvestor
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
                                                        "${communityEvents.communityEventList[index].duration} Minutes",
                                                    textSize: 14),
                                                TextWidget(
                                                    text:
                                                        "${communityEvents.communityEventList[index].bookings!.length} Bookings",
                                                    textSize: 14),
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColors.whiteShade,
                                                    width: 1),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextWidget(
                                                      text: communityEvents
                                                                  .communityEventList[
                                                                      index]
                                                                  .price ==
                                                              0
                                                          ? "Free"
                                                          : "\u{20B9} ${communityEvents.communityEventList[index].price}",
                                                      textSize: 12),
                                                  const SizedBox(width: 4),
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
                                    isAdmin
                                        ? AppButton.primaryButton(
                                            height: 40,
                                            onButtonPressed: () {
                                              Get.to(() =>
                                                  CommunityBookingDetailsScreen(
                                                      index: index));
                                            },
                                            title: "View All Bookings")
                                        : AppButton.primaryButton(
                                            height: 40,
                                            onButtonPressed: () {
                                              Get.to(() =>
                                                  SelectAvailabilityScreen(
                                                      index: index));
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
                  )));
  }
}
