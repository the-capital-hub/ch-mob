import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinar_model.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityProductsAndServicesScreen/communityEventsScreen/communityScheduleEventsScreen/community_schedule_events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/calendar/week_calendar.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectAvailabilityScreen extends StatefulWidget {
  int index;
  SelectAvailabilityScreen({required this.index, super.key});

  @override
  State<SelectAvailabilityScreen> createState() =>
      _SelectAvailabilityScreenState();
}

class _SelectAvailabilityScreenState extends State<SelectAvailabilityScreen> {
  var selectedDate;
  CommunityEventsController communityEvent =
      Get.put(CommunityEventsController());
  bool isDaySelected = false;
  bool isSlotSelected = false;
  int availabilityIndex = 0;
  int? selectedDayIndex;
  String day = "";
  String slot = "";
  String startTime = "";
  String endTime = "";
  List<String> availableDays = [];
  @override
  void initState() {
    super.initState();

    // Assuming communityWebinarsList has the structure and day contains the weekday as a string
    var availabilityList =
        communityEvent.communityEventList[widget.index].availability;

    // Loop through the availability list and extract the 'day' value
    if (availabilityList != null) {
      for (var availability in availabilityList) {
        if (availability.day != null) {
          availableDays.add(availability.day!); // Add the day to the list
        }
      }
    }

    print(availableDays); // Print the final list of available days
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: HelperAppBar.appbarHelper(
            title: "Select Time Slot",
            hideBack: false,
            autoAction: true,
          ),
          body: communityEvent
                  .communityEventList[widget.index].availability!.isEmpty
              ? const Center(
                  child:
                      TextWidget(text: "No Time Slot Available", textSize: 16),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     padding: EdgeInsets.zero,
                        //     itemCount: communityWebinars
                        //         .communityWebinarsList[widget.index]
                        //         .availability!
                        //         .length,
                        //     itemBuilder: (context, index) {
                        //       return InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isDaySelected = !isDaySelected;

                        //             day = isDaySelected
                        //                 ? communityWebinars
                        //                     .communityWebinarsList[widget.index]
                        //                     .availability![index]
                        //                     .day!
                        //                 : "";
                        //             availabilityIndex =
                        //                 isDaySelected ? index : 0;
                        //           });
                        //         },
                        //         child: Center(
                        //           child: Card(
                        //               color: AppColors.transparent,
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(20),
                        //                 side: const BorderSide(
                        //                   color: Colors.white38,
                        //                   width: 1,
                        //                 ),
                        //               ),
                        //               child: Padding(
                        //                 padding: EdgeInsets.all(12),
                        //                 child: TextWidget(
                        //                   text: communityWebinars
                        //                       .communityWebinarsList[
                        //                           widget.index]
                        //                       .availability![index]
                        //                       .day!,
                        //                   textSize: 16,
                        //                 ),
                        //               )),
                        //         ),
                        //       );
                        //     }),
                        // if (communityWebinars.isDaySelected)

                        CommunityEventsCalendar(
                          availableDays: availableDays,
                          index: widget.index,
                        ),
                        sizedTextfield,
                        // if(communityWebinars.isDaySelected)
                        // Wrap(
                        //   spacing: 4.0,
                        //   runSpacing: 4.0,
                        //   children: List.generate(
                        //     communityWebinars
                        //         .communityWebinarsList[widget.index]
                        //         .availability![
                        //             communityWebinars.selectedDayIndex]
                        //         .slots!
                        //         .length,
                        //     (index) {
                        //       bool isSlotSelected = _selectedIndex == index;
                        //       return communityWebinars
                        //               .communityWebinarsList[widget.index]
                        //               .availability![
                        //                   communityWebinars.selectedDayIndex]
                        //               .slots![index]
                        //               .isAvailable!
                        //           ? InkWell(
                        //               onTap: () {
                        //                 setState(() {
                        //                   isSlotSelected = !isSlotSelected;
                        //                   if (_selectedIndex == index) {
                        //                     _selectedIndex = null;
                        //                   } else {
                        //                     _selectedIndex = index;
                        //                   }

                        //                   slot = isSlotSelected
                        //                       ? "${communityWebinars.communityWebinarsList[widget.index].availability![communityWebinars.selectedDayIndex].slots![index].startTime} - ${communityWebinars.communityWebinarsList[widget.index].availability![communityWebinars.selectedDayIndex].slots![index].endTime}"
                        //                       : "";
                        //                   startTime = communityWebinars
                        //                       .communityWebinarsList[
                        //                           widget.index]
                        //                       .availability![communityWebinars
                        //                           .selectedDayIndex]
                        //                       .slots![index]
                        //                       .startTime!;
                        //                   endTime = communityWebinars
                        //                       .communityWebinarsList[
                        //                           widget.index]
                        //                       .availability![communityWebinars
                        //                           .selectedDayIndex]
                        //                       .slots![index]
                        //                       .endTime!;
                        //                 });
                        //               },
                        //               child: Card(
                        //                 shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(4),
                        //                 ),
                        //                 color: isSlotSelected
                        //                     ? AppColors.primary
                        //                     : AppColors.white12,
                        //                 surfaceTintColor: AppColors.white12,
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 12, vertical: 4),
                        //                   child: TextWidget(
                        //                     text:
                        //                         "${communityWebinars.communityWebinarsList[widget.index].availability![communityWebinars.selectedDayIndex].slots![index].startTime} - ${communityWebinars.communityWebinarsList[widget.index].availability![communityWebinars.selectedDayIndex].slots![index].endTime}",
                        //                     textSize: 14,
                        //                     color: AppColors.white,
                        //                   ),
                        //                 ),
                        //               ),
                        //             )
                        //           : const SizedBox.shrink();
                        //     },
                        //   ),
                        // ),
                        // ListView.builder(
                        //     shrinkWrap: true,
                        //     padding: EdgeInsets.zero,
                        //     itemCount: communityWebinars
                        //         .communityWebinarsList[widget.index]
                        //         .availability![index]
                        //         .slots!
                        //         .length,
                        //     itemBuilder: (context, innerIndex) {
                        //       return !communityWebinars
                        //               .communityWebinarsList[widget.index]
                        //               .availability![index]
                        //               .slots![innerIndex]
                        //               .isBooked!
                        //           ? InkWell(
                        //               onTap: () {
                        //                 setState(() {
                        //                   isSelected = !isSelected;
                        //                   day = isSelected
                        //                       ? communityWebinars
                        //                           .communityWebinarsList[
                        //                               widget.index]
                        //                           .availability![index]
                        //                           .day!
                        //                       : "";
                        //                   slot = isSelected
                        //                       ? "${communityWebinars.communityWebinarsList[widget.index].availability![index].slots![innerIndex].startTime} - ${communityWebinars.communityWebinarsList[widget.index].availability![index].slots![innerIndex].endTime}"
                        //                       : "";
                        //                 });
                        //               },
                        //               child: Center(
                        //                 child: Card(
                        //                   color: isSelected
                        //                       ? AppColors.primary
                        //                       : AppColors.transparent,
                        //                   shape: RoundedRectangleBorder(
                        //                     borderRadius:
                        //                         BorderRadius.circular(20),
                        //                     side: BorderSide(
                        //                       color: isSelected
                        //                           ? AppColors.transparent
                        //                           : AppColors.white38,
                        //                       width: 1,
                        //                     ),
                        //                   ),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(12),
                        //                     child: TextWidget(
                        //                       text:
                        //                           "${communityWebinars.communityWebinarsList[widget.index].availability![index].slots![innerIndex].startTime} - ${communityWebinars.communityWebinarsList[widget.index].availability![index].slots![innerIndex].endTime}",
                        //                       textSize: 16,
                        //                       color: AppColors.white,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             )
                        //           : const SizedBox.shrink();
                        //     }),
                        // ],
                        // );
                        // }),

                        Row(
                          children: [
                            Expanded(
                              child: AppButton.outlineButton(
                                  borderColor:
                                      GetStoreData.getStore.read('isInvestor')
                                          ? AppColors.primaryInvestor
                                          : AppColors.primary,
                                  onButtonPressed: () {
                                    Get.back();
                                    setState(() {
                                      communityEvent.formattedDate = "";
                                      communityEvent.selectedDayName = "";
                                      communityEvent.selectedDayIndex = 0;
                                      communityEvent.isDaySelected = false;
                                      communityEvent.slot = "";
                                      communityEvent.startTime = "";
                                      communityEvent.endTime = "";
                                    });
                                  },
                                  title: "Cancel"),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                child: AppButton.primaryButton(
                                    onButtonPressed: () async {
                                      // selectedDate = await selectDate(
                                      //     context, DateTime.now());

                                      // communityWebinars.formattedDate =
                                      //     DateFormat('MMMM d')
                                      //         .format(selectedDate);

                                      communityEvent.formattedDate != "" &&
                                              communityEvent.slot != ""
                                          ? Get.to(() =>
                                              CommunityScheduleEventsScreen(
                                                day: communityEvent
                                                    .formattedDate,
                                                slot: communityEvent.slot,
                                                index: widget.index,
                                                startTime:
                                                    communityEvent.startTime,
                                                endTime:
                                                    communityEvent.endTime,
                                              ))
                                          : HelperSnackBar.snackBar("Error",
                                              "Select a Time Slot for Booking");
                                    },
                                    title: "Confirm Booking"))
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
