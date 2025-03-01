import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/timePicker/timePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEventsScreen extends StatefulWidget {
  const CreateEventsScreen({super.key});

  @override
  State<CreateEventsScreen> createState() => _CreateEventsScreenState();
}

class _CreateEventsScreenState extends State<CreateEventsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController privacyController = TextEditingController(text : "Public");
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  String privacyStatus = "Public";
  
  static void _validateDuration(String value, TextEditingController controller) {
    if (value.isNotEmpty) {
      int? duration = int.tryParse(value);
      if (duration != null) {
        // If the value is not in the range of 1 to 60, reset the input
        if (duration < 1 || duration > 60) {
          // Show a Snackbar or an error message to the user
          print('Value should be between 1 and 60');
          controller.text = '';  // Clear the input
        }
      } else {
        // Handle invalid non-numeric input
        print('Invalid input: please enter a number');
        controller.text = '';  // Clear the input
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
                  hintText: "Enter Duration(Minutes)",
                  
                  lableText: "Duration(Minutes)",
                  textInputType: TextInputType.number,
                  onChange: (value) {
        // Validation when text changes
        _validateDuration(value, durationMinutesController);
      },
                  
                  // onTap: () async {
                  //   DateTime? selectedTime = await selectTime(context, true);

                  //   if (selectedTime != null) {
                  //     durationMinutesController.text =
                  //         selectedTime.minute.toString();
                  //   }
                  // },
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
                  textInputType: TextInputType.number,
                    lableText: "Event Price",
                    hintText: "Enter Price",
                    controller: priceController),
                sizedTextfield,
                MyCustomTextField.textField(
                  textInputType: TextInputType.number,
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
                  onButtonPressed: () async {
                    await MeetingController().createEvent(
                      context: context,
                      title: titleController.text,
                      description: descriptionController.text,
                      duration: durationMinutesController.text,
                      eventType: privacyStatus,
                      price: priceController.text,
                      discount: priceDiscountController.text,
                    );
                    Get.to(() => const EventsScreen(), preventDuplicates: false);
                  },
                  title: "Create Event"),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton.outlineButton(
                  borderColor: GetStoreData.getStore.read('isInvestor')? AppColors.primaryInvestor:AppColors.primary,
                  onButtonPressed: () {
                    titleController.clear();
                    descriptionController.clear();
                    
                    durationMinutesController.clear();
                   
                    priceController.clear();
                    priceDiscountController.clear();
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
