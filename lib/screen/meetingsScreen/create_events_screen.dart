import 'package:capitalhub_crm/controller/meetingController/meeting_controller.dart';
import 'package:capitalhub_crm/screen/01-Investor-Section/drawerScreen/drawer_screen_inv.dart';
import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/screen/meetingsScreen/events_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CreateEventsScreen extends StatefulWidget {
  const CreateEventsScreen({super.key});

  @override
  State<CreateEventsScreen> createState() => _CreateEventsScreenState();
}

class _CreateEventsScreenState extends State<CreateEventsScreen> {
  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController privacyController =
      TextEditingController(text: "Public");
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  String privacyStatus = "Public";

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
  void initState() {
    titleController.clear();
    descriptionController.clear();

    durationMinutesController.clear();

    priceController.clear();
    priceDiscountController.clear();
    setState(() {
      privacyStatus = "Public";
    });
    super.initState();
  }

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
                MyCustomTextField.htmlTextField(
                  hintText: "Enter Description",
                  controller: descriptionController,
                  lableText: "Description",
                ),
                sizedTextfield,
                MyCustomTextField.textField(
                  hintText: "Enter Duration(Minutes)",
                  lableText: "Duration(Minutes)",
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    _validateDuration(value, durationMinutesController);
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
                    Helper.loader(context);
                    String description = "";
                    await descriptionController
                        .getText()
                        .then((val) => description = val);

                    await MeetingController().createEvent(
                      title: titleController.text,
                      description: description,
                      duration: durationMinutesController.text,
                      eventType: privacyStatus,
                      price: priceController.text,
                      discount: priceDiscountController.text,
                    );
                    
                  },
                  title: "Create Event"),
            ),
            const SizedBox(width: 12),
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
          ]),
        ),
      ),
    );
  }
}
