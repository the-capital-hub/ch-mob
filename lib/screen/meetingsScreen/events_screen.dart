import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/create_events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  MeetingController eventController = Get.put(MeetingController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      eventController.getEvents().then((v) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: GetStoreData.getStore.read('isInvestor')
            ? const DrawerWidgetInvestor()
            : const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
            title: "Events", hideBack: true, autoAction: true),
        body: Obx(() => Padding(
            padding: const EdgeInsets.all(10.0),
            child: eventController.isLoading.value
                ? Helper.pageLoading()
                : eventController.eventsList.isEmpty
                    ? const Center(
                        child: TextWidget(
                            text: "No Events Available", textSize: 16))
                    : ListView.separated(
                        itemCount: eventController.eventsList.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: AppColors.blackCard,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                      text: eventController
                                          .eventsList[index].title,
                                      fontWeight: FontWeight.w500,
                                      textSize: 18),
                                  eventController.eventsList[index].isActive
                                      ? const SizedBox()
                                      : TextWidget(
                                          text: "This meeting is cancelled.",
                                          textSize: 15,
                                          color: AppColors.grey,
                                        ),
                                  const SizedBox(height: 8),
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
                                                  text: eventController
                                                      .eventsList[index]
                                                      .duration
                                                      .toString(),
                                                  textSize: 15),
                                              const TextWidget(
                                                  text: "Video Meeting",
                                                  textSize: 14),
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 5),
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
                                                        "Rs ${eventController.eventsList[index].price} +",
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: eventController
                                                  .eventsList[index].isActive
                                              ? () async {
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: eventController
                                                              .eventsList[index]
                                                              .url));

                                                  HelperSnackBar.snackBar(
                                                      "Success",
                                                      "Link copied to clipboard!");
                                                }
                                              : null,
                                          icon: Icon(Icons.file_copy_outlined,
                                              color: AppColors.white, size: 14),
                                          label: const TextWidget(
                                              text: "Copy Link", textSize: 14),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.blue,
                                            disabledBackgroundColor:
                                                AppColors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: AppButton.primaryButton(
                                            height: 40,
                                            onButtonPressed: eventController
                                                    .eventsList[index].isActive
                                                ? () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .blackCard,
                                                          title:
                                                              const TextWidget(
                                                            text:
                                                                'Are you sure you want to cancel this event?',
                                                            textSize: 16,
                                                            maxLine: 2,
                                                          ),
                                                          content: TextWidget(
                                                            text:
                                                                'No. of People who have booked this event : ${eventController.eventsList[index].bookings.length}',
                                                            textSize: 16,
                                                            maxLine: 2,
                                                          ),
                                                          actions: [
                                                            AppButton
                                                                .primaryButton(
                                                              title:
                                                                  'Cancel Event',
                                                              onButtonPressed:
                                                                  () {
                                                                Get.back();
                                                                Helper.loader(
                                                                    context);
                                                                eventController.disableEvent(
                                                                    eventController
                                                                        .eventsList[
                                                                            index]
                                                                        .id);

                                                                eventController
                                                                    .getEvents();
                                                              },
                                                            ),
                                                            sizedTextfield,
                                                            AppButton
                                                                .outlineButton(
                                                              borderColor:
                                                                  AppColors
                                                                      .primary,
                                                              title: 'Back',
                                                              onButtonPressed:
                                                                  () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                : null,
                                            title: "Cancel Event",
                                            fontSize: 14,
                                            bgColor: eventController
                                                    .eventsList[index].isActive
                                                ? AppColors.redColor
                                                : AppColors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ))),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(() => const CreateEventsScreen());
            },
            title: "+ Create Event",
          ),
        ),
      ),
    );
  }
}
