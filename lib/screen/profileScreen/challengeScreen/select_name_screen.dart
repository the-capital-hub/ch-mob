import 'package:capitalhub_crm/screen/Auth-Process/userDetailsScreen/upload_picture_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/widget/appbar/appbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/dropdownWidget/drop_down_widget.dart';
import 'package:capitalhub_crm/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/app_var.dart';
import 'upload_brandlogo_screen.dart';

class SelectNameScreen extends StatefulWidget {
  const SelectNameScreen({super.key});

  @override
  State<SelectNameScreen> createState() => _SelectNameScreenState();
}

class _SelectNameScreenState extends State<SelectNameScreen> {
  TextEditingController brainstormingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    
    Container(
      decoration:  bgDec,
      child:
     Scaffold(
      backgroundColor: AppColors.transparent,
      appBar:
          HelperAppBar.appbarHelper(title: "Brand Identify", autoAction: true),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropDownWidget(
              lable: "Select a name",
              status: "status",
              statusList: ["statusList"],
              onChanged: (val) {})),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(UploadBrandLogoScreen());
            },
            title: "Next"),
      ),
    ));
  }
}
