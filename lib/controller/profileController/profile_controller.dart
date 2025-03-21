import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/screen/profileScreen/personal_info_screen.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:flutter/cupertino.dart';
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
        profileData = profileModel.data;
        firstNameController.text = profileData.user!.firstName!;
        lastNameController.text = profileData.user!.lastName!;
        userNameController.text = profileData.user!.userName!;
        if (GetStoreData.getStore.read('isInvestor')) {
          companyController.text =
              profileData.user!.professionalInfo!.companyName!;
          designationController.text =
              profileData.user!.professionalInfo!.designation!;
          industryController.text =
              profileData.user!.professionalInfo!.industry!;
          selectExperience = profileData.user!.professionalInfo!.experience!;
        }
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
          ? "mypost"
          : tabindex == 1
              ? "featured"
              : "company";
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

  Future updateProfile(String? base64, List<CompanyInfo> experience,
      List<EducationInfo> education, BuildContext context) async {
    Helper.loader(context);
    isLoading.value = true;
    List<Map<String, dynamic>> experienceJsonList =
        experience.map((e) => e.toJson()).toList();
    List<Map<String, dynamic>> educationJsonList =
        education.map((e) => e.toJson()).toList();

    var body = {
      if (base64 != null) "profilePicture": base64,
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "userName": userNameController.text,
      "experiences": experienceJsonList,
      "educations": educationJsonList
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.updateProfile, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      profileData = profileModel.data;
      Get.back();
      Get.back();
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  String selectExperience = "Select Experience";
  TextEditingController companyController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController industryController = TextEditingController();
  Future updateProffesionalInfo() async {
    isLoading.value = true;
    var body = {
      "companyName": companyController.text,
      "designation": designationController.text,
      "industry": industryController.text,
      "experience": selectExperience
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.updateProfile, withToken: true);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      profileData = profileModel.data;
      Get.back();
      Get.back();
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  String? startupBase64;
  TextEditingController startupCompanyNameController = TextEditingController();
  TextEditingController startupCompanyDescriptionController =
      TextEditingController();
  TextEditingController startupEquityController = TextEditingController();

  Future<bool> addEditMyInvestment({
    String? userId,
    required bool isEdit,
  }) async {
    var body = {
      if (startupBase64 != null) "logo": startupBase64,
      "name": startupCompanyNameController.text,
      "description": startupCompanyDescriptionController.text,
      "investedEquity": startupEquityController.text
    };
    var response = isEdit
        ? await ApiBase.pachRequest(
            body: body,
            extendedURL: "${ApiUrl.addMyInvestment}/$userId",
            withToken: true)
        : await ApiBase.postRequest(
            body: body, extendedURL: ApiUrl.addMyInvestment, withToken: true);
    log(response.body);
    Get.back(closeOverlays: true);
    Get.back();
    var data = json.decode(response.body);
    if (data["status"] == true) {
      getProfile();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> delMyInvestment(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.addMyInvestment}/$id",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back(closeOverlays: true);
      Get.back();
      getProfile();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateBio(BuildContext context, String bio) async {
    Helper.loader(context);
    isLoading.value = true;

    var body = {"bio": bio};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.updateProfile, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      profileData = profileModel.data;
      Get.back();
      Get.back();
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  TextEditingController philosophyController = TextEditingController();
  Future updatePhilosophy(BuildContext context) async {
    Helper.loader(context);
    isLoading.value = true;
    var body = {"investmentPhilosophy": philosophyController.text};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.updateProfile, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ProfileModel profileModel = ProfileModel.fromJson(data);
      profileData = profileModel.data;
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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  // TextEditingController designationController = TextEditingController();
  // TextEditingController educationController = TextEditingController();
  // TextEditingController experienceController = TextEditingController();
}
