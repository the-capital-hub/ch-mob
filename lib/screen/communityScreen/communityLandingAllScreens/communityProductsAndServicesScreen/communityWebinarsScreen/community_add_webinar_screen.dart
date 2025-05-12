import 'dart:convert';

import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import '../../../../../controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import '../../../../../model/communityModel/communityLandingAllModels/communityEventsModel/community_event_model.dart';
import '../../../../../model/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinar_model.dart';
import '../../../../../utils/appcolors/app_colors.dart';
import '../../../../../utils/constant/asset_constant.dart';
import '../../../../../utils/getStore/get_store.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../widget/buttons/button.dart';
import '../../../../../widget/datePicker/datePicker.dart';
import '../../../../../widget/imagePickerWidget/image_picker_widget.dart';
import '../../../../../widget/text_field/text_field.dart';
import '../../../../../widget/textwidget/text_widget.dart';
import '../../../../../widget/timePicker/timePicker.dart';

class CommunityAddWebinarScreen extends StatefulWidget {
  final bool isEdit;
  CommnunityWebinar? webinar;
  CommunityAddWebinarScreen({super.key, required this.isEdit, this.webinar});

  @override
  State<CommunityAddWebinarScreen> createState() =>
      _CommunityAddWebinarScreenState();
}

class _CommunityAddWebinarScreenState extends State<CommunityAddWebinarScreen> {
  GlobalKey<FormState> webinarsFormkey = GlobalKey();
  String base64 = "";

  CommunityWebinarsController communityWebinars =
      Get.put(CommunityWebinarsController());
  @override
  void initState() {
    if (widget.isEdit) {
      String numberString = "";
      String inputString = widget.webinar!.duration!;

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
      String inputDate =
          widget.webinar!.date!; // Original date format (DD-MM-YYYY)

      // Parse the date in DD-MM-YYYY format
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime date = inputFormat.parse(inputDate);

      // Format the date into YYYY-MM-DD format
      DateFormat outputFormat = DateFormat('yyyy-MM-dd');
      String formattedDate = outputFormat.format(date);

      communityWebinars.titleController.text = widget.webinar!.title!;
      communityWebinars.dateController.text = formattedDate;

      communityWebinars.durationMinutesController.text = numberString;

      communityWebinars.startTimeController.text = widget.webinar!.startTime!;
      communityWebinars.endTimeController.text = widget.webinar!.endTime!;
      communityWebinars.priceController.text = widget.webinar!.price!;
      communityWebinars.priceDiscountController.text =
          widget.webinar!.discount!;
    } else {
      communityWebinars.titleController.clear();
      communityWebinars.durationMinutesController.clear();
      communityWebinars.dateController.clear();
      communityWebinars.startTimeController.clear();
      communityWebinars.endTimeController.clear();
      communityWebinars.priceController.clear();
      communityWebinars.priceDiscountController.clear();
    }
    super.initState();
  }

  addDescription() async {
    await communityWebinars.descriptionController
        .setText(widget.webinar!.description!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Webinar"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Form(
            key: webinarsFormkey,
            child: Column(
              children: [
                widget.isEdit
                    ? base64 != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(base64Decode(base64)),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                NetworkImage(widget.webinar!.image!),
                          )
                    : base64 != ""
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(base64Decode(base64)),
                          )
                        : const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.add_photo_alternate_outlined,
                                size: 40)),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Helper.formatDatePost(
                                      selectedDate.toString());
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            _updateEndTime(selectedTime);
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
                AppButton.primaryButton(
                    onButtonPressed: () {
                      if (webinarsFormkey.currentState!.validate()) {
                        if (widget.isEdit) {
                          Helper.loader(context);
                          communityWebinars.updateCommunityWebinar(
                              base64, widget.webinar!.id);
                        } else {
                          Helper.loader(context);
                          communityWebinars.createCommunityWebinar(
                              context, base64);
                        }
                      }
                    },
                    title: widget.isEdit ? "Update Webinar" : "Create Webinar"),
              ],
            ),
          )),
        ),
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

  void _updateEndTime(DateTime startTime) {
    final durationInMinutes =
        int.tryParse(communityWebinars.durationMinutesController.text) ?? 30;
    final endTime = startTime.add(Duration(minutes: durationInMinutes));
    communityWebinars.endTimeController.text =
        DateFormat('hh:mm a').format(endTime);
  }
}
