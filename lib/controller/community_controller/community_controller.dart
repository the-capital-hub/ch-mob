import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/01-StartupModel/community_model/getCreatedCommunityModel/get_created_community_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';
String createdCommunityId = "";
class CommunityController extends GetxController {
  
  
  var isLoading = false.obs;
  Future createCommunity(name, size, subscriptionAmount, subscription, base64) async {

    var dataSent = {
      
        "name": name,
        "size": size,
        "subscription" : subscription,
        "amount":subscriptionAmount,
        "adminId": "${GetStoreData.getStore.read('id')}",
        "image": base64,

      };
      
      log(dataSent.toString());
    var response = await ApiBase.postRequest(
      body: {
        "name": name,
        "size": size,
        "subscription" : subscription,
        "amount":subscriptionAmount,
        "adminId": "${GetStoreData.getStore.read('id')}",
        "image": "data:image/png;base64,$base64",
      },
      
      withToken: true,
      extendedURL: ApiUrl.createCommunity,
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
  // Future getAllCommunities(){}
   RxList<CreatedCommunity> createdCommunityDetails = <CreatedCommunity>[].obs;
  Future<void> getCommunityById() async {
  try {
    isLoading.value = true; // Set loading state to true
    createdCommunityDetails.clear();
    log(createdCommunityId);
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getCommunityById+createdCommunityId);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetCreatedCommunityModel createdCommunityModel = GetCreatedCommunityModel.fromJson(data);

      // Update the observable list with new data
      createdCommunityDetails.assignAll([createdCommunityModel.data]); // Adding events to the list
      // print(eventsList.toString());
      log("Created Community Details: $createdCommunityDetails");
    } 
  } catch (e) {
    log(" $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
Future<bool> sendJoinRequest(
   ) async {
   var  wbody = {
   "name" : "${GetStoreData.getStore.read('name')}",
   "email" : "${GetStoreData.getStore.read('email')}",
   "requestedNumber":"${GetStoreData.getStore.read('phone')
      }", 
      "adminEmail" : "${GetStoreData.getStore.read('email')}",
      "phoneNumber": "${GetStoreData.getStore.read('phone')
      }"};

    
    var response = await ApiBase.postRequest(
      body: wbody,
      withToken: true,
      extendedURL: ApiUrl.sendJoinRequest,
    );
    log(wbody.toString());
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == 200) {

      return true;
    } else {
      return false;
    }
  }

}
