import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/community_member_emails_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/getAllCommunitiesModel/get_all_communities_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/getCreatedCommunityModel/get_created_community_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/myCommunitiesModel/my_communities_model.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';

String createdCommunityId = "";
String communityLogo = "";
String communityName = "";
bool isAdmin = false;
int addServiceIndex = 0;
CommunityController allCommunities = Get.put(CommunityController());

class CommunityController extends GetxController {
  var isLoading = false.obs;
  var noData = false.obs;

  Future createCommunity(
      name, size, subscriptionAmount, subscription, base64) async {
    var response = await ApiBase.postRequest(
      body: {
        "name": name,
        "size": size,
        "subscription": subscription,
        "amount": subscriptionAmount,
        "adminId": "${GetStoreData.getStore.read('id')}",
        "image": "data:image/png;base64,$base64",
      },
      withToken: true,
      extendedURL: ApiUrl.createCommunity,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      createdCommunityId = data["data"]["_id"];
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<CreatedCommunity> createdCommunityDetails = <CreatedCommunity>[].obs;
  Future<void> getCommunityById() async {
    try {
      isLoading.value = true;
      createdCommunityDetails.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityById + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCreatedCommunityModel createdCommunityModel =
            GetCreatedCommunityModel.fromJson(data);
        createdCommunityDetails.assignAll([createdCommunityModel.data]);
      } else if (data["status"] == false) {
        noData.value = true;
      }
    } catch (e) {
      log("getCommunityById $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<AllCommunities> allCommunitiesDetails = <AllCommunities>[].obs;
  Future<void> getAllCommunities() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getAllCommunities);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetAllCommunitiesModel allCommunityModel =
            GetAllCommunitiesModel.fromJson(data);
        allCommunitiesDetails.assignAll(allCommunityModel.data);
      }
    } catch (e) {
      log("getAllCommunities $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<MyCommunities> myCommunitiesDetails = <MyCommunities>[].obs;
  Future<void> getMyCommunities() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getMyCommunities);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        MyCommunitiesModel myCommunityModel = MyCommunitiesModel.fromJson(data);
        myCommunitiesDetails.assignAll(myCommunityModel.data);
      }
    } catch (e) {
      log("getMyCommunities $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future leaveCommunity(context, id) async {
    Helper.loader(context);
    var response = await ApiBase.postRequest(
      body: {},
      withToken: true,
      extendedURL: ApiUrl.leaveCommunity + id,
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

  Future joinCommunity() async {
    var response = await ApiBase.postRequest(
      body: {
        "memberIds": ["${GetStoreData.getStore.read('id')}"],
      },
      withToken: true,
      extendedURL: ApiUrl.joinCommunity + createdCommunityId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      Get.to(() => const CommunityLandingScreen());
      allCommunities.getAllCommunities();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
