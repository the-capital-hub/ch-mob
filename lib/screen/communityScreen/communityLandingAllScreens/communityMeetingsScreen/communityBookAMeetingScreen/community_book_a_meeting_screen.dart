import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/calendar/calendar.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

class CommunityBookAMeetingScreen extends StatefulWidget {
  int index;

  CommunityBookAMeetingScreen({
    required this.index,
    super.key,
  });

  @override
  State<CommunityBookAMeetingScreen> createState() =>
      _CommunityBookAMeetingScreenState();
}

class _CommunityBookAMeetingScreenState
    extends State<CommunityBookAMeetingScreen> {
  CommunityMeetingsController communityMeetings = Get.find();
  TextEditingController urlController = TextEditingController();
  bool isDaySelected = false;
  bool isSlotSelected = true;

  int? _selectedIndex;
  int? selectedDayIndex;
  String day = "";
  String slot = "";
  String startTime = "";
  String endTime = "";
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          appBar: HelperAppBar.appbarHelper(
            title: "Book a Meeting",
            hideBack: false,
            autoAction: true,
          ),
          backgroundColor: AppColors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 12, left: 12),
              child: Column(children: [
                const TextWidget(
                  text:
                      "Please fill these details for purchase confirmation and further communication.",
                  textSize: 13,
                  maxLine: 2,
                  align: TextAlign.center,
                ),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Name",
                    controller: communityMeetings.nameController,
                    lableText: "Name"),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    hintText: "Enter Email",
                    controller: communityMeetings.emailController,
                    lableText: "Email"),
                const SizedBox(height: 12),
                MyCustomTextField.textField(
                    textInputType: TextInputType.number,
                    hintText: "Enter Mobile Number",
                    controller: communityMeetings.mobileController,
                    lableText: "Mobile Number"),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                CommunityMeetingsCalendar(
                    selectedDate: communityMeetings
                        .communityMeetingsList[widget.index]
                        .availability![0]
                        .dayIsoString!),
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: List.generate(
                    communityMeetings.communityMeetingsList[widget.index]
                        .availability![0].slots!.length,
                    (index) {
                      bool isSlotSelected = _selectedIndex == index;
                      return !communityMeetings
                              .communityMeetingsList[widget.index]
                              .availability![0]
                              .slots![index]
                              .isBooked!
                          ? InkWell(
                              onTap: () {
                                setState(() {
                                  // isSlotSelected = !isSlotSelected;
                                  if (_selectedIndex == index) {
                                    _selectedIndex = null;
                                  } else {
                                    _selectedIndex = index;
                                  }

                                  slot = isSlotSelected
                                      ? "${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].endTime}"
                                      : "";
                                  startTime = communityMeetings
                                      .communityMeetingsList[widget.index]
                                      .availability![0]
                                      .slots![index]
                                      .startTime!;
                                  endTime = communityMeetings
                                      .communityMeetingsList[widget.index]
                                      .availability![0]
                                      .slots![index]
                                      .endTime!;
                                });
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                surfaceTintColor: AppColors.white12,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: TextWidget(
                                      text:
                                          "${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![index].endTime}",
                                      textSize: 14,
                                      color: GetStoreData.getStore.read('isInvestor')?AppColors.black:AppColors.white),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
                sizedTextfield,
                Card(
                  margin: EdgeInsets.zero,
                  color: AppColors.blackCard,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: "Details",
                          textSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(height: 12),
                       TextWidget(
                          text: "Meeting:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        TextWidget(
                            text: communityMeetings
                                .communityMeetingsList[widget.index].title!,
                            textSize: 13),
                        const SizedBox(height: 12),
                       TextWidget(
                          text: "Description:",
                          textSize: 16,
                          fontWeight: FontWeight.w500,
                          color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                        ),
                        SizedBox(height: 12),
                        HtmlWidget(
                          communityMeetings
                              .communityMeetingsList[widget.index].description!,
                          textStyle:
                              TextStyle(fontSize: 13, color: AppColors.white),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Selected Slot",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(
                                    text:
                                        "${communityMeetings.communityMeetingsList[widget.index].availability![0].day}\n${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![0].startTime} - ${communityMeetings.communityMeetingsList[widget.index].availability![0].slots![0].endTime}",
                                    textSize: 13),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                             TextWidget(
                                  text:
                                      "${communityMeetings.communityMeetingsList[widget.index].duration} minutes",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(text: "30 minutes", textSize: 13),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Price",
                                  textSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                                ),
                                SizedBox(height: 8),
                                TextWidget(
                                    text:
                                        "\u{20B9}${communityMeetings.communityMeetingsList[widget.index].amount}/-",
                                    textSize: 13),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: AppButton.outlineButton(
                    borderColor: GetStoreData.getStore.read('isInvestor')?AppColors.primaryInvestor:AppColors.primary,
                    onButtonPressed: () {
                      Get.back();
                    },
                    title: "Cancel"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Helper.loader(context);
                      communityMeetings.bookCommunityMeeting(
                          communityMeetings
                              .communityMeetingsList[widget.index].id
                              .toString(),
                          communityMeetings.communityMeetingsList[widget.index]
                              .availability![0].day,
                          communityMeetings.communityMeetingsList[widget.index]
                              .availability![0].slots![0].startTime,
                          communityMeetings.communityMeetingsList[widget.index]
                              .availability![0].slots![0].endTime);
                    },
                    title: "Proceed to Payment"),
              ),
            ]),
          ),
        ));
  }
}
