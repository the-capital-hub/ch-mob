import 'package:capitalhub_crm/controller/companyController/company_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helper/helper.dart';
import '../../widget/datePicker/datePicker.dart';

class AffiliationRequestScreen extends StatefulWidget {
  final String startupId;
  const AffiliationRequestScreen({Key? key, required this.startupId})
      : super(key: key);

  @override
  _AffiliationRequestScreenState createState() =>
      _AffiliationRequestScreenState();
}

class _AffiliationRequestScreenState extends State<AffiliationRequestScreen> {
  CompanyController companyController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Add Affiliation Requests"),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              MyCustomTextField.textField(
                  lableText: "Role",
                  hintText: "Enter Role",
                  controller: companyController.roleController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Description",
                  hintText: "Enter Description",
                  controller: companyController.descriptionController),
              sizedTextfield,
              MyCustomTextField.textField(
                  lableText: "Start Date",
                  hintText: "Enter Start Date",
                  onTap: () async {
                    final selectedDate =
                        await selectDate(context, DateTime.now());
                    if (selectedDate != null) {
                      companyController.startDateController.text =
                          Helper.formatDate(date: selectedDate.toString());
                      setState(() {});
                    }
                  },
                  readonly: true,
                  controller: companyController.startDateController),
              CheckboxListTile(
                value: companyController.currentWorking,
                onChanged: (value) {
                  companyController.currentWorking = value!;
                  setState(() {});
                },
                activeColor: GetStoreData.getStore.read('isInvestor')
                    ? AppColors.primaryInvestor
                    : AppColors.primary,
                title: const TextWidget(
                    text: "Currently Working here", textSize: 14),
              ),
              if (!companyController.currentWorking)
                MyCustomTextField.textField(
                    lableText: "End Date",
                    hintText: "Enter End Date",
                    onTap: () async {
                      final selectedDate =
                          await selectDate(context, DateTime.now());
                      if (selectedDate != null) {
                        companyController.endDateController.text =
                            Helper.formatDate(date: selectedDate.toString());
                        setState(() {});
                      }
                    },
                    readonly: true,
                    controller: companyController.endDateController),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                Helper.loader(context);
                companyController.addAffilatedRequest(widget.startupId);
              },
              title: "Done"),
        ),
      ),
    );
  }
}
