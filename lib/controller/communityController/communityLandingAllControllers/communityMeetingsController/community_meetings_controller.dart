import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinars_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:get/get.dart';

class CommunityMeetingsController extends GetxController {
  var isLoading = false.obs;
  RxList<CommunityWebinars> communityMeetingsList = <CommunityWebinars>[].obs;

  Future<void> getCommunityMeetings() async {
    try {
      isLoading.value = true;
      communityMeetingsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityMeetings + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityWebinarsModel communityWebinarsModel =
            GetCommunityWebinarsModel.fromJson(data);
        communityMeetingsList.assignAll(communityWebinarsModel.data);
      }
    } catch (e) {
      log("getCommunityMeetings $e");
    } finally {
      isLoading.value = false;
    }
  }
}
