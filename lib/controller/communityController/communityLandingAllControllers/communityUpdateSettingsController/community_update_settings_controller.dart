import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../widget/bottomSheet/create_post_bottomsheet.dart';

class CommunityUpdateSettingsController extends GetxController {
  Future deleteCommunity() async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteCommunity + createdCommunityId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      GetStoreData.getStore.read('isInvestor')
          ? Get.offAll(const LandingScreenInvestor())
          : Get.offAll(const LandingScreen());
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  TextEditingController communityNameController = TextEditingController();
  QuillEditorController aboutCommunityController = QuillEditorController();
  TextEditingController whatsappGroupLinkController = TextEditingController();
  TextEditingController subscriptionAmountController = TextEditingController();
  String communitySize = "Less than 10K";
  String subscriptionType = "Free";
  bool isOpen = false;
  List<String> termsAndConditions = [];

  // String cleanHtmlDescription(String description) {
  //   description = description.replaceAll(RegExp(r'(<br>\s*)+'), '<br>');

  //   description = description.replaceAll(RegExp(r'<p>\s*<\/p>'), '');

  //   description =
  //       description.replaceAll(RegExp(r'<p>\s*<br>\s*<\/p>'), '<p><br></p>');

  //   description = description.trim();

  //   return description;
  // }

  Future updateCommunity(base64,bannerBase64) async {
    String description = "";
    await aboutCommunityController.getText().then((val) => description = val);
    // description = cleanHtmlDescription(description);
    var response = await ApiBase.pachRequest(
      body: {
        "name": communityNameController.text,
        "size": communitySize,
        "about": description,
        "subscription": subscriptionType.toLowerCase(),
        "amount": subscriptionAmountController.text.isEmpty
            ? null
            : int.tryParse(subscriptionAmountController.text),
        "isOpen": isOpen,
        "image": base64,
        "banner": bannerBase64,
        "whatsapp_group_link": whatsappGroupLinkController.text,
        "terms_and_conditions": termsAndConditions
      },
      withToken: true,
      extendedURL: ApiUrl.updateCommunity + createdCommunityId,
    );

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      createdCommunityId = data["data"]["_id"];
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
