import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommunityCreateNewWebinarScreen extends StatefulWidget {
  const CommunityCreateNewWebinarScreen({super.key});

  @override
  State<CommunityCreateNewWebinarScreen> createState() =>
      _CreateNewWebinarScreenState();
}

class _CreateNewWebinarScreenState
    extends State<CommunityCreateNewWebinarScreen> {
  MeetingController webinarController = Get.put(MeetingController());
  String privacyStatus = "Public";
  @override
  void initState() {
    super.initState();

    webinarController.type = privacyStatus;
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(
          title: "Create new webinar",
          hideBack: false,
          autoAction: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Webinar Title",
                    hintText: "Enter Title",
                    controller: webinarController.titleController),
                sizedTextfield,
                // MyCustomTextField.textField(
                //     lableText: "Description",
                //     hintText: "Enter Description",
                //     maxLine: 7,
                //     controller: webinarController.descriptionController),
                // sizedTextfield,
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
                          hintText: "Select Date",
                          readonly: true,
                          lableText: "Date",
                          onTap: () async {
                            final selectedDate =
                                await selectDate(context, DateTime.now());

                            if (selectedDate != null) {
                              webinarController.dateController.text =
                                  Helper.formatDatePost(
                                      selectedDate.toString());
                              setState(() {});
                            }
                          },
                          controller: webinarController.dateController),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: MyCustomTextField.textField(
                      hintText: "Enter Duration(min)",
                      lableText: "Duration(min)",
                      textInputType: TextInputType.number,
                      onChange: (value) {
                        _validateDuration(
                            value, webinarController.durationMinutesController);
                      },
                      controller: webinarController.durationMinutesController,
                    )),
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: MyCustomTextField.textField(
                        hintText: "Select Start Time",
                        readonly: true,
                        lableText: "Start Time",
                        onTap: () async {
                          DateTime? selectedTime =
                              await selectTime(context, false, "community");

                          if (selectedTime != null) {
                            webinarController.startTimeController.text =
                                DateFormat('hh:mm a').format(selectedTime);
                          }
                        },
                        controller: webinarController.startTimeController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MyCustomTextField.textField(
                        hintText: "Select End Time",
                        readonly: true,
                        lableText: "End Time",
                        
                        controller: webinarController.endTimeController,
                      ),
                    ),
                  ],
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                    textInputType: TextInputType.number,
                    lableText: "Webinar Price",
                    hintText: "Enter Price",
                    controller: webinarController.priceController),
                sizedTextfield,
                MyCustomTextField.textField(
                    textInputType: TextInputType.number,
                    lableText: "Price Discount(%)",
                    hintText: "Enter Discount(%)",
                    controller: webinarController.priceDiscountController),
                sizedTextfield,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: AppButton.primaryButton(
                  onButtonPressed: () {
                    webinarController.type = "Private";
                    webinarController.communityWebinarId = createdCommunityId;
                    Helper.loader(context);
                    webinarController.createWebinar().then((val) {
                      setState(() {});
                    });
                  },
                  title: "Create Webinar"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outlineButton(
                  width: 150,
                  borderColor: AppColors.primary,
                  onButtonPressed: () {
                    webinarController.titleController.clear();
                    webinarController.descriptionController.clear();
                    webinarController.dateController.clear();
                    webinarController.durationMinutesController.clear();
                    webinarController.startTimeController.clear();
                    webinarController.endTimeController.clear();
                    webinarController.priceController.clear();
                    webinarController.priceDiscountController.clear();
                    setState(() {
                      privacyStatus = "Public";
                    });
                  },
                  title: "Cancel"),
            ),
          ]),
        ),
      ),
    );
  }
}
