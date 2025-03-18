import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinars_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:get/get.dart';

class CommunityWebinarsController extends GetxController {
  var isLoading = false.obs;
  RxList<CommunityWebinars> communityWebinarsList = <CommunityWebinars>[].obs;

  Future<void> getCommunityWebinars() async {
    try {
      isLoading.value = true;
      communityWebinarsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityWebinars + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityWebinarsModel communityWebinarsModel =
            GetCommunityWebinarsModel.fromJson(data);
        communityWebinarsList.assignAll(communityWebinarsModel.data);
      }
    } catch (e) {
      log("getCommunityWebinars $e");
    } finally {
      isLoading.value = false;
    }
  }
}
