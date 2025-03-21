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
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/imagePickerWidget/image_picker_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
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

  String selectedTimeline = "Hours";
  String base64 = "";

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
      communityPriorityDMs.titleController.text =
          communityPriorityDMs.communityPriorityDMsList[widget.index!].title!;
      communityPriorityDMs.amountController.text = communityPriorityDMs
          .communityPriorityDMsList[widget.index!].amount!
          .toString();
      communityPriorityDMs.responseTimelineController.text =
          communityPriorityDMs.communityPriorityDMsList[widget.index!].timeline!
              .toString();
      communityPriorityDMs.topicsController.text = communityPriorityDMs
          .communityPriorityDMsList[widget.index!].topics!
          .join(", ");
    }
    if (widget.isEdit && widget.isMeeting!) {
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
    if (widget.isEdit && widget.isEvent!) {
      communityEvents.titleController.text =
          communityEvents.communityEventsData.webinars![widget.index!].title!;
      communityEvents.durationMinutesController.text = communityEvents
          .communityEventsData.webinars![widget.index!].duration!;
      communityEvents.priceController.text =
          communityEvents.communityEventsData.webinars![widget.index!].price!;
      communityEvents.priceDiscountController.text = communityEvents
          .communityEventsData.webinars![widget.index!].discount!;
    }
    if (widget.isEdit && widget.isWebinar!) {
      communityWebinars.titleController.text =
          communityWebinars.communityWebinarsList[widget.index!].title!;
      communityWebinars.dateController.text =
          communityWebinars.communityWebinarsList[widget.index!].date!;
      communityWebinars.durationMinutesController.text = communityWebinars
          .communityWebinarsList[widget.index!].duration!
          .toString();
      communityWebinars.priceController.text = communityWebinars
          .communityWebinarsList[widget.index!].price!
          .toString();
      communityWebinars.priceDiscountController.text = communityWebinars
          .communityWebinarsList[widget.index!].discount!
          .toString();
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
  void splitTopics() {
    setState(() {
      String text = communityPriorityDMs.topicsController.text;
      topics = text.isEmpty
          ? []
          : text.split(',').map((topic) => topic.trim()).toList();
    });
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
      await communityPriorityDMs.descriptionController.insertText(
          communityPriorityDMs
              .communityPriorityDMsList[widget.index!].description!);
    }

    return SingleChildScrollView(
      child: Column(children: [
        MyCustomTextField.textField(
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
                    status: selectedTimeline,
                    statusList: const [
                      'Hours',
                      'Days',
                    ],
                    onChanged: (val) {
                      setState(() {
                        selectedTimeline = val.toString();
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
                onButtonPressed: () {},
                title: "Cancel"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  splitTopics();
                  if (widget.isEdit && widget.isPriorityDM) {
                    communityPriorityDMs.updateCommunityPriorityDM(
                        topics, widget.priorityDMId.toString());
                  } else {
                    communityPriorityDMs.createCommunityPriorityDM(topics);
                  }
                },
                title: widget.isEdit && widget.isPriorityDM
                    ? "Update Service"
                    : "Create Service"),
          ),
        ]),
      ]),
    );
  }

  meetingTab() {
    addDescription() async {
      await communityMeetings.descriptionController.insertText(
          communityMeetings.communityMeetingsList[widget.index!].description!);
    }

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyCustomTextField.textField(
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
                    hintText: "Enter amount",
                    controller: communityMeetings.amountController,
                    lableText: "Amount (\u{20B9})")),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: MyCustomTextField.textField(
                    hintText: "Enter duration",
                    controller: communityMeetings.durationController,
                    lableText: "Duration (minutes)")),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MyCustomTextField.textField(
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
            hintText: "No dates selected",
            readonly: true,
            lableText: "Select Available Days",
            onTap: () async {
              final selectedDate = await selectDate(context, DateTime.now());

              if (selectedDate != null) {
                communityMeetings.dateController.text =
                    Helper.formatDatePost(selectedDate.toString());
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
                hintText: "Select Start Time",
                readonly: false,
                lableText: "Start Time",
                onTap: () async {
                  DateTime? selectedTime = await selectTime(context, false);

                  if (selectedTime != null) {
                    communityMeetings.startTimeController.text =
                        DateFormat('hh:mm a').format(selectedTime);

                    _updateEndTime(selectedTime);
                  }
                },
                controller: communityMeetings.startTimeController,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MyCustomTextField.textField(
                hintText: "Select End Time",
                readonly: false,
                lableText: "End Time",
                controller: communityMeetings.endTimeController,
                onTap: () async {
                  DateTime? selectedTime = await selectTime(context, false);

                  if (selectedTime != null) {
                    communityMeetings.endTimeController.text =
                        DateFormat('hh:mm a').format(selectedTime);

                    _updateStartTime(selectedTime);
                  }
                },
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
              statusList: const [
                'Add a new member',
                'dhairya.jan9@gmail.com',
                'dhairya.jan9@gmail.com',
                'dhairya.jan9@gmail.com',
                'dhairya.jan9@gmail.com',
                'dhairya.jan9@gmail.com',
              ],
              onChanged: (val) {
                setState(() {
                  communityMeetings.memberEmail = val.toString();
                  if (communityMeetings.memberEmail == "Add a new member") {
                    isAddNewMemberFieldVisible = true;
                  }
                });
              }),
        ),
        sizedTextfield,
        if (isAddNewMemberFieldVisible) ...[
          MyCustomTextField.textField(
              readonly: false,
              hintText: "Enter member's email",
              controller: communityMeetings.memberEmailController,
              lableText: "Add Member"),
          sizedTextfield,
          AppButton.primaryButton(
              onButtonPressed: () {
                setState(() {
                  isAddNewMemberFieldVisible = false;
                });
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
                onButtonPressed: () {},
                title: "Cancel"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  splitTopics();
                  if (widget.isEdit && widget.isMeeting) {
                    communityMeetings.updateCommunityMeeting(
                        topics, widget.meetingId);
                  } else {
                    communityMeetings.createCommunityMeeting(topics);
                  }
                },
                title: widget.isEdit && widget.isMeeting
                    ? "Update Service"
                    : "Create Service"),
          ),
        ]),
      ]),
    );
  }

  void _updateEndTime(DateTime startTime) {
    final durationInMinutes =
        int.tryParse(durationMinutesController.text) ?? 30;
    final endTime = startTime.add(Duration(minutes: durationInMinutes));
    communityMeetings.endTimeController.text =
        DateFormat('hh:mm a').format(endTime);
  }

  void _updateStartTime(DateTime endTime) {
    final durationInMinutes =
        int.tryParse(durationMinutesController.text) ?? 30;
    final startTime = endTime.subtract(Duration(minutes: durationInMinutes));
    communityMeetings.startTimeController.text =
        DateFormat('hh:mm a').format(startTime);
  }

  eventTab() {
    addDescription() async {
      await communityEvents.descriptionController.insertText(communityEvents
          .communityEventsData.webinars![widget.index!].description!);
    }

    return SingleChildScrollView(
      child: Column(children: [
        MyCustomTextField.textField(
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
                    textInputType: TextInputType.number,
                    hintText: "Enter amount",
                    controller: communityEvents.priceController,
                    lableText: "Amount (\u{20B9})")),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: MyCustomTextField.textField(
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
                onButtonPressed: () {},
                title: "Cancel"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton.primaryButton(
                onButtonPressed: () {
                  splitTopics();
                  if (widget.isEdit && widget.isEvent) {
                    communityEvents.updateCommunityEvent(widget.eventId);
                  } else {
                    communityEvents.createCommunityEvent();
                  }
                },
                title: widget.isEdit && widget.isEvent
                    ? "Update Service"
                    : "Create Service"),
          ),
        ]),
      ]),
    );
  }

  webinarTab() {
    addDescription() async {
      await communityWebinars.descriptionController.insertText(
          communityWebinars.communityWebinarsList[widget.index!].description);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          sizedTextfield,
          MyCustomTextField.textField(
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
          base64 != ""
              ? CircleAvatar(
                  radius: 60,
                  backgroundImage: MemoryImage(base64Decode(base64)),
                )
              : const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.add_photo_alternate_outlined, size: 40)),
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
                    hintText: "Select date",
                    readonly: true,
                    lableText: "Date",
                    onTap: () async {
                      final selectedDate =
                          await selectDate(context, DateTime.now());

                      if (selectedDate != null) {
                        communityWebinars.dateController.text =
                            Helper.formatDatePost(selectedDate.toString());
                        setState(() {});
                      }
                    },
                    controller: communityWebinars.dateController),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: MyCustomTextField.textField(
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
                  hintText: "Select start time",
                  readonly: true,
                  lableText: "Start Time",
                  onTap: () async {
                    DateTime? selectedTime = await selectTime(context, false);

                    if (selectedTime != null) {
                      input.text = DateFormat('hh:mm a').format(selectedTime);
                    }
                  },
                  controller: communityWebinars.startTimeController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyCustomTextField.textField(
                  hintText: "Select end time",
                  readonly: true,
                  lableText: "End Time",
                  onTap: () async {
                    DateTime? selectedTime = await selectTime(context, false);

                    if (selectedTime != null) {
                      input.text = DateFormat('hh:mm a').format(selectedTime);
                    }
                  },
                  controller: communityWebinars.endTimeController,
                ),
              ),
            ],
          ),
          sizedTextfield,
          MyCustomTextField.textField(
              textInputType: TextInputType.number,
              lableText: "Price",
              hintText: "Enter price",
              controller: communityWebinars.priceController),
          sizedTextfield,
          MyCustomTextField.textField(
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
                  onButtonPressed: () {},
                  title: "Cancel"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.primaryButton(
                  onButtonPressed: () {
                    if (widget.isEdit && widget.isWebinar) {
                      communityWebinars.updateCommunityWebinar(
                          base64, widget.webinarId);
                    } else {
                      communityWebinars.createCommunityWebinar(base64);
                    }
                  },
                  title: widget.isEdit && widget.isWebinar
                      ? "Update Service"
                      : "Create Service"),
            ),
          ]),
        ],
      ),
    );
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
