import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/webinars_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateNewWebinarScreen extends StatefulWidget {
  const CreateNewWebinarScreen({super.key});

  @override
  State<CreateNewWebinarScreen> createState() => _CreateNewWebinarScreenState();
}

class _CreateNewWebinarScreenState extends State<CreateNewWebinarScreen> {
  MeetingController webinarController = Get.find();
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

  void _updateEndTime(DateTime startTime) {
    final durationInMinutes =
        int.tryParse(webinarController.durationMinutesController.text) ?? 30;
    final endTime = startTime.add(Duration(minutes: durationInMinutes));
    setState(() {
      webinarController.endTimeController.text =
          DateFormat('hh:mm a').format(endTime);
    });
  }

  GlobalKey<FormState> webinarsFormkey = GlobalKey();
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
          title: "Create new webinar",
          hideBack: false,
          autoAction: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: webinarsFormkey,
            child: Column(
              children: [
                sizedTextfield,
                MyCustomTextField.textField(
                    valText: "Please enter title",
                    lableText: "Webinar Title",
                    hintText: "Enter Title",
                    controller: webinarController.titleController),
                sizedTextfield,
                MyCustomTextField.htmlTextField(
                  hintText: "Enter Description",
                  controller: webinarController.descriptionController,
                  lableText: "Description",
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
                              webinarController.dateSelected = selectedDate;
                              webinarController.startTimeController.clear();
                              webinarController.endTimeController.clear();
                              setState(() {});
                            }
                          },
                          controller: webinarController.dateController),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: MyCustomTextField.textField(
                      valText: "Please enter duration",
                      hintText: "Enter Duration(min)",
                      lableText: "Duration(min)",
                      textInputType: TextInputType.number,
                      onChange: (value) {
                        _validateDuration(
                            value, webinarController.durationMinutesController);
                        webinarController.startTimeController.clear();
                        webinarController.endTimeController.clear();
                      },
                      controller: webinarController.durationMinutesController,
                    )),
                  ],
                ),
                sizedTextfield,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: MyCustomTextField.textField(
                        valText: "Please selct start time",
                        hintText: "Select Start Time",
                        readonly: true,
                        lableText: "Start Time",
                        onTap: () async {
                          DateTime? selectedTime =
                              await selectTime(context, false, "meeting");

                          if (selectedTime != null) {
                            webinarController.startTimeController.text =
                                DateFormat('hh:mm a').format(selectedTime);
                            _updateEndTime(selectedTime);
                          }
                        },
                        controller: webinarController.startTimeController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MyCustomTextField.textField(
                        valText: "Please select end time",
                        hintText: "Select End Time",
                        readonly: true,
                        lableText: "End Time",
                        controller: webinarController.endTimeController,
                      ),
                    ),
                  ],
                ),
                sizedTextfield,
                DropDownWidget(
                    status: privacyStatus,
                    lable: "Webinar Privacy",
                    statusList: const ["Public", "Private", "Pitch Day"],
                    onChanged: (val) {
                      setState(() {
                        privacyStatus = val.toString();
                        webinarController.type = privacyStatus;
                      });
                    }),
                sizedTextfield,
                MyCustomTextField.textField(
                    valText: "Please enter price",
                    textInputType: TextInputType.number,
                    lableText: "Webinar Price",
                    hintText: "Enter Price",
                    controller: webinarController.priceController),
                sizedTextfield,
                MyCustomTextField.textField(
                    valText: "Please enter Discount (%)",
                    textInputType: TextInputType.number,
                    lableText: "Price Discount(%)",
                    hintText: "Enter Discount(%)",
                    controller: webinarController.priceDiscountController),
                sizedTextfield,
              ],
            ),
          ),
        )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: AppButton.primaryButton(
                  onButtonPressed: () {
                    if (webinarsFormkey.currentState!.validate()) {
                      Helper.loader(context);
                      webinarController.createWebinar();
                    }
                  },
                  title: "Create Webinar"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outlineButton(
                  width: 150,
                  borderColor: GetStoreData.getStore.read('isInvestor')
                      ? AppColors.primaryInvestor
                      : AppColors.primary,
                  onButtonPressed: () {
                    // webinarController.titleController.clear();
                    // webinarController.descriptionController.clear();
                    // webinarController.dateController.clear();
                    // webinarController.durationMinutesController.clear();
                    // webinarController.startTimeController.clear();
                    // webinarController.endTimeController.clear();
                    // webinarController.priceController.clear();
                    // webinarController.priceDiscountController.clear();
                    Get.back();
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
