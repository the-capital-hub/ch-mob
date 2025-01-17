import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/profileModel/profile_model.dart';
import '../../model/01-StartupModel/profileModel/profile_post_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isTabLoading = false.obs;
  ProfileData profileData = ProfileData();
  Future getProfile() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getProfileUrl +
              GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ProfileModel profileModel = ProfileModel.fromJson(data);
        profileData = profileModel.data!;
      }
    } catch (e) {
      log("getProfileddd $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<ProfilePost> profilePosts = [];
  Future getProfilePost(tabindex) async {
    try {
      var tabValue = tabindex == 0
          ? "featured"
          : tabindex == 1
              ? "company"
              : "mypost";
      profilePosts.clear();
      isTabLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getProfilePost + tabValue);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ProfilePostModel profilePostModel = ProfilePostModel.fromJson(data);
        profilePosts.addAll(profilePostModel.data!);
      }
    } catch (e) {
      log("getPost $e");
    } finally {
      isTabLoading.value = false;
    }
  }

  Future updateProfile(String? base64, BuildContext context) async {
    Helper.loader(context);
    isLoading.value = true;
    var body = {
      if (base64 != null) "profilePicture": base64,
      "designation": designationController.text,
      "education": educationController.text,
      "experience": experienceController.text,
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: "${ApiUrl.updateProfile}", withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      profileData = profileModel.data!;
      Get.back();
      Get.back();
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future updateBio(BuildContext context, String bio) async {
    Helper.loader(context);
    isLoading.value = true;

    var body = {"bio": bio};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: "${ApiUrl.updateProfile}", withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      profileData = profileModel.data!;
      Get.back();
      Get.back();
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future deletePost(BuildContext context, int tabindex, String postId) async {
    isTabLoading.value = true;
    var apiUrl = tabindex == 0
        ? ApiUrl.deleteFeaturePost
        : tabindex == 1
            ? ApiUrl.deleteCompanyPost
            : ApiUrl.deleteMyPost;

    var response = await ApiBase.deleteRequest(
      extendedURL: "$apiUrl$postId",
    );

    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isTabLoading.value = false;
  }

  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
}
