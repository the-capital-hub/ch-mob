import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/communityMeetingsModel.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunityMeetingsController extends GetxController {
  var isLoading = false.obs;
  RxList<CommunityMeetings> communityMeetingsList = <CommunityMeetings>[].obs;

  Future<void> getCommunityMeetings() async {
    try {
      isLoading.value = true;
      communityMeetingsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityMeetings + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityMeetingsModel communityMeetingsModel =
            GetCommunityMeetingsModel.fromJson(data);
        communityMeetingsList.assignAll(communityMeetingsModel.data!);
      }
    } catch (e) {
      log("getCommunityMeetings $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController amountController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController topicsController = TextEditingController();

  Future createCommunityMeeting(topics) async {
    String descriptionText = await descriptionController.getText();
    var bod = {
      "title": titleController.text,
      "description": descriptionText,
      "amount": amountController.text.isEmpty
          ? null
          : int.tryParse(amountController.text),
      "duration": durationController.text.isEmpty
          ? null
          : int.tryParse(durationController.text),
      "topics": topics
    };
    log(bod.toString());
    var response = await ApiBase.postRequest(
      body: {
        "title": titleController.text,
        "description": descriptionText,
        "amount": amountController.text.isEmpty
            ? null
            : int.tryParse(amountController.text),
        "duration": durationController.text.isEmpty
            ? null
            : int.tryParse(durationController.text),
        "topics": topics
      },
      withToken: true,
      extendedURL: ApiUrl.createCommunityMeeting + createdCommunityId,
    );

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

  Future updateCommunityMeeting(topics, meetingId) async {
    String descriptionText = await descriptionController.getText();
    var response = await ApiBase.pachRequest(
      body: {
        "title": titleController.text,
        "description": descriptionText,
        "amount": amountController.text.isEmpty
            ? 0
            : int.tryParse(amountController.text),
        "duration": durationController.text.isEmpty
            ? 0
            : int.tryParse(durationController.text),
        "topics": topics
      },
      withToken: true,
      extendedURL:
          "${ApiUrl.updateCommunityMeeting}$createdCommunityId/$meetingId}",
    );
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

  Future deleteCommunityMeeting(meetingId) async {
    var response = await ApiBase.deleteRequest(
      extendedURL:
          "${ApiUrl.deleteCommunityMeeting}$createdCommunityId/$meetingId}",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      communityMeetingsList.removeWhere((meeting) => meeting.id == meetingId);
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
