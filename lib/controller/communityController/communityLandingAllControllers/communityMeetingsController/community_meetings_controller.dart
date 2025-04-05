import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/controller/loginController/login_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/communityMeetingsModel.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityMeetingsModel/community_member_emails_model.dart';
import 'package:capitalhub_crm/screen/Auth-Process/authScreen/login_page.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/apiService/google_service.dart';
import 'package:capitalhub_crm/utils/appcolors/app_colors.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:capitalhub_crm/widget/buttons/button.dart';
import 'package:capitalhub_crm/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:capitalhub_crm/widget/dilogue/communityDialog/login_dialog.dart';

LoginController loginMobileController = Get.put(LoginController());
CommunityController communityLogin = Get.put(CommunityController());

class CommunityMeetingsController extends GetxController {
  var isLoading = false.obs;
  int availabilityIndex = 0;
  String day = "";
  bool isDaySelected = false;
  RxList<CommunityMeetings> communityMeetingsList = <CommunityMeetings>[].obs;
   DateTime dateSelected  = DateTime.now();

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

  // String cleanHtmlDescription(String description) {
  //   description = description.replaceAll(RegExp(r'(<br>\s*)+'), '<br>');

  //   description = description.replaceAll(RegExp(r'<p>\s*<\/p>'), '');

  //   description =
  //       description.replaceAll(RegExp(r'<p>\s*<br>\s*<\/p>'), '<p><br></p>');

  //   description = description.trim();

  //   return description;
  // }

  String convertTo24HourFormat(String time) {
    try {
      // Define the 12-hour format pattern
      final DateFormat inputFormat = DateFormat("hh:mm a");

      // Parse the input time
      DateTime parsedTime = inputFormat.parse(time);

      // Define the 24-hour format pattern
      final DateFormat outputFormat = DateFormat("HH:mm");

      // Return the time in 24-hour format
      return outputFormat.format(parsedTime);
    } catch (e) {
      // If there is an error in parsing, return the original string or handle accordingly
      return time;
    }
  }

  Future createCommunityMeeting(context, topics) async {
    DateTime? date = DateTime.tryParse(dateController.text);
    String? dateIso = "${date?.toIso8601String() ?? ""}Z";
    String startTime = convertTo24HourFormat(startTimeController.text);
    String endTime = convertTo24HourFormat(endTimeController.text);
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    // Prepare the availability slots
    var availabilitySlot = {
      "startTime": startTime,
      "endTime": endTime,
    };

    // Conditionally add memberEmail if it is not empty
    if (memberEmailController.text.isNotEmpty || memberEmail.isNotEmpty) {
      availabilitySlot["memberEmail"] =
          isNewEmail ? memberEmailController.text : memberEmail;
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
          "slots": [availabilitySlot],
        }
      ]
    };
    log(bod.toString());
    log("Bearer ${GetStoreData.getStore.read('access_token')}");
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
            "slots": [availabilitySlot],
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
    } else if (data["message"] == "googleLogin") {
      Get.back();
      showLoginAlertDialog(context);
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
    String startTime = convertTo24HourFormat(startTimeController.text);
    String endTime = convertTo24HourFormat(endTimeController.text);
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    // description = cleanHtmlDescription(description);
    // Prepare the availability slots
    var availabilitySlot = {
      "startTime": startTime,
      "endTime": endTime,
    };

    // Conditionally add memberEmail if it is not empty
    if (memberEmailController.text.isNotEmpty || memberEmail.isNotEmpty) {
      availabilitySlot["memberEmail"] =
          isNewEmail ? memberEmailController.text : memberEmail;
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
          "slots": [availabilitySlot],
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
            "slots": [availabilitySlot],
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
