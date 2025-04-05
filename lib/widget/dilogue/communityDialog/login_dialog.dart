import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityMeetingsController/community_meetings_controller.dart';
import 'package:capitalhub_crm/utils/apiService/google_service.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> showLoginAlertDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.blackCard,
        title:
            CircleAvatar(radius: 40, child: Image.asset(PngAssetPath.appIcon)),
        content: TextWidget(
          align: TextAlign.center,
          text: "Please login with Google\nbefore Creating the Service",
          textSize: 16,
          color: AppColors.white,
        ),
        actions: <Widget>[
          AppButton.primaryButton(
              onButtonPressed: () async {
                Get.back();
                final user = await GoogleSignInService.signIn();
                if (user != null) {
                  final GoogleSignInAuthentication auth =
                      await user.authentication;

                  communityLogin.googleLoginCommunity(
                      context, user, auth, true);
                  var body = {
                    "credential": {
                      "displayName": user.displayName,
                      "email": user.email,
                      "id": user.id,
                      "photoURL": user.photoUrl
                    },
                  };
                  log(body.toString());
                } else {
                  log("Login failed");
                }
              },
              title: "Google Account Login"),
        ],
      );
    },
  );
}
