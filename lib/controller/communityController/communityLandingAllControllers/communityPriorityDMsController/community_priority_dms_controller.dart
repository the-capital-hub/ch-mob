import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityPriorityDMsModel/community_priority_dms_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:get/get.dart';

class CommunityPriorityDMsController extends GetxController {
  var isLoading = false.obs;
  RxList<CommunityPriorityDMs> communityPriorityDMsList =
      <CommunityPriorityDMs>[].obs;
  RxList<Question> communityPriorityDMsQuestionList = <Question>[].obs;
  RxList<UserId> communityPriorityDMsUserIdList = <UserId>[].obs;
  Future<void> getCommunityPriorityDMs() async {
    try {
      isLoading.value = true;
      communityPriorityDMsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityPriorityDMs + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityPriorityDMsModel communityPriorityDMsModel =
            GetCommunityPriorityDMsModel.fromJson(data);
        communityPriorityDMsList
            .assignAll(communityPriorityDMsModel.data!.toList());
      }
    } catch (e) {
      log("getCommunityPriorityDMs $e");
    } finally {
      isLoading.value = false;
    }
  }
}
