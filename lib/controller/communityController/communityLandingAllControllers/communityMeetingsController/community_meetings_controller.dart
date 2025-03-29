import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/communityMeetingsModel.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/community_member_emails_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunityMeetingsController extends GetxController {
  var isLoading = false.obs;
  int availabilityIndex = 0;
  String day = "";
  bool isDaySelected = false;
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
  String memberEmail = "";
  bool isNewEmail = false;

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
    String startTime =
        startTimeController.text.replaceAll(RegExp(r"\sAM|\sPM"), "");
    String endTime =
        endTimeController.text.replaceAll(RegExp(r"\sAM|\sPM"), "");
    String description = "";
    await descriptionController.getText().then((val) => description = val);

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
              "startTime": startTime,
              "endTime": endTime,
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
        "topics": topics,
        "availability": [
          {
            "day": dateIso,
            "slots": [
              {
                "startTime": startTime,
                "endTime": endTime,
                "memberEmail":
                    isNewEmail ? memberEmailController.text : memberEmail
              },
            ]
          }
        ]
      },
      withToken: true,
      extendedURL: ApiUrl.createCommunityMeeting + createdCommunityId,
    );

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityMeetings();
      memberEmailController.clear();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      memberEmailController.clear();
      return false;
    }
  }

  Future updateCommunityMeeting(topics, meetingId) async {
    DateTime? date = DateTime.tryParse(dateController.text);
    String? dateIso = "${date?.toIso8601String() ?? ""}Z";
    String startTime =
        startTimeController.text.replaceAll(RegExp(r"\sAM|\sPM"), "");
    String endTime =
        endTimeController.text.replaceAll(RegExp(r"\sAM|\sPM"), "");
    String description = "";
    await descriptionController.getText().then((val) => description = val);
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
              "startTime": startTime,
              "endTime": endTime,
              "memberEmail":
                  isNewEmail ? memberEmailController.text : memberEmail
            },
          ]
        }
      ]
    };
    log(bod.toString());
    var response = await ApiBase.pachRequest(
      body: {
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
                "startTime": startTime,
                "endTime": endTime,
                "memberEmail":
                    isNewEmail ? memberEmailController.text : memberEmail
              },
            ]
          }
        ]
      },
      withToken: true,
      extendedURL:
          "${ApiUrl.updateCommunityMeeting}$createdCommunityId/$meetingId",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityMeetings();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future deleteCommunityMeeting(meetingId) async {
    var response = await ApiBase.deleteRequest(
      extendedURL:
          "${ApiUrl.deleteCommunityMeeting}$createdCommunityId/$meetingId",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      communityMeetingsList.removeWhere((meeting) => meeting.id == meetingId);
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  Future bookCommunityMeeting(meetingId, day, startTime, endTime) async {
    var response = await ApiBase.postRequest(
      body: {
        "slot": {
          "day": day,
          "startTime": startTime,
          "endTime": endTime,
        },
      },
      withToken: true,
      extendedURL:
          "${ApiUrl.bookCommunityMeeting}$createdCommunityId/$meetingId",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityMeetings();
      return true;
    } else {
      Get.back();
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  List<String> communityMemberEmails = ["Add a new member"];

  Future<void> getMemberEmails() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getMemberEmails + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetMemberEmailModel communityMemberEmailModel =
            GetMemberEmailModel.fromJson(data);

        communityMemberEmails = ["Add a new member"] +
            communityMemberEmailModel.data
                .map((member) => member.memberEmail)
                .toList();
      }
    } catch (e) {
      log("getMemberEmails $e");
    } finally {
      isLoading.value = false;
    }
  }
}
