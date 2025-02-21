import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityEventsModel/community_events_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';


class CommunityEventsController extends GetxController{
  var isLoading = false.obs;
  RxList<CommunityEvent> communityEventsList = <CommunityEvent>[].obs;
  Future<void> getCommunityEvents() async {
  try {
    isLoading.value = true; // Set loading state to true
    communityEventsList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getWebinarsByCommunityId+"6786270472a060fa8463953f");
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetCommunityEventsModel communityEventsModel = GetCommunityEventsModel.fromJson(data);

      // Update the observable list with new data
      communityEventsList.assignAll([communityEventsModel.data]); // Adding events to the list
      // print(eventsList.toString());
      
    } 
  } catch (e) {
    log("getEvents $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
Future disableWebinar(id) async {
  var body = {"webinarId": id};
    var response = await ApiBase.pachRequest(
      extendedURL: ApiUrl.disableWebinar+id, body: body, withToken: true

    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      // messages.removeWhere((item) => item.messageId == id);
      // webinarsList.removeWhere((webinar) => webinar.id == id);
      HelperSnackBar.snackBar("Success", data["message"]);
      
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}