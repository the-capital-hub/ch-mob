import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityProductsAndMembersController/community_products_and_members_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunityAddNewProductController extends GetxController {
  CommunityProductsAndMembersController communityProducts =
      Get.put(CommunityProductsAndMembersController());
  TextEditingController productNameController = TextEditingController();
  QuillEditorController productDescriptionController = QuillEditorController();
  TextEditingController productAmountController = TextEditingController();
  bool isFree = false;
  List<String> urls = [];
  Future addProductToCommunity(base64, urls) async {
    String description = "";
    await productDescriptionController
        .getText()
        .then((val) => description = val);
    var response = await ApiBase.postRequest(
      body: {
        "name": productNameController.text,
        "description": description,
        "amount": productAmountController.text.isEmpty
            ? null
            : int.tryParse(productAmountController.text),
        "is_free": isFree,
        "image": base64,
        "URLS": urls
      },
      withToken: true,
      extendedURL: ApiUrl.addProductToCommunity + createdCommunityId,
    );

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      communityProducts.getCommunityProductsandMembers("");
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateCommunityProduct(base64, productId) async {
    String description = "";
    await productDescriptionController
        .getText()
        .then((val) => description = val);
    var response = await ApiBase.pachRequest(
        body: {
          "name": productNameController.text,
          "description": description,
          "amount": productAmountController.text.isEmpty
              ? null
              : int.tryParse(productAmountController.text),
          "is_free": isFree,
          "image": base64,
          "URLS": urls
        },
        withToken: true,
        extendedURL:
            "${ApiUrl.updateCommunityProduct}$createdCommunityId/$productId");

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      communityProducts.getCommunityProductsandMembers("");
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      Get.back();
      return false;
    }
  }
}
