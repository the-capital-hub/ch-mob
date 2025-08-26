import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/oneLinkGetModel/one_link_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../model/homeScreenLandingModel/post_data_model.dart';
import '../../model/oneLinkGetModel/company_post_model.dart';
import '../../model/oneLinkGetModel/one_link_request_model.dart';
import '../../model/profileModel/profile_post_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';
import '../../widget/bottomSheet/create_post_bottomsheet.dart';

class OneLinkController extends GetxController {
  // TextEditingController introMsgController = TextEditingController();
  QuillEditorController introMsgController = QuillEditorController();
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
        investmentPhilosophyController.text = oneLinkData.investmentPhilosophy!;
        thesisData = oneLinkData.thesis!;
        introMsgController.setText(oneLinkData.introductoryMessage!);
      }
    } catch (e) {
      log("getOnelinkData list $e");
    } finally {
      isLoading.value = false;
    }
  }

  OnelinkReqData oneLinkReqData = OnelinkReqData();
  Future getOneLinkPendingRequest() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getOneLinkPendingReq);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        OnelinkRequestModel onelinkRequestModel =
            OnelinkRequestModel.fromJson(data);
        oneLinkReqData = onelinkRequestModel.data!;
      }
    } catch (e) {
      log("getOnelink req list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future acceptOnelink(String startupid, String reqId, bool isAccept) async {
    var response = await ApiBase.postRequest(
      body: {"startUpId": startupid, "requestId": reqId},
      withToken: true,
      extendedURL: isAccept ? ApiUrl.acceptOnelink : ApiUrl.rejectOnelink,
    );
    log(response.body);
    var data = json.decode(response.body);
    Get.back();
    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      await getOneLinkPendingRequest();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future editOneLinkDetails(context) async {
    Helper.loader(context);
    String onelinkIntroMsg = "";
    await introMsgController.getText().then((val) => onelinkIntroMsg = val);

    var body = {
      "introductoryMessage": onelinkIntroMsg,
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
    String onelinkIntroMsg = "";
    await introMsgController.getText().then((val) => onelinkIntroMsg = val);
    var body = {"introductoryMessage": onelinkIntroMsg};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.onelinkIntroMsgPost, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      genratedIntroMessage = data['data'].toString();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getOneLinkDetails();
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
