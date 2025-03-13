import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';

class CreateNewList extends StatefulWidget {
  const CreateNewList({super.key});

  @override
  State<CreateNewList> createState() => _CreateNewListState();
}

class _CreateNewListState extends State<CreateNewList> {
  TextEditingController listNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String sharingType = "Private";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Create New List"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyCustomTextField.textField(
                  hintText: "Enter List Name",
                  lableText: "List Name",
                  controller: listNameController),
              sizedTextfield,
              MyCustomTextField.textField(
                  hintText: "Enter Description",
                  lableText: "Description",
                  maxLine: 4,
                  controller: descriptionController),
              sizedTextfield,
              DropDownWidget(
                  status: sharingType,
                  lable: "Sharing",
                  statusList: const ["Private", "Public", "Team"],
                  onChanged: (v) {
                    sharingType = v!;
                    setState(() {});
                  }),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child:
              AppButton.primaryButton(onButtonPressed: () {}, title: "Create"),
        ),
      ),
    );
  }
  
}
