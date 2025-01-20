import 'dart:math';

import 'package:capitalhub_crm/screen/Auth-Process/selectWhatYouAreScreen/select_role_screen.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/app_var.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/getStore/get_store.dart';
//comment

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: bgDec,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  PngAssetPath.logoutImg,
                  height: 100,
                ),
                sizedTextfield,
                const TextWidget(
                    text: "Are you sure, you want to logout ?",
                    textSize: 18,
                    fontWeight: FontWeight.w500),
                sizedTextfield,
                sizedTextfield,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton.primaryButton(
                        onButtonPressed: () {
                          GetStoreData.getStore.erase().then((val) {
                            Get.offAll(SelectRoleScreen());
                          });
                          ;
                        },
                        height: 40,
                        width: 100,
                        title: "Logout"),
                    const SizedBox(width: 12),
                    AppButton.outlineButton(
                        onButtonPressed: () {
                          Get.back();
                        },
                        height: 40,
                        width: 100,
                        title: "Cancel")
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
