import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/01-StartupModel/oneLinkGetModel/one_link_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/profileModel/profile_post_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class OneLinkController extends GetxController {
  TextEditingController introMsgController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController secrateKeyController = TextEditingController();
  TextEditingController investmentPhilosophyController =
      TextEditingController();
  String genratedIntroMessage = "";
  String genratedSecKey = "";
  RxBool isLoading = false.obs;
  RxBool isLoadingPost = false.obs;
  OneLinkData oneLinkData = OneLinkData();
  List<Thesis> thesisData = [];
  Future getOneLinkDetails() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.oneLinkDetailsGet);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        OneLinkGetModel oneLinkGetModel = OneLinkGetModel.fromJson(data);
        oneLinkData = oneLinkGetModel.data!;
        linkController.text = oneLinkData.oneLink!;
        secrateKeyController.text = oneLinkData.secretOneLinkKey!;
        introMsgController.text = oneLinkData.introductoryMessage!;
        investmentPhilosophyController.text = oneLinkData.investmentPhilosophy!;
        thesisData = oneLinkData.thesis!;
      }
    } catch (e) {
      log("getOnelinkData list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future editOneLinkDetails(context) async {
    Helper.loader(context);
    var body = {
      "introductoryMessage": introMsgController.text,
      "investmentPhilosophy": investmentPhilosophyController.text,
      "secretOneLinkKey": secrateKeyController.text,
      "thesis": thesisData,
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.oneLinkDetailsEdit, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);

      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  // only for startup
  Future postIntroMsg(context) async {
    Helper.loader(context);
    var body = {"introductoryMessage": introMsgController.text};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.onelinkIntroMsgPost, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      genratedIntroMessage = data['data'].toString();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);

      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  // only for startup
  Future createSecrateKey(context) async {
    Helper.loader(context);
    var body = {"secretOneLinkKey": secrateKeyController.text};
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.onelinkCreateSecKey, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      genratedSecKey = data['data'].toString();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);

      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  List<ProfilePost> companyPosts = [];

  Future getCompanyProfilePost() async {
    try {
      isLoadingPost.value = true;
      companyPosts.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getCompPostCompany);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ProfilePostModel profilePostModel = ProfilePostModel.fromJson(data);
        companyPosts.addAll(profilePostModel.data!);
      }
    } catch (e) {
      log("getnotification list $e");
    } finally {
      isLoadingPost.value = false;
    }
  }

  Future deletePost(BuildContext context, String postId) async {
    isLoading.value = true;

    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.deleteCompPostCompany}$postId",
    );

    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }
}
