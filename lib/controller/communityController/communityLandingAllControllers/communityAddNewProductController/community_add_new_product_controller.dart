import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityAddNewProductController extends GetxController{
  
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productAmountController = TextEditingController();
  bool isFree = false;
  Future addProductToCommunity(base64,urls) async {
    

    var dataSent = {
      
        "name": productNameController.text,
        
        "description" : productDescriptionController.text,
        "amount":productAmountController.text.isEmpty
              ? null
              : int.tryParse(productAmountController.text),
        "is_free": isFree,
        "image": base64,
        "URLS":urls
       
         

      };
      
      log(dataSent.toString());
    var response = await ApiBase.postRequest(
      body: {
       
         "name": productNameController.text,
        
        "description" : productDescriptionController.text,
        "amount":productAmountController.text.isEmpty
              ? null
              : int.tryParse(productAmountController.text),
        "is_free": isFree,
        "image": base64,
        "URLS":urls
        
      },
      
      withToken: true,
      extendedURL: ApiUrl.addProductToCommunity+createdCommunityId,
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