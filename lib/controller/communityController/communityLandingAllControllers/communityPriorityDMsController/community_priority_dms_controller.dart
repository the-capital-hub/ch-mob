import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityPriorityDMsModel/community_priority_dms_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

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

  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController amountController = TextEditingController();
  TextEditingController responseTimelineController = TextEditingController();
  TextEditingController topicsController = TextEditingController();

  Future createCommunityPriorityDM(topics) async {
    String description = "";
    await descriptionController
        .getText()
        .then((val) => description = val);
    var bod = {
      "title": titleController.text,
      "description": description,
      "amount": amountController.text.isEmpty
          ? null
          : int.tryParse(amountController.text),
      "timeline": responseTimelineController.text.isEmpty
          ? null
          : int.tryParse(responseTimelineController.text),
      "topics": topics
    };
    log(bod.toString());
    var response = await ApiBase.postRequest(
      body: {
        "title": titleController.text,
        "description": description,
        "amount": amountController.text.isEmpty
            ? null
            : int.tryParse(amountController.text),
        "timeline": responseTimelineController.text.isEmpty
            ? null
            : int.tryParse(responseTimelineController.text),
        "topics": topics
      },
      withToken: true,
      extendedURL: ApiUrl.createCommunityPriorityDM + createdCommunityId,
    );

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityPriorityDMs();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateCommunityPriorityDM(topics, priorityDMId) async {
   String description = "";
    await descriptionController
        .getText()
        .then((val) => description = val);
    var response = await ApiBase.pachRequest(
        body: {
          "title": titleController.text,
          "description": description,
          "amount": amountController.text.isEmpty
              ? null
              : int.tryParse(amountController.text),
          "timeline": responseTimelineController.text.isEmpty
              ? null
              : int.tryParse(responseTimelineController.text),
          "topics": topics
        },
        withToken: true,
        extendedURL:
            "${ApiUrl.updateCommunityPriorityDM}$createdCommunityId/$priorityDMId");
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityPriorityDMs();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future deleteCommunityPriorityDM(priorityDMId) async {
    var response = await ApiBase.deleteRequest(
      extendedURL:
          "${ApiUrl.deleteCommunityPriorityDM}$createdCommunityId/$priorityDMId",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      communityPriorityDMsList
          .removeWhere((priorityDM) => priorityDM.id == priorityDMId);
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
