import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityMeetingsModel/community_member_emails_model.dart';
import 'package:capitalhub_crm/model/communityModel/getAllCommunitiesModel/get_all_communities_model.dart';
import 'package:capitalhub_crm/model/communityModel/getCreatedCommunityModel/get_created_community_model.dart';
import 'package:capitalhub_crm/model/communityModel/myCommunitiesModel/my_communities_model.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen_inv.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/screen/homeScreen/home_screen.dart';
import 'package:capitalhub_crm/screen/landingScreen/landing_screen.dart';
import 'package:capitalhub_crm/screen/subscriptionScreen/subscription_screen.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/utils/notificationService/notification_service.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

String createdCommunityId = "";
String communityLogo = "";
String communityName = "";
bool isAdmin = false;
int addServiceIndex = 0;
CommunityController allCommunities = Get.put(CommunityController());

class CommunityController extends GetxController {
  final FirebaseNotificationService _firebaseNotificationService = Get.find();
  var isLoading = false.obs;
  var noData = false.obs;
  bool receiveEmail = false;

  Future createCommunity(
      name, size, subscriptionAmount, subscription, base64) async {
    var body = {
      "name": name,
      "size": size,
      "subscription": subscription,
      "amount": subscriptionAmount,
      "adminId": "${GetStoreData.getStore.read('id')}",
      "image": "data:image/png;base64,$base64",
    };
    // log(body.toString());
    var response = await ApiBase.postRequest(
      body: body,
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
  Future<void> getAllCommunities(communityName) async {
    try {
      isLoading.value = true;
      allCommunitiesDetails.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getAllCommunities + communityName);
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

  Future leaveCommunity(id) async {
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
      allCommunities.getAllCommunities("");
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<void> getCommunityMemberSettings() async {
    try {
      isLoading.value = true;

      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.communityMemberSettings + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        receiveEmail =
            data["data"]["receiveEmails"]["recieve_email_current_value"];
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
      }
    } catch (e) {
      log("getCommunityMemberSettings $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future toggleReceiveEmail() async {
    try {
      isLoading.value = true;
      var body = {};
      var response = await ApiBase.pachRequest(
          extendedURL: ApiUrl.toggleReceiveEmail + createdCommunityId,
          body: body,
          withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data["status"]) {
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        getCommunityMemberSettings();
        return true;
      } else {
        Get.back();
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("toggleReceiveEmail $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future googleLoginCommunity(context, GoogleSignInAccount user,
      GoogleSignInAuthentication auth, isAlreadyLoggedIn) async {
    String? fcmToken = await _firebaseNotificationService.getFcmToken();
    print("FCM Token in LoginController: $fcmToken");
    var body = {
      "credential": {
        "email": user.email,
        "serverAuthCode": user.serverAuthCode
      },
      "fcmToken": fcmToken,
    };
    log(body.toString());

    log(auth.toString());

    var response = await ApiBase.postRequest(
      body: body,
      extendedURL: ApiUrl.googleLogin,
      withToken: false,
    );

    log("Response: ${response.body}");

    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      GetStoreData.storeUserData(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']));
      await GetStoreDataList.storeUserList(
        UserModel(
          id: data['data']['user']['_id'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          email: data['data']['user']['email'],
          profileImage: data['data']['user']['profilePicture'],
          phone: data['data']['user']['phoneNumber'],
          authToken: data['data']['token'],
          isSubscribe: data['data']['user']['isSubscribed'],
          isInvestor: bool.parse(data['data']['user']['isInvestor']),
        ),
      );
      HelperSnackBar.snackBar("Success", data["message"]);
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
    }
  }
}
