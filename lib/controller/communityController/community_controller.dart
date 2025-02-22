import 'dart:convert';
import 'dart:developer';
// import 'package:capitalhub_crm/model/01-StartupModel/community_model/getCommunityPostsModel/community_post_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/getAllCommunitiesModel/get_all_communities_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/getCreatedCommunityModel/get_created_community_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/myCommunitiesModel/my_communities_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
String createdCommunityId = "676fac57e86b189878cdfb9a";
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

RxList<AllCommunities> allCommunitiesDetails = <AllCommunities>[].obs;
  Future<void> getAllCommunities() async {
  try {
    isLoading.value = true; // Set loading state to true
   
    log(createdCommunityId);
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getAllCommunities);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetAllCommunitiesModel allCommunityModel = GetAllCommunitiesModel.fromJson(data);

      // Update the observable list with new data
      allCommunitiesDetails.assignAll(allCommunityModel.data); // Adding events to the list
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

RxList<MyCommunities> myCommunitiesDetails = <MyCommunities>[].obs;
  Future<void> getMyCommunities() async {
  try {
    isLoading.value = true; 
   
    
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getMyCommunities);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      MyCommunitiesModel myCommunityModel = MyCommunitiesModel.fromJson(data);

      
      myCommunitiesDetails.assignAll(myCommunityModel.data);
     
      
    } 
  } catch (e) {
    log(" $e");
   
  } finally {
    isLoading.value = false;
  }
}

 
  Future leaveCommunity(context,id) async {

Helper.loader(context);
    
    var response = await ApiBase.postRequest(
      body: {},
      
      withToken: true,
      extendedURL: ApiUrl.leaveCommunity+id,
    );
    
    
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getMyCommunities();
      
      

      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }


  
}
