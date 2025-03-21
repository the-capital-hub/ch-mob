import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunityUpdateSettingsController extends GetxController {
  Future deleteCommunity() async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteCommunity + createdCommunityId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
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

  Future updateCommunity(base64) async {
    var response = await ApiBase.pachRequest(
      body: {
        "name": communityNameController.text,
        "size": communitySize,
        "subscription": subscriptionType.toLowerCase(),
        "amount": subscriptionAmountController.text.isEmpty
            ? null
            : int.tryParse(subscriptionAmountController.text),
        "isOpen": isOpen,
        "image": base64,
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
