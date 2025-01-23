import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/datePicker/datePicker.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateNewWebinarScreen extends StatefulWidget {
  const CreateNewWebinarScreen({super.key});

  @override
  State<CreateNewWebinarScreen> createState() => _CreateNewWebinarScreenState();
}

class _CreateNewWebinarScreenState extends State<CreateNewWebinarScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController privacyController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  String privacyStatus = "Private";

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
                    controller: titleController),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Description",
                    hintText: "Enter Description",
                    maxLine: 7,
                    controller: descriptionController),
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
                          hintText: "Select Date",
                          readonly: true,
                          lableText: "Date",
                          onTap: () async {
                            final selectedDate =
                                await selectDate(context, DateTime.now());

                            if (selectedDate != null) {
                              dateController.text = Helper.formatDatePost(
                                  selectedDate.toString());
                              setState(() {});
                            }
                          },
                          controller: dateController),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: MyCustomTextField.textField(
                      hintText: "Select Duration(min)",
                      readonly: true,
                      lableText: "Duration(min)",
                      onTap: () async {
                        DateTime? selectedTime =
                            await selectTime(context, true);

                        if (selectedTime != null) {
                          durationMinutesController.text =
                              selectedTime.minute.toString();
                        }
                      },
                      controller: durationMinutesController,
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
                              await selectTime(context, false);

                          if (selectedTime != null) {
                            startTimeController.text =
                                DateFormat('hh:mm a').format(selectedTime);
                          }
                        },
                        controller: startTimeController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MyCustomTextField.textField(
                        hintText: "Select End Time",
                        readonly: true,
                        lableText: "End Time",
                        onTap: () async {
                          DateTime? selectedTime =
                              await selectTime(context, false);

                          if (selectedTime != null) {
                            endTimeController.text =
                                DateFormat('hh:mm a').format(selectedTime);
                          }
                        },
                        controller: endTimeController,
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
                      });
                    }),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Webinar Price",
                    hintText: "Enter Price",
                    controller: priceController),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Price Discount(%)",
                    hintText: "Enter Discount(%)",
                    controller: priceDiscountController),
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
                  onButtonPressed: () {}, title: "Create Webinar"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outlineButton(
                  width: 150,
                  borderColor: AppColors.primary,
                  onButtonPressed: () {},
                  title: "Cancel"),
            ),
          ]),
        ),
      ),
    );
  }
}