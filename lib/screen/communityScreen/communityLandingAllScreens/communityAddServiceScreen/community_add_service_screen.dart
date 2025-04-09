import 'dart:convert';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityPriorityDMsController/community_priority_dms_controller.dart';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/communityMeetingsModel.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityMeetingsScreen/community_meetings_screen.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunityAddServiceScreen extends StatefulWidget {
  bool isEdit;
  int? index;
  bool isPriorityDM;
  bool isMeeting;
  bool isEvent;
  bool isWebinar;
  String? priorityDMId;
  String? meetingId;
  String? eventId;
  String? webinarId;
  CommunityAddServiceScreen(
      {required this.isEdit,
      this.index,
      required this.isPriorityDM,
      this.priorityDMId,
      required this.isMeeting,
      this.meetingId,
      required this.isEvent,
      this.eventId,
      required this.isWebinar,
      this.webinarId,
      super.key});

  @override
  State<CommunityAddServiceScreen> createState() =>
      _CommunityAddServiceScreenState();
}

class _CommunityAddServiceScreenState extends State<CommunityAddServiceScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  TextEditingController input = TextEditingController();
  TextEditingController output = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  GlobalKey<FormState> priorityDMFormkey = GlobalKey();
  GlobalKey<FormState> meetingsFormkey = GlobalKey();
  GlobalKey<FormState> eventsFormkey = GlobalKey();
  GlobalKey<FormState> webinarsFormkey = GlobalKey();

  String base64 = "";

  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  bool isAddNewMemberFieldVisible = false;
  CommunityPriorityDMsController communityPriorityDMs =
      Get.put(CommunityPriorityDMsController());
  CommunityMeetingsController communityMeetings =
      Get.put(CommunityMeetingsController());
  CommunityEventsController communityEvents =
      Get.put(CommunityEventsController());
  CommunityWebinarsController communityWebinars =
      Get.put(CommunityWebinarsController());

  @override
  void initState() {
    if (!widget.isEdit) {
      communityPriorityDMs.titleController.clear();
      communityPriorityDMs.descriptionController.clear();
      communityPriorityDMs.amountController.clear();
      communityPriorityDMs.responseTimelineController.clear();
      communityPriorityDMs.topicsController.clear();
      communityMeetings.titleController.clear();
      communityMeetings.descriptionController.clear();
      communityMeetings.amountController.clear();
      communityMeetings.durationController.clear();
      communityMeetings.topicsController.clear();
      communityEvents.titleController.clear();
      communityEvents.descriptionController.clear();
      communityEvents.durationMinutesController.clear();
      communityEvents.priceController.clear();
      communityEvents.priceDiscountController.clear();
      communityWebinars.titleController.clear();
      communityWebinars.descriptionController.clear();
      communityWebinars.dateController.clear();
      communityWebinars.durationMinutesController.clear();
      communityWebinars.startTimeController.clear();
      communityWebinars.endTimeController.clear();
      communityWebinars.priceController.clear();
      communityWebinars.priceDiscountController.clear();
    }
    if (widget.isEdit && widget.isPriorityDM) {
      setState(() {
        communityPriorityDMs.selectedTimeLine =
            communityPriorityDMs.titleController.text = communityPriorityDMs
                .communityPriorityDMsList[widget.index!].timelineUnit!;
      });
      communityPriorityDMs.titleController.text =
          communityPriorityDMs.communityPriorityDMsList[widget.index!].title!;
      communityPriorityDMs.amountController.text = communityPriorityDMs
          .communityPriorityDMsList[widget.index!].amount!
          .toString();
      communityPriorityDMs.responseTimelineController.text =
          communityPriorityDMs
              .communityPriorityDMsList[widget.index!].timelineValue
              .toString();

      communityPriorityDMs.topicsController.text = communityPriorityDMs
          .communityPriorityDMsList[widget.index!].topics!
          .join(", ");
    }
    if (widget.isEdit && widget.isMeeting!) {
      String inputDate = communityMeetings
          .communityMeetingsList[widget.index!].availability![0].day!;

      DateFormat inputFormat = DateFormat("dd-MMM-yyyy");
      DateTime dateTime = inputFormat.parse(inputDate);

      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      String outputMeetingDate = outputFormat.format(dateTime);
      communityMeetings.dateController.text = outputMeetingDate;
      setState(() {
        communityMeetings.memberEmail = communityMeetings
            .communityMeetingsList[widget.index!]
            .availability![0]
            .slots![0]
            .memberEmail!;
      });

      communityMeetings.startTimeController.text = communityMeetings
          .communityMeetingsList[widget.index!]
          .availability![0]
          .slots![0]
          .startTime!;
      communityMeetings.endTimeController.text = communityMeetings
          .communityMeetingsList[widget.index!]
          .availability![0]
          .slots![0]
          .endTime!;
      communityMeetings.titleController.text =
          communityMeetings.communityMeetingsList[widget.index!].title!;
      communityMeetings.amountController.text = communityMeetings
          .communityMeetingsList[widget.index!].amount!
          .toString();
      communityMeetings.durationController.text = communityMeetings
          .communityMeetingsList[widget.index!].duration!
          .toString();
      communityMeetings.topicsController.text = communityMeetings
          .communityMeetingsList[widget.index!].topics!
          .join(", ");
    }
    if (widget.isEdit && widget.isEvent) {
      communityEvents.titleController.text =
          communityWebinars.communityWebinarsList[widget.index!].title!;
      communityEvents.durationMinutesController.text =
          "${communityWebinars.communityWebinarsList[widget.index!].duration}";
      communityEvents.priceController.text =
          "${communityWebinars.communityWebinarsList[widget.index!].price}";
      communityEvents.priceDiscountController.text =
          "${communityWebinars.communityWebinarsList[widget.index!].discount}";
    }
    if (widget.isEdit && widget.isWebinar) {
      String numberString = "";
      String inputString =
          communityEvents.communityWebinarsList[widget.index!].duration!;

      // Use regex to capture the number from the string
      RegExp regExp = RegExp(r'(\d+)');

      // Find the match and extract the number as a string
      Match? match = regExp.firstMatch(inputString);

      if (match != null) {
        // The first capturing group contains the number as a string
        numberString = match.group(0)!;
        print(numberString); // Output: "30"
      } else {
        print("No number found.");
      }
      String inputDate = communityEvents.communityWebinarsList[widget.index!]
          .date!; // Original date format (DD-MM-YYYY)

      // Parse the date in DD-MM-YYYY format
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime date = inputFormat.parse(inputDate);

      // Format the date into YYYY-MM-DD format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = outputFormat.format(date);

      communityWebinars.titleController.text =
          communityEvents.communityWebinarsList[widget.index!].title!;
      communityWebinars.dateController.text = formattedDate;

      communityWebinars.durationMinutesController.text = numberString;

      communityWebinars.startTimeController.text =
          communityEvents.communityWebinarsList[widget.index!].startTime!;
      communityWebinars.endTimeController.text =
          communityEvents.communityWebinarsList[widget.index!].endTime!;
      communityWebinars.priceController.text =
          communityEvents.communityWebinarsList[widget.index!].price!;
      communityWebinars.priceDiscountController.text =
          communityEvents.communityWebinarsList[widget.index!].discount!;
    }
    super.initState();

    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: addServiceIndex,
    );
  }

  @override
  void dispose() {
    // exploreController.tabController.dispose();
    super.dispose();
  }

  List<String> topics = [];
  bool isPriorityDMTopics = false;
  bool isMeetingsTopics = false;
  void splitTopics() {
    setState(() {
      if (isPriorityDMTopics) {
        String text = communityPriorityDMs.topicsController.text.trim();
        topics = _processTopics(text);
      }
      if (isMeetingsTopics) {
        String text = communityMeetings.topicsController.text.trim();
        topics = _processTopics(text);
      }
    });
  }

  List<String> _processTopics(String text) {
    // Split by commas and trim spaces from each topic
    List<String> processedTopics = text
        .split(',')
        .map((topic) => topic.trim())
        .where((topic) => topic.isNotEmpty) // Remove empty topics
        .toList();

    return processedTopics;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          drawer: GetStoreData.getStore.read('isInvestor')
              ? const DrawerWidgetInvestor()
              : const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: AppColors.black,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  child: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: AppColors.white,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                CircleAvatar(
                  radius: 16,
                  foregroundImage: NetworkImage(communityLogo),
                ),
              ],
            ),
            title: TextWidget(text: communityName, textSize: 16),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => const HomeScreen());
                  },
                  icon: Icon(
                    Icons.swap_horizontal_circle_sharp,
                    color: AppColors.white,
                    size: 30,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  text: widget.isEdit ? "Edit Service" : "Add New Service",
                  textSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        controller: _tabController,
                        dividerHeight: 0,
                        indicator: BoxDecoration(
                          color: GetStoreData.getStore.read('isInvestor')
                              ? AppColors.primaryInvestor
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 5.0),
                        indicatorSize: TabBarIndicatorSize.tab,
                        onTap: (val) {},
                        tabs: const [
                          Tab(text: "Priority DM"),
                          Tab(text: "Meeting"),
                          Tab(text: "Event"),
                          Tab(text: "Webinar"),
                        ],
                        labelColor: GetStoreData.getStore.read('isInvestor')
                            ? AppColors.black
                            : AppColors.white,
                        unselectedLabelColor: Colors.white,
                        unselectedLabelStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        priorityDMTab(),
                        meetingTab(),
                        eventTab(),
                        webinarTab(),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }

  priorityDMTab() {
    addDescription() async {
      await communityPriorityDMs.descriptionController.setText(
          communityPriorityDMs
              .communityPriorityDMsList[widget.index!].description!);
    }

    return SingleChildScrollView(
        child: Form(
      key: priorityDMFormkey,
      child: Column(children: [
        MyCustomTextField.textField(
            valText: "Please enter title",
            hintText: "Enter service title",
            controller: communityPriorityDMs.titleController,
            lableText: "Title"),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.htmlTextField(
          hintText: "Enter service description",
          controller: communityPriorityDMs.descriptionController,
          lableText: "Description",
          onEditorCreated: () async {
            if (widget.isEdit) {
              addDescription();
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.textField(
            valText: "Please enter amount",
            textInputType: TextInputType.number,
            hintText: "Enter amount",
            controller: communityPriorityDMs.amountController,
            lableText: "Amount (\u{20B9})"),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: MyCustomTextField.textField(
                    valText: "Please enter Response Timeline",
                    textInputType: TextInputType.number,
                    hintText: "Enter Response Timeline",
                    controller: communityPriorityDMs.responseTimelineController,
                    lableText: "Response Timeline")),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: DropDownWidget(
                    status: communityPriorityDMs.selectedTimeLine,
                    statusList: const [
                      'Hours',
                      'Days',
                    ],
                    onChanged: (val) {
                      setState(() {
                        communityPriorityDMs.selectedTimeLine = val.toString();
                      });
                    }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.textField(
            valText: "Please anter topics",
            hintText: "Enter topics, seperated by commas",
            controller: communityPriorityDMs.topicsController,
            lableText: "Topics (comma-seperated)"),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: AppButton.outlineButton(
                borderColor: GetStoreData.getStore.read('isInvestor')
                    ? AppColors.primaryInvestor
                    : AppColors.primary,
                onButtonPressed: () {
                  Get.back();
                },
                title: "Cancel"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  if (priorityDMFormkey.currentState!.validate()) {
                    setState(() {
                      isPriorityDMTopics = true;
                    });
                    splitTopics();
                    if (widget.isEdit && widget.isPriorityDM) {
                      Helper.loader(context);
                      communityPriorityDMs.updateCommunityPriorityDM(
                          topics, widget.priorityDMId.toString());
                    } else {
                      Helper.loader(context);
                      communityPriorityDMs.createCommunityPriorityDM(topics);
                    }
                  }
                },
                title: widget.isEdit && widget.isPriorityDM
                    ? "Update Service"
                    : "Create Service"),
          ),
        ]),
      ]),
    ));
  }

  meetingTab() {
    addDescription() async {
      await communityMeetings.descriptionController.setText(
          communityMeetings.communityMeetingsList[widget.index!].description!);
    }

    return SingleChildScrollView(
        child: Form(
      key: meetingsFormkey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyCustomTextField.textField(
          valText: "Please enter service title",
            hintText: "Enter service title",
            controller: communityMeetings.titleController,
            lableText: "Title"),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.htmlTextField(
          hintText: "Enter service description",
          controller: communityMeetings.descriptionController,
          lableText: "Description",
          onEditorCreated: () async {
            if (widget.isEdit) {
              addDescription();
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: MyCustomTextField.textField(
                  valText: "Please enter amount",
                    textInputType: TextInputType.number,
                    hintText: "Enter amount",
                    controller: communityMeetings.amountController,
                    lableText: "Amount (\u{20B9})")),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: MyCustomTextField.textField(
                  valText: "Please enter duration",
                    textInputType: TextInputType.number,
                    hintText: "Enter duration",
                    controller: communityMeetings.durationController,
                    lableText: "Duration (minutes)")),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.textField(
          valText: "Please enter the topics",
            hintText: "Enter topics, seperated by commas",
            controller: communityMeetings.topicsController,
            lableText: "Topics (comma-seperated)"),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.textField(
            suffixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                PngAssetPath.meetingIcon,
                color: AppColors.white,
                height: 0,
              ),
            ),
            valText: "Please select available days",
            hintText: "No dates selected",
            readonly: true,
            lableText: "Select Available Days",
            onTap: () async {
              final selectedDate = await selectDate(context, DateTime.now());

              if (selectedDate != null) {
                communityMeetings.dateController.text =
                    Helper.formatDatePost(selectedDate.toString());
                communityMeetings.dateSelected = selectedDate;
                communityMeetings.startTimeController.clear();
                communityMeetings.endTimeController.clear();
                print(communityMeetings.dateController.text);
                setState(() {});
              }
            },
            controller: communityMeetings.dateController),
        const SizedBox(
          height: 16,
        ),
        const TextWidget(text: "Set Time Slots", textSize: 16),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: MyCustomTextField.textField(
                valText: "Please select start time",
                hintText: "Select Start Time",
                readonly: true,
                lableText: "Start Time",
                onTap: () async {
                  DateTime? selectedTime =
                      await selectTime(context, false, "community");
                  print(selectedTime);

                  if (selectedTime != null) {
                    communityMeetings.startTimeController.text =
                        DateFormat('hh:mm a').format(selectedTime);
                    print(selectedTime);
                    _updateEndTime(selectedTime, true);
                  }
                },
                controller: communityMeetings.startTimeController,
              ),
            ),
            const SizedBox(width: 12),
            // Expanded(
            //   child: MyCustomTextField.textField(
            //     hintText: "Select End Time",
            //     readonly: true,
            //     lableText: "End Time",
            //     controller: communityMeetings.endTimeController,
            //     onTap: () async {
            //       DateTime? selectedTime = await selectTime(context, false);
            //       print(selectedTime);
            //       if (selectedTime != null) {
            //         communityMeetings.endTimeController.text =
            //             DateFormat('hh:mm a').format(selectedTime);

            //         // _updateStartTime(selectedTime, true);
            //       }
            //     },
            //   ),
            // ),
            Expanded(
              child: MyCustomTextField.textField(
                valText: "Please select end time",
                hintText: "Select End Time",
                readonly: true,
                lableText: "End Time",
                controller: communityMeetings.endTimeController,
              ),
            ),
          ],
        ),
        sizedTextfield,
        const TextWidget(text: "Select Member", textSize: 16),
        sizedTextfield,
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.white38),
              borderRadius: BorderRadius.circular(7)),
          child: DropDownWidget(
              status: communityMeetings.memberEmail,
              statusList: communityMeetings.communityMemberEmails,
              onChanged: (val) {
                setState(() {
                  if (val.toString() == "Add a new member") {
                    isAddNewMemberFieldVisible = true;
                    communityMeetings.memberEmail = val.toString();
                    communityMeetings.isNewEmail = true;
                  } else {
                    communityMeetings.isNewEmail = false;
                    isAddNewMemberFieldVisible = false;
                    communityMeetings.memberEmail = val.toString();
                  }
                });
              }),
        ),
        sizedTextfield,
        if (isAddNewMemberFieldVisible) ...[
          MyCustomTextField.textField(
            valText: "Please enter member's email",
            readonly: false,
            hintText: "Enter member's email",
            controller: communityMeetings.memberEmailController,
            lableText: "Add Member",
          ),
          sizedTextfield,
          AppButton.primaryButton(
              onButtonPressed: () {
                if (communityMeetings.memberEmailController.text.isEmpty ||
                    !emailRegex.hasMatch(
                        communityMeetings.memberEmailController.text)) {
                  HelperSnackBar.snackBar(
                      "Error", "Enter a valid email address");
                  communityMeetings.memberEmailController.clear();
                } else {
                  setState(() {
                    isAddNewMemberFieldVisible = false;
                    communityMeetings.memberEmail =
                        communityMeetings.memberEmailController.text;
                  });
                }
              },
              title: "Add Member"),
        ],
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: AppButton.outlineButton(
                borderColor: GetStoreData.getStore.read('isInvestor')
                    ? AppColors.primaryInvestor
                    : AppColors.primary,
                onButtonPressed: () {
                  Get.back();
                },
                title: "Cancel"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  if (meetingsFormkey.currentState!.validate()) {
                    setState(() {
                      isMeetingsTopics = true;
                    });
                    splitTopics();
                    if (widget.isEdit && widget.isMeeting) {
                      Helper.loader(context);
                      communityMeetings.updateCommunityMeeting(
                          topics, widget.meetingId);
                    } else {
                      Helper.loader(context);
                      communityMeetings.createCommunityMeeting(context, topics);
                    }
                  }
                },
                title: widget.isEdit && widget.isMeeting
                    ? "Update Service"
                    : "Create Service"),
          ),
        ]),
      ]),
    ));
  }

  void _updateEndTime(DateTime startTime, bool isMeeting) {
    if (isMeeting) {
      final durationInMinutes =
          int.tryParse(communityMeetings.durationController.text) ?? 30;
      final endTime = startTime.add(Duration(minutes: durationInMinutes));
      communityMeetings.endTimeController.text =
          DateFormat('hh:mm a').format(endTime);
    } else {
      final durationInMinutes =
          int.tryParse(communityWebinars.durationMinutesController.text) ?? 30;
      final endTime = startTime.add(Duration(minutes: durationInMinutes));
      communityWebinars.endTimeController.text =
          DateFormat('hh:mm a').format(endTime);
    }
  }

  // void _updateStartTime(DateTime endTime, bool isMeeting) {
  //   if (isMeeting) {
  //     final durationInMinutes =
  //         int.tryParse(communityMeetings.durationController.text) ?? 30;
  //     final startTime = endTime.subtract(Duration(minutes: durationInMinutes));
  //     communityMeetings.startTimeController.text =
  //         DateFormat('hh:mm a').format(startTime);
  //   } else {
  //     final durationInMinutes =
  //         int.tryParse(communityWebinars.durationMinutesController.text) ?? 30;
  //     final startTime = endTime.subtract(Duration(minutes: durationInMinutes));
  //     communityWebinars.startTimeController.text =
  //         DateFormat('hh:mm a').format(startTime);
  //   }
  // }

  eventTab() {
    addDescription() async {
      await communityEvents.descriptionController.setText(
          communityWebinars.communityWebinarsList[widget.index!].description!);
    }

    return SingleChildScrollView(
        child: Form(
      key: eventsFormkey,
      child: Column(children: [
        MyCustomTextField.textField(
          valText: "Please enter service title",
            hintText: "Enter service title",
            controller: communityEvents.titleController,
            lableText: "Title"),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.htmlTextField(
          hintText: "Enter service description",
          controller: communityEvents.descriptionController,
          lableText: "Description",
          onEditorCreated: () async {
            if (widget.isEdit) {
              addDescription();
            }
          },
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
                child: MyCustomTextField.textField(
                  valText: "Please enter amount",
                    textInputType: TextInputType.number,
                    hintText: "Enter amount",
                    controller: communityEvents.priceController,
                    lableText: "Amount (\u{20B9})")),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: MyCustomTextField.textField(
                  valText: "Please enter duration",
                    textInputType: TextInputType.number,
                    hintText: "Enter duration",
                    controller: communityEvents.durationMinutesController,
                    lableText: "Duration (minutes)")),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.textField(
          valText: "Please enter discount (%)",
            textInputType: TextInputType.number,
            hintText: "Enter discount (%)",
            controller: communityEvents.priceDiscountController,
            lableText: "Discount (%)"),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: AppButton.outlineButton(
                borderColor: GetStoreData.getStore.read('isInvestor')
                    ? AppColors.primaryInvestor
                    : AppColors.primary,
                onButtonPressed: () {
                  Get.back();
                },
                title: "Cancel"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  if (eventsFormkey.currentState!.validate()) {
                    splitTopics();
                    if (widget.isEdit && widget.isEvent) {
                      Helper.loader(context);
                      communityEvents.updateCommunityEvent(widget.eventId);
                      communityWebinars.getCommunityWebinars();
                    } else {
                      Helper.loader(context);
                      communityEvents.createCommunityEvent();
                      communityWebinars.getCommunityWebinars();
                    }
                  }
                },
                title: widget.isEdit && widget.isEvent
                    ? "Update Service"
                    : "Create Service"),
          ),
        ]),
      ]),
    ));
  }

  webinarTab() {
    addDescription() async {
      await communityWebinars.descriptionController.setText(
          communityEvents.communityWebinarsList[widget.index!].description!);
    }

    return SingleChildScrollView(
        child: Form(
      key: webinarsFormkey,
      child: Column(
        children: [
          sizedTextfield,
          // base64 != ""
          //     ? CircleAvatar(
          //         radius: 60,
          //         backgroundImage: MemoryImage(base64Decode(base64)),
          //       )
          //     : const CircleAvatar(
          //         radius: 60,
          //         child: Icon(Icons.add_photo_alternate_outlined, size: 40)),
          widget.isEdit
              ? base64 != ""
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(base64Decode(base64)),
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(communityEvents
                          .communityWebinarsList[widget.index!].image!),
                    )
              : base64 != ""
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: MemoryImage(base64Decode(base64)),
                    )
                  : const CircleAvatar(
                      radius: 60,
                      child:
                          Icon(Icons.add_photo_alternate_outlined, size: 40)),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            onTap: () {
              uploadBottomSheet();
            },
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.blackCard,
                    borderRadius: BorderRadius.circular(7)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: TextWidget(text: "Upload Image", textSize: 13),
                ),
              ),
            ]),
          ),
          sizedTextfield,
          MyCustomTextField.textField(
            valText: "Please enter service title",
              lableText: "Title",
              hintText: "Enter service title",
              controller: communityWebinars.titleController),
          sizedTextfield,
          MyCustomTextField.htmlTextField(
            
            hintText: "Enter service description",
            controller: communityWebinars.descriptionController,
            lableText: "Description",
            onEditorCreated: () async {
              if (widget.isEdit) {
                addDescription();
              }
            },
          ),
          sizedTextfield,
          // widget.isEdit
          // &&
          //         communityEvents.communityEventsData.webinars![widget.index!]
          //             .image.isNotEmpty
          //     ? CircleAvatar(
          //         radius: 60,
          //         foregroundImage: NetworkImage(communityEvents
          //             .communityEventsData.webinars![widget.index!].image),
          //       )
          //     :

          Row(
            children: [
              Expanded(
                child: MyCustomTextField.textField(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        PngAssetPath.meetingIcon,
                        color: AppColors.white,
                        height: 0,
                      ),
                    ),
                    valText: "Please select date",
                    hintText: "Select date",
                    lableText: "Date",
                    readonly: true,
                    onTap: () async {
                      final selectedDate =
                          await selectDate(context, DateTime.now());

                      if (selectedDate != null) {
                        communityWebinars.dateController.text =
                            Helper.formatDatePost(selectedDate.toString());
                        communityMeetings.dateSelected = selectedDate;
                        communityWebinars.startTimeController.clear();
                        communityWebinars.endTimeController.clear();
                        setState(() {});
                      }
                    },
                    controller: communityWebinars.dateController),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: MyCustomTextField.textField(
                    valText: "Please enter duartion",
                hintText: "Enter duration (min.)",
                lableText: "Duration (min.)",
                textInputType: TextInputType.number,
                onChange: (value) {},
                controller: communityWebinars.durationMinutesController,
              )),
            ],
          ),
          sizedTextfield,
          Row(
            children: [
              Expanded(
                child: MyCustomTextField.textField(
                  valText: "Please select start time",
                  hintText: "Select start time",
                  readonly: true,
                  lableText: "Start Time",
                  onTap: () async {
                    DateTime? selectedTime =
                        await selectTime(context, false, "community");

                    if (selectedTime != null) {
                      communityWebinars.startTimeController.text =
                          DateFormat('hh:mm a').format(selectedTime);
                      _updateEndTime(selectedTime, false);
                    }
                  },
                  controller: communityWebinars.startTimeController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyCustomTextField.textField(
                  valText: "Please select end time",
                  hintText: "Select end time",
                  readonly: true,
                  lableText: "End Time",
                  onTap: () async {
                    DateTime? selectedTime =
                        await selectTime(context, false, "community");
                    if (selectedTime != null) {
                      communityWebinars.endTimeController.text =
                          DateFormat('hh:mm a').format(selectedTime);
                      // _updateStartTime(selectedTime, false);
                    }
                  },
                  controller: communityWebinars.endTimeController,
                ),
              ),
            ],
          ),
          sizedTextfield,
          MyCustomTextField.textField(
            valText: "Please Enter Price",
              textInputType: TextInputType.number,
              lableText: "Price",
              hintText: "Enter price",
              controller: communityWebinars.priceController),
          sizedTextfield,
          MyCustomTextField.textField(
            valText: "Please Enter discount (%)",
              textInputType: TextInputType.number,
              lableText: "Discount (%)",
              hintText: "Enter discount (%)",
              controller: communityWebinars.priceDiscountController),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: AppButton.outlineButton(
                  borderColor: GetStoreData.getStore.read('isInvestor')
                      ? AppColors.primaryInvestor
                      : AppColors.primary,
                  onButtonPressed: () {
                    Get.back();
                  },
                  title: "Cancel"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.primaryButton(
                  onButtonPressed: () {
                    if (webinarsFormkey.currentState!.validate()) {
                      if (widget.isEdit && widget.isWebinar) {
                        Helper.loader(context);
                        communityWebinars.updateCommunityWebinar(
                            base64, widget.webinarId);
                      } else {
                        Helper.loader(context);
                        communityWebinars.createCommunityWebinar(
                            context, base64);
                      }
                    }
                  },
                  title: widget.isEdit && widget.isWebinar
                      ? "Update Service"
                      : "Create Service"),
            ),
          ]),
        ],
      ),
    ));
  }

  uploadBottomSheet() {
    return Get.bottomSheet(
        Container(
          height: 250,
          padding: const EdgeInsets.all(12),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedTextfield,
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  size: 25,
                  color: AppColors.white,
                ),
              ),
              sizedTextfield,
              const TextWidget(
                  text: "Add picture",
                  textSize: 20,
                  fontWeight: FontWeight.w500),
              sizedTextfield,
              InkWell(
                onTap: () {
                  ImagePickerWidget imagePickerWidget = ImagePickerWidget();
                  imagePickerWidget.getImage(false).then((value) {
                    Get.back();

                    base64 = value;
                    setState(() {});
                  });
                },
                child: Container(
                  width: Get.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.white12,
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextWidget(
                      text: "Choose from Gallery", textSize: 15),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.blackCard);
  }
}
