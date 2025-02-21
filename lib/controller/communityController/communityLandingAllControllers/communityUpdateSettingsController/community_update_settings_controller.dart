import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityUpdateSettingsController extends GetxController{
Future deleteCommunity() async {
  
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteCommunity + "67a59ee206ff660a9febe5f5",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      
      // createdCommunityDetails.removeWhere((community) => community.id == createdCommunityId);
      HelperSnackBar.snackBar("Success", data["message"]);
      
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  TextEditingController communityNameController = TextEditingController();
  TextEditingController aboutCommunityController = TextEditingController();
  TextEditingController whatsappGroupLinkController = TextEditingController();
  TextEditingController subscriptionAmountController = TextEditingController();
  String communitySize = "Less than 10K";
  String subscriptionType = "Free";
  bool isOpen = false;

Future updateCommunity(base64) async {

    var dataSent = {
      
        "name": communityNameController.text,
        "size": communitySize,
        "subscription" : subscriptionType,
        "amount":subscriptionAmountController.text.isEmpty
              ? null
              : int.tryParse(subscriptionAmountController.text),
        "isOpen": isOpen,
        // "image": base64,
        "whatsapp_group_link": whatsappGroupLinkController.text,
        "adminId": "${GetStoreData.getStore.read('id')}",
         "image": "data:image/png;base64,$base64",

      };
      
      log(dataSent.toString());
    var response = await ApiBase.pachRequest(
      body: {
       
        "name": communityNameController.text,
        "size": communitySize,
        "subscription" : subscriptionType.toLowerCase(),
        "amount":subscriptionAmountController.text.isEmpty
              ? null
              : int.tryParse(subscriptionAmountController.text),
        "isOpen": isOpen,
        "image": base64,
        "whatsapp_group_link": whatsappGroupLinkController.text,
        // "adminId": "${GetStoreData.getStore.read('id')}",
        
      },
      
      withToken: true,
      extendedURL: ApiUrl.updateCommunity+"67a59ee206ff660a9febe5f5",
    );
    //working
    
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      createdCommunityId = data["data"]["_id"];
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      
      log(createdCommunityId);

      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }


  
}