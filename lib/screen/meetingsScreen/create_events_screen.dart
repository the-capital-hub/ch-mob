import 'package:capitalhub_crm/screen/drawerScreen/drawer_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';

class CreateEventsScreen extends StatefulWidget {
  const CreateEventsScreen({super.key});

  @override
  State<CreateEventsScreen> createState() => _CreateEventsScreenState();
}

class _CreateEventsScreenState extends State<CreateEventsScreen> {
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventDurationMinutesController = TextEditingController();
  TextEditingController eventPrivacyController = TextEditingController();
  TextEditingController eventPriceController = TextEditingController();
  TextEditingController eventPriceDiscountController = TextEditingController();
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
                    hintText: "Event Title",
                    controller: eventTitleController),
                sizedTextfield,
              
                MyCustomTextField.textField(
                    lableText: "Company",
                    hintText: "Enter Description",
                    maxLine: 7,
                    controller: eventTitleController),
                sizedTextfield,
                
                MyCustomTextField.textField(
                  lableText: "Duration(Minutes)",
                  hintText: "30",
                  controller: eventTitleController,
                ),
                sizedTextfield,
                
                DropDownWidget(
                    status: privacyStatus,
                    lable: "Event Privacy",
                    statusList: ["Public","Private","Pitch Day"],
                    onChanged: (val) {
                      setState(() {
                        privacyStatus = val.toString();
                      });
                    }),
                sizedTextfield,
                
                MyCustomTextField.textField(
                    lableText: "Event Price",
                    hintText: "0",
                    controller: eventTitleController),
                sizedTextfield,
                MyCustomTextField.textField(
                    lableText: "Price Discount(%)",
                    hintText: "0",
                    controller: eventTitleController),
                sizedTextfield,
                
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AppButton.primaryButton(
                width: 150, onButtonPressed: () {}, title: "Create Event"),
                SizedBox(width:12),
            AppButton.outlineButton(
                width: 150,
                borderColor: AppColors.orange,
                onButtonPressed: () {},
                title: "Cancel"),
          ]),
        ),
      ),
    );
  }
}
