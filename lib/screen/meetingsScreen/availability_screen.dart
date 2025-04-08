import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_availability_model.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  MeetingController availabilityController = Get.put(MeetingController());
  TextEditingController durationMinutesController =
      TextEditingController(text: "15");
  static void _validateDuration(
      String value, TextEditingController controller) {
    if (value.isNotEmpty) {
      int? duration = int.tryParse(value);
      if (duration != null) {
        if (duration < 1 || duration > 60) {
          controller.text = '';
        }
      } else {
        controller.text = '';
      }
    }
  }

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

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await availabilityController.getAvailability().then((_) {
        if (availabilityController.isAvailabilityAvailable) {
          var availabilityData =
              availabilityController.availabilityList.isNotEmpty
                  ? availabilityController.availabilityList[0]
                  : null;

          if (availabilityData != null) {
            setState(() {
              durationMinutesController.text =
                  availabilityData.minGap.toString();

              for (int i = 0; i < daysOfWeek.length; i++) {
                var dayData = availabilityData.dayAvailability.firstWhere(
                  (data) =>
                      data.day.toLowerCase() == daysOfWeek[i].toLowerCase(),
                  orElse: () => DayAvailability(
                    day: daysOfWeek[i],
                    startTime: "09:00",
                    endTime: "17:00",
                  ),
                );

                if (dayData.startTime == "09:00" &&
                    dayData.endTime == "17:00") {
                  isChecked[i] = false;
                } else {
                  isChecked[i] = true;
                }

                startTimes[i] = TimeOfDay(
                  hour: int.parse(dayData.startTime.split(':')[0]),
                  minute: int.parse(dayData.startTime.split(':')[1]),
                );
                endTimes[i] = TimeOfDay(
                  hour: int.parse(dayData.endTime.split(':')[0]),
                  minute: int.parse(dayData.endTime.split(':')[1]),
                );
              }
            });
          }
        }
      });
    });
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
                                              checkColor: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              activeColor: GetStoreData.getStore
                                                      .read('isInvestor')
                                                  ? AppColors.primaryInvestor
                                                  : AppColors.primary,
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
                                                            context, false, "");
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
                                                            context, false, "");
                                                    if (selectedEndTime !=
                                                        null) {
                                                      if (selectedEndTime
                                                                  .hour ==
                                                              23 &&
                                                          selectedEndTime
                                                                  .minute >
                                                              59) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "End time cannot be more than 11:59 PM")),
                                                        );
                                                        return;
                                                      }

                                                      if (selectedEndTime
                                                          .isBefore(DateTime(
                                                        selectedEndTime.year,
                                                        selectedEndTime.month,
                                                        selectedEndTime.day,
                                                        startTimes[index].hour,
                                                        startTimes[index]
                                                            .minute,
                                                      ))) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "End time cannot be before start time")),
                                                        );
                                                        return;
                                                      }

                                                      setState(() {
                                                        endTimes[index] =
                                                            TimeOfDay(
                                                          hour: selectedEndTime
                                                              .hour,
                                                          minute:
                                                              selectedEndTime
                                                                  .minute,
                                                        );
                                                      });
                                                    }
                                                  },
                                                )
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
                                child: Container(
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
                                      SizedBox(
                                        width: 40,
                                        child: MyCustomTextField.textField(
                                          hintText: "30",
                                          textInputType: TextInputType.number,
                                          onChange: (value) {
                                            _validateDuration(value,
                                                durationMinutesController);
                                          },
                                          controller: durationMinutesController,
                                        ),
                                      ),
                                      const TextWidget(
                                          text: "mins", textSize: 16),
                                      const SizedBox(width: 8),
                                      Icon(Icons.schedule,
                                          color: AppColors.white, size: 20),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
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
                    int.parse(durationMinutesController.text),
                  );
                },
                title: "Update Availability",
              ),
            )));
  }
}
