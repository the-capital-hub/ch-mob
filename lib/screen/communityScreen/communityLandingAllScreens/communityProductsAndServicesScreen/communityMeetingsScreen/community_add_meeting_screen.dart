import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import '../../../../../model/communityModel/communityLandingAllModels/communityMeetingsModel/communityMeetingsModel.dart';
import '../../../../../utils/appcolors/app_colors.dart';
import '../../../../../utils/constant/asset_constant.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../utils/helper/helper_sncksbar.dart';
import '../../../../../widget/buttons/button.dart';
import '../../../../../widget/datePicker/datePicker.dart';
import '../../../../../widget/dropdownWidget/drop_down_widget.dart';
import '../../../../../widget/text_field/text_field.dart';
import '../../../../../widget/textwidget/text_widget.dart';
import '../../../../../widget/timePicker/timePicker.dart';

class CommunityAddMeetingScreen extends StatefulWidget {
  final bool isEdit;
  CommunityMeetings? communityMeetings;
  CommunityAddMeetingScreen(
      {super.key, required this.isEdit, this.communityMeetings});

  @override
  State<CommunityAddMeetingScreen> createState() =>
      _CommunityAddMeetingScreenState();
}

class _CommunityAddMeetingScreenState extends State<CommunityAddMeetingScreen> {
  CommunityMeetingsController communityMeetings =
      Get.put(CommunityMeetingsController());
  GlobalKey<FormState> meetingsFormkey = GlobalKey();

  GlobalKey<FormState> priorityDMFormkey = GlobalKey();
  addDescription() async {
    await communityMeetings.descriptionController
        .setText(widget.communityMeetings!.description!);
  }

  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  bool isAddNewMemberFieldVisible = false;
  @override
  void initState() {
    if (widget.isEdit) {
      String inputDate = widget.communityMeetings!.availability![0].day!;

      DateFormat inputFormat = DateFormat("dd-MMM-yyyy");
      DateTime dateTime = inputFormat.parse(inputDate);

      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      String outputMeetingDate = outputFormat.format(dateTime);
      communityMeetings.dateController.text = outputMeetingDate;
      communityMeetings.memberEmail =
          widget.communityMeetings!.availability![0].slots![0].memberEmail!;
      communityMeetings.startTimeController.text =
          widget.communityMeetings!.availability![0].slots![0].startTime!;
      communityMeetings.endTimeController.text =
          widget.communityMeetings!.availability![0].slots![0].endTime!;
      communityMeetings.titleController.text = widget.communityMeetings!.title!;
      communityMeetings.amountController.text =
          widget.communityMeetings!.amount!.toString();
      communityMeetings.durationController.text =
          widget.communityMeetings!.duration!.toString();
      communityMeetings.topicsController.text =
          widget.communityMeetings!.topics!.join(", ");
    } else {
      communityMeetings.dateController.clear();
      communityMeetings.topicsController.clear();
      communityMeetings.memberEmail = "";
      communityMeetings.startTimeController.clear();
      communityMeetings.endTimeController.clear();
      communityMeetings.titleController.clear();
      communityMeetings.amountController.clear();
      communityMeetings.durationController.clear();
      communityMeetings.topicsController.clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Meeting"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Form(
            key: meetingsFormkey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MyCustomTextField.textField(
                  valText: "Please enter service title",
                  hintText: "Enter service title",
                  controller: communityMeetings.titleController,
                  lableText: "Title"),
              sizedTextfield,
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
              sizedTextfield,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: MyCustomTextField.textField(
                          valText: "Please enter amount",
                          textInputType: TextInputType.number,
                          hintText: "Enter amount",
                          controller: communityMeetings.amountController,
                          lableText: "Amount (\u{20B9})")),
                  const SizedBox(
                    width: 12,
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
              sizedTextfield,
              MyCustomTextField.textField(
                  valText: "Please enter the topics",
                  hintText: "Enter topics, seperated by commas",
                  controller: communityMeetings.topicsController,
                  lableText: "Topics (comma-seperated)"),
              sizedTextfield,
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
                    final selectedDate =
                        await selectDate(context, DateTime.now());

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
              sizedTextfield,
              const TextWidget(text: "Set Time Slots", textSize: 16),
              sizedTextfield,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (communityMeetings
                              .memberEmailController.text.isEmpty ||
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
              sizedTextfield,
              AppButton.primaryButton(
                  onButtonPressed: () {
                    if (meetingsFormkey.currentState!.validate()) {
                      splitTopics();
                      if (widget.isEdit) {
                        Helper.loader(context);
                        communityMeetings.updateCommunityMeeting(
                            topics, widget.communityMeetings!.id);
                      } else {
                        Helper.loader(context);
                        communityMeetings.createCommunityMeeting(
                            context, topics);
                      }
                    }
                  },
                  title: widget.isEdit ? "Update Meeting" : "Create Meeting"),
            ]),
          )),
        ),
      ),
    );
  }

  void _updateEndTime(DateTime startTime, bool isMeeting) {
    final durationInMinutes =
        int.tryParse(communityMeetings.durationController.text) ?? 30;
    final endTime = startTime.add(Duration(minutes: durationInMinutes));
    communityMeetings.endTimeController.text =
        DateFormat('hh:mm a').format(endTime);
  }

  List<String> topics = [];

  void splitTopics() {
    setState(() {
      String text = communityMeetings.topicsController.text.trim();
      topics = _processTopics(text);
    });
  }

  List<String> _processTopics(String text) {
    List<String> processedTopics = text
        .split(',')
        .map((topic) => topic.trim())
        .where((topic) => topic.isNotEmpty)
        .toList();

    return processedTopics;
  }
}
