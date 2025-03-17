import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityEventsModel/community_events_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';

class CommunityEventsController extends GetxController {
  var isLoading = false.obs;
  RxList<CommunityEvent> communityEventsList = <CommunityEvent>[].obs;
  Future<void> getCommunityEvents() async {
    try {
      isLoading.value = true;
      communityEventsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getWebinarsByCommunityId + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityEventsModel communityEventsModel =
            GetCommunityEventsModel.fromJson(data);
        communityEventsList.assignAll([communityEventsModel.data]);
      }
    } catch (e) {
      log("getCommunityEvents $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future disableWebinar(id) async {
    var body = {"webinarId": id};
    var response = await ApiBase.pachRequest(
        extendedURL: ApiUrl.disableWebinar + id, body: body, withToken: true);
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
}
