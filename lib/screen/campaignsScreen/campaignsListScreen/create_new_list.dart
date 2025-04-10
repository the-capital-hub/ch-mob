import 'package:capitalhub_crm/controller/campaignsController/campaigns_controller.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/helper.dart';

class CreateNewList extends StatefulWidget {
  bool isEdit;
  int? index;
  CreateNewList({super.key, this.index, required this.isEdit});

  @override
  State<CreateNewList> createState() => _CreateNewListState();
}

class _CreateNewListState extends State<CreateNewList> {
  CampaignsController campaignsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    if (widget.isEdit) {
      campaignsController.listNameController.text =
          campaignsController.campaignList[widget.index!].listName!;
      campaignsController.descriptionController.text =
          campaignsController.campaignList[widget.index!].description!;
      campaignsController.sharingType = "Private";
    } else {
      campaignsController.listNameController.clear();
      campaignsController.descriptionController.clear();
      campaignsController.sharingType = "Private";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bgDec,
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: HelperAppBar.appbarHelper(title: "Create New List"),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                MyCustomTextField.textField(
                    valText: "Please enter list name",
                    hintText: "Enter List Name",
                    lableText: "List Name",
                    controller: campaignsController.listNameController),
                sizedTextfield,
                MyCustomTextField.textField(
                    valText: "Please enter description",
                    hintText: "Enter Description",
                    lableText: "Description",
                    maxLine: 4,
                    controller: campaignsController.descriptionController),
                sizedTextfield,
                DropDownWidget(
                    status: campaignsController.sharingType,
                    lable: "Sharing",
                    statusList: const ["Private", "Public", "Team"],
                    onChanged: (v) {
                      campaignsController.sharingType = v!;
                      setState(() {});
                    }),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton.primaryButton(
              onButtonPressed: () {
                if (formkey.currentState!.validate()) {
                  Helper.loader(context);
                  campaignsController.createCampaignList(
                      isEdit: widget.isEdit,
                      listId: widget.isEdit
                          ? campaignsController
                              .campaignList[widget.index!].listId
                          : null);
                }
              },
              title: widget.isEdit ? "Update" : "Create"),
        ),
      ),
    );
  }
}
