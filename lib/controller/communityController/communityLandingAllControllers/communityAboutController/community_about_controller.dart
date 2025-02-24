import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityAboutModel/community_about_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:get/get.dart';

class CommunityAboutController extends GetxController{
  var isLoading = false.obs;
  RxList<AboutCommunity> aboutCommunityList = <AboutCommunity>[].obs;
  RxList<Community> aboutCommunityDetailsList = <Community>[].obs;
  Future<void> getAboutCommunity() async {
  try {
    isLoading.value = true; // Set loading state to true
    aboutCommunityList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getCommunityById+createdCommunityId);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetAboutCommunityModel communityAboutModel = GetAboutCommunityModel.fromJson(data);

      // Update the observable list with new data
      aboutCommunityList.assignAll([communityAboutModel.data]); // Adding events to the list
      // print(eventsList.toString());
      aboutCommunityDetailsList.assignAll([communityAboutModel.data.community]);
      
      
    } 
  } catch (e) {
    log("getEvents $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
}