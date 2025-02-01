import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_availability_model.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

// class AvailabilityScreen extends StatefulWidget {
//   const AvailabilityScreen({super.key});

//   @override
//   State<AvailabilityScreen> createState() => _AvailabilityScreenState();
// }

// class _AvailabilityScreenState extends State<AvailabilityScreen> {
//   final List<String> daysOfWeek = [
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday',
//     'Friday',
//     'Saturday',
//     'Sunday'
//   ];

//   List<bool> isChecked = [false, false, false, false, false, false, false];

//   List<TimeOfDay> startTimes = [
//     const TimeOfDay(hour: 9, minute: 0),
//     const TimeOfDay(hour: 9, minute: 0),
//     const TimeOfDay(hour: 9, minute: 0),
//     const TimeOfDay(hour: 9, minute: 0),
//     const TimeOfDay(hour: 9, minute: 0),
//     const TimeOfDay(hour: 9, minute: 0),
//     const TimeOfDay(hour: 9, minute: 0),
//   ];

//   List<TimeOfDay> endTimes = [
//     const TimeOfDay(hour: 17, minute: 0),
//     const TimeOfDay(hour: 17, minute: 0),
//     const TimeOfDay(hour: 17, minute: 0),
//     const TimeOfDay(hour: 17, minute: 0),
//     const TimeOfDay(hour: 17, minute: 0),
//     const TimeOfDay(hour: 17, minute: 0),
//     const TimeOfDay(hour: 17, minute: 0),
//   ];

//   int selectedMinutes = 15;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: bgDec,
//         child: Scaffold(
//             drawer: const DrawerWidget(),
//             backgroundColor: AppColors.transparent,
//             appBar: HelperAppBar.appbarHelper(
//                 title: "Availability", hideBack: true, autoAction: true),
//             body: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Card(
//                 color: AppColors.blackCard,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Flexible(
//                         child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           itemCount: daysOfWeek.length,
//                           itemBuilder: (context, index) {
//                             return Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Checkbox(
//                                       value: isChecked[index],
//                                       activeColor: AppColors.primary,
//                                       onChanged: (bool? value) {
//                                         setState(() {
//                                           isChecked[index] = value!;
//                                         });
//                                       },
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                     ),
//                                     TextWidget(
//                                       text: daysOfWeek[index],
//                                       textSize: 16,
//                                     ),
//                                   ],
//                                 ),
//                                 if (isChecked[index])
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         InkWell(
//                                           child: Container(
//                                             padding: const EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 color: AppColors.grey700,
//                                                 width: 1,
//                                               ),
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 TextWidget(
//                                                     text: startTimes[index]
//                                                         .format(context),
//                                                     textSize: 16),
//                                                 const SizedBox(width: 8),
//                                                 Icon(
//                                                   Icons.schedule,
//                                                   color: AppColors.white,
//                                                   size: 20,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           onTap: () async {
//                                             DateTime? selectedTime =
//                                                 await selectTime(
//                                                     context, false);
//                                             if (selectedTime != null) {
//                                               setState(() {
//                                                 startTimes[index] = TimeOfDay(
//                                                     hour: selectedTime.hour,
//                                                     minute:
//                                                         selectedTime.minute);
//                                               });
//                                             }
//                                           },
//                                         ),
//                                         const SizedBox(width: 12),
//                                         const TextWidget(
//                                           text: "to",
//                                           textSize: 16,
//                                         ),
//                                         const SizedBox(width: 12),
//                                         InkWell(
//                                           child: Container(
//                                             padding: const EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 color: AppColors.grey700,
//                                                 width: 1,
//                                               ),
//                                             ),
//                                             child: Row(
//                                               children: [
//                                                 TextWidget(
//                                                   text: endTimes[index]
//                                                       .format(context),
//                                                   textSize: 16,
//                                                 ),
//                                                 const SizedBox(width: 8),
//                                                 Icon(
//                                                   Icons.schedule,
//                                                   color: AppColors.white,
//                                                   size: 20,
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           onTap: () async {
//                                             DateTime? selectedEndTime =
//                                                 await selectTime(
//                                                     context, false);
//                                             if (selectedEndTime != null) {
//                                               if (selectedEndTime.hour ==
//                                                       startTimes[index].hour &&
//                                                   selectedEndTime.minute ==
//                                                       startTimes[index]
//                                                           .minute) {
//                                                 ScaffoldMessenger.of(context)
//                                                     .showSnackBar(
//                                                   const SnackBar(
//                                                       content: Text(
//                                                           "End time cannot be the same as start time")),
//                                                 );
//                                               } else {
//                                                 // Update the state with the selected end time
//                                                 setState(() {
//                                                   endTimes[index] = TimeOfDay(
//                                                     hour: selectedEndTime.hour,
//                                                     minute:
//                                                         selectedEndTime.minute,
//                                                   );
//                                                 });
//                                               }
//                                             }
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                       sizedTextfield,
//                       const Padding(
//                         padding: EdgeInsets.only(left: 10),
//                         child: TextWidget(
//                             text: "Minimum gap before booking (minutes) :",
//                             textSize: 16),
//                       ),
//                       sizedTextfield,
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: InkWell(
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: AppColors.grey700,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 TextWidget(
//                                   text: '$selectedMinutes mins',
//                                   textSize: 16,
//                                   color: AppColors.white,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Icon(Icons.schedule,
//                                     color: AppColors.white, size: 20),
//                               ],
//                             ),
//                           ),
//                           onTap: () async {
//                             DateTime? selectedTime =
//                                 await selectTime(context, true);

//                             if (selectedTime != null) {
//                               setState(() {
//                                 selectedMinutes = selectedTime.minute;
//                               });
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             bottomNavigationBar: Padding(
//               padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
//               child: AppButton.primaryButton(
//                 onButtonPressed: () async {
//                   List<Map<String, dynamic>> dayAvailability = [];

//                   for (int i = 0; i < daysOfWeek.length; i++) {
//                     if (isChecked[i]) {
//                       dayAvailability.add({
//                         "dayAvailability": daysOfWeek[i],
//                         "startTime":
//                             "${startTimes[i].hour}:${startTimes[i].minute}",
//                         "endTime": "${endTimes[i].hour}:${endTimes[i].minute}",
//                       });
//                     }
//                   }

//                   await MeetingController().updateAvailability(
//                     context,
//                     dayAvailability,
//                     selectedMinutes,
//                   );
//                 },
//                 title: "Update Availability",
//               ),
//             )));
//   }
// }


class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  MeetingController availabilityController = Get.put(MeetingController());
  final List<String> daysOfWeek = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday'
  ];

  List<bool> isChecked = [false, false, false, false, false, false, false];

  List<TimeOfDay> startTimes = [
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 0),
    const TimeOfDay(hour: 9, minute: 0),
  ];

  List<TimeOfDay> endTimes = [
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
    const TimeOfDay(hour: 17, minute: 0),
  ];

  int selectedMinutes = 15;

  @override
  void initState() {
    super.initState();

    // Fetch the availability data when the screen is first loaded
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      availabilityController.getAvailability().then((_) {
        // Populate data after it's fetched
        _populateData();
      });
    });
  }

  void _populateData() {
    // Assuming availabilityController.availabilityList holds the data
    var availabilityData = availabilityController.availabilityList;

    if (availabilityData.isNotEmpty) {
      var availability = availabilityData[0]; // Assuming data is a list with a single object

      // Populate minimum gap
      // setState(() {
      //   selectedMinutes = int.parse(availability.minimumGap);
      // });

      // Populate day availability
      for (int i = 0; i < daysOfWeek.length; i++) {
        var dayData = availability.dayAvailability.firstWhere(
            (day) => day.day == daysOfWeek[i],
            orElse: () => DayAvailability(day: daysOfWeek[i], startTime: '', endTime: ''));

        if (dayData != null) {
          setState(() {
            isChecked[i] = true; // Mark the day as selected
            startTimes[i] = _getTimeOfDay(dayData.startTime); // Convert start time to TimeOfDay
            endTimes[i] = _getTimeOfDay(dayData.endTime); // Convert end time to TimeOfDay
          });
        }
      }
    }
  }

  TimeOfDay _getTimeOfDay(String timeString) {
    List<String> timeParts = timeString.split(":");
    return TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            drawer: const DrawerWidget(),
            backgroundColor: AppColors.transparent,
            appBar: HelperAppBar.appbarHelper(
                title: "Availability", hideBack: true, autoAction: true),
            body: Obx(
              () => Padding(
                padding: const EdgeInsets.all(12),
                child: availabilityController.isLoading.value
                    ? Helper.pageLoading()
                    : Card(
                        color: AppColors.blackCard,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: daysOfWeek.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Checkbox(
                                              value: isChecked[index],
                                              activeColor: AppColors.primary,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked[index] = value!;
                                                });
                                              },
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            TextWidget(
                                              text: daysOfWeek[index],
                                              textSize: 16,
                                            ),
                                          ],
                                        ),
                                        if (isChecked[index])
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color:
                                                            AppColors.grey700,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        TextWidget(
                                                            text: startTimes[
                                                                    index]
                                                                .format(
                                                                    context),
                                                            textSize: 16),
                                                        const SizedBox(
                                                            width: 8),
                                                        Icon(
                                                          Icons.schedule,
                                                          color:
                                                              AppColors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    DateTime? selectedTime =
                                                        await selectTime(
                                                            context, false);
                                                    if (selectedTime != null) {
                                                      setState(() {
                                                        startTimes[index] =
                                                            TimeOfDay(
                                                                hour:
                                                                    selectedTime
                                                                        .hour,
                                                                minute:
                                                                    selectedTime
                                                                        .minute);
                                                      });
                                                    }
                                                  },
                                                ),
                                                const SizedBox(width: 12),
                                                const TextWidget(
                                                  text: "to",
                                                  textSize: 16,
                                                ),
                                                const SizedBox(width: 12),
                                                InkWell(
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color:
                                                            AppColors.grey700,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        TextWidget(
                                                          text: endTimes[index]
                                                              .format(context),
                                                          textSize: 16,
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Icon(
                                                          Icons.schedule,
                                                          color:
                                                              AppColors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async {
                                                    DateTime? selectedEndTime =
                                                        await selectTime(
                                                            context, false);
                                                    if (selectedEndTime !=
                                                        null) {
                                                      if (selectedEndTime
                                                                  .hour == 
                                                              startTimes[index]
                                                                  .hour &&
                                                          selectedEndTime
                                                                  .minute == 
                                                              startTimes[index]
                                                                  .minute) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "End time cannot be the same as start time")),
                                                        );
                                                      } else {
                                                        // Update the state with the selected end time
                                                        setState(() {
                                                          endTimes[index] =
                                                              TimeOfDay(
                                                            hour:
                                                                selectedEndTime
                                                                    .hour,
                                                            minute:
                                                                selectedEndTime
                                                                    .minute,
                                                          );
                                                        });
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              sizedTextfield,
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: TextWidget(
                                    text:
                                        "Minimum gap before booking (minutes) :",
                                    textSize: 16),
                              ),
                              sizedTextfield,
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: AppColors.grey700,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextWidget(
                                          text: '$selectedMinutes mins',
                                          textSize: 16,
                                          color: AppColors.white,
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(Icons.schedule,
                                            color: AppColors.white, size: 20),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime? selectedTime =
                                        await selectTime(context, true);

                                    if (selectedTime != null) {
                                      setState(() {
                                        selectedMinutes = selectedTime.minute;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: AppButton.primaryButton(
                onButtonPressed: () async {
                  List<Map<String, dynamic>> dayAvailability = [];

                  for (int i = 0; i < daysOfWeek.length; i++) {
                    if (isChecked[i]) {
                      dayAvailability.add({
                        "day": daysOfWeek[i],
                        "startTime":
                            "${startTimes[i].hour}:${startTimes[i].minute}",
                        "endTime": "${endTimes[i].hour}:${endTimes[i].minute}",
                      });
                    }
                  }

                  await MeetingController().updateAvailability(
                    context,
                    dayAvailability,
                    selectedMinutes,
                  );
                },
                title: "Update Availability",
              ),
            )));
  }
}
