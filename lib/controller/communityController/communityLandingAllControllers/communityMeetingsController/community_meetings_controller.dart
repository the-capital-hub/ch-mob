import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/communityMeetingsModel.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController memberEmailController = TextEditingController();
  String memberEmail = "Select From Community";

  String convertToIsoFormat(String timeString, DateTime? date) {
    DateFormat inputFormat = DateFormat('hh:mm a');
    DateTime time = inputFormat.parse(timeString);
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    DateTime finalDateTime = DateTime(
      date!.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return outputFormat.format(finalDateTime);
  }

  Future createCommunityMeeting(topics) async {
    DateTime? date = DateTime.tryParse(dateController.text);
    String? dateIso = "${date?.toIso8601String() ?? ""}Z";
    // String startTime = convertToIsoFormat(startTimeController.text, date);
    // String endTime = convertToIsoFormat(endTimeController.text, date);
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    if (memberEmailController.text.isEmpty &&
        memberEmail != "Add a new member") {
      memberEmailController.text = memberEmail;
    }
    var bod = {
      "title": titleController.text,
      "description": description,
      "amount": amountController.text.isEmpty
          ? null
          : int.tryParse(amountController.text),
      "duration": durationController.text.isEmpty
          ? null
          : int.tryParse(durationController.text),
      "topics": topics,
      "availability": [
        {
          "day": dateIso,
          "slots": [
            {
              "startTime": startTimeController.text,
              "endTime": endTimeController.text,
              // "isBooked": true,
              // "meeting_link": "https://example.com/meeting1",
              "memberEmail": memberEmailController.text
            },
          ]
        }
      ]
    };
    log(bod.toString());
    var response = await ApiBase.postRequest(
      body: {
        "title": titleController.text,
        "description": description,
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
      getCommunityMeetings();
      memberEmailController.clear();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      memberEmailController.clear();
      return false;
    }
  }

  Future updateCommunityMeeting(topics, meetingId) async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    var response = await ApiBase.pachRequest(
      body: {
        "title": titleController.text,
        "description": description,
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
      getCommunityMeetings();
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
