import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';

class CreateEventsScreen extends StatefulWidget {
  const CreateEventsScreen({super.key});

  @override
  State<CreateEventsScreen> createState() => _CreateEventsScreenState();
}

class _CreateEventsScreenState extends State<CreateEventsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
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
            title: "Create Event", hideBack: false, autoAction: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Event Title",
                    hintText: "Enter Title",
                    controller: titleController),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Description",
                    hintText: "Enter Description",
                    maxLine: 7,
                    controller: descriptionController),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Select Duration(Minutes)",
                  readonly: true,
                  lableText: "Duration(Minutes)",
                  onTap: () async {
                    DateTime? selectedTime = await selectTime(context, true);

                    if (selectedTime != null) {
                      durationMinutesController.text =
                          selectedTime.minute.toString();
                    }
                  },
                  controller: durationMinutesController,
                ),
                sizedTextfield,
                DropDownWidget(
                    status: privacyStatus,
                    lable: "Event Privacy",
                    statusList: const ["Public", "Private", "Pitch Day"],
                    onChanged: (val) {
                      setState(() {
                        privacyStatus = val.toString();
                      });
                    }),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Event Price",
                    hintText: "Enter Price",
                    controller: priceController),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Price Discount(%)",
                    hintText: "Enter Price Discount(%)",
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
                  onButtonPressed: () {}, title: "Create Event"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outlineButton(
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
