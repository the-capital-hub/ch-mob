import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
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
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
            drawer: const DrawerWidget(),
            backgroundColor: AppColors.transparent,
            appBar: HelperAppBar.appbarHelper(
                title: "Availability", hideBack: true, autoAction: true),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
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
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    TextWidget(
                                      text: daysOfWeek[index],
                                      textSize: 16,
                                    ),
                                  ],
                                ),
                                if (isChecked[index])
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: AppColors.grey700,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                TextWidget(
                                                    text: startTimes[index]
                                                        .format(context),
                                                    textSize: 16),
                                                const SizedBox(width: 8),
                                                Icon(
                                                  Icons.schedule,
                                                  color: AppColors.white,
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
                                                startTimes[index] = TimeOfDay(
                                                    hour: selectedTime.hour,
                                                    minute:
                                                        selectedTime.minute);
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
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: AppColors.grey700,
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
                                                const SizedBox(width: 8),
                                                Icon(
                                                  Icons.schedule,
                                                  color: AppColors.white,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            DateTime? selectedEndTime =
                                                await selectTime(
                                                    context, false);
                                            if (selectedEndTime != null) {
                                              if (selectedEndTime.hour ==
                                                      startTimes[index].hour &&
                                                  selectedEndTime.minute ==
                                                      startTimes[index]
                                                          .minute) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                          "End time cannot be the same as start time")),
                                                );
                                              } else {
                                                // Update the state with the selected end time
                                                setState(() {
                                                  endTimes[index] = TimeOfDay(
                                                    hour: selectedEndTime.hour,
                                                    minute:
                                                        selectedEndTime.minute,
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
                            text: "Minimum gap before booking (minutes) :",
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
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: AppButton.primaryButton(
                  onButtonPressed: () {}, title: "Update Availability"),
            )));
  }
}
