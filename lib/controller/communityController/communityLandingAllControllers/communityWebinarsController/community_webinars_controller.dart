import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityEventsController/community_events_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinars_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

CommunityEventsController communityEvents =
    Get.put(CommunityEventsController());

class CommunityWebinarsController extends GetxController {
  String formattedDate = "";
  String selectedDayName = "";
  int selectedDayIndex = 0;
  bool isDaySelected = false;
  String slot = "";
  String startTime = "";
  String endTime = "";
  var isLoading = false.obs;
  
  RxList<CommunityWebinars> communityWebinarsList = <CommunityWebinars>[].obs;

  Future<void> getCommunityWebinars() async {
    try {
      isLoading.value = true;
      communityWebinarsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityWebinars + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityWebinarsModel communityWebinarsModel =
            GetCommunityWebinarsModel.fromJson(data);
        communityWebinarsList.assignAll(communityWebinarsModel.data!);
      }
    } catch (e) {
      log("getCommunityWebinars $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();

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

  String cleanHtmlDescription(String description) {
    description = description.replaceAll(RegExp(r'(<br>\s*)+'), '<br>');

    description = description.replaceAll(RegExp(r'<p>\s*<\/p>'), '');

    description =
        description.replaceAll(RegExp(r'<p>\s*<br>\s*<\/p>'), '<p><br></p>');

    description = description.trim();

    return description;
  }

  Future createCommunityWebinar(base64) async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    DateTime? date = DateTime.tryParse(dateController.text);
    String? dateIso = "${date?.toIso8601String() ?? ""}Z";
    String startTime = convertToIsoFormat(startTimeController.text, date);
    String endTime = convertToIsoFormat(endTimeController.text, date);

    var response = await ApiBase.postRequest(
      body: {
        "date": dateIso,
        "title": titleController.text,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "duration": int.tryParse(durationMinutesController.text),
        "discount": int.tryParse(priceDiscountController.text),
        "price": int.tryParse(priceController.text),
        "community": createdCommunityId,
        "image": base64,
        "webinarType": "Private",
      },
      withToken: true,
      extendedURL: ApiUrl.createWebinar,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      communityEvents.getCommunityEvents();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateCommunityWebinar(base64, webinarId) async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    description = cleanHtmlDescription(description);
    DateTime? date = DateTime.tryParse(dateController.text);
    String? dateIso = "${date?.toIso8601String() ?? ""}Z";
    String startTime = convertToIsoFormat(startTimeController.text, date);
    String endTime = convertToIsoFormat(endTimeController.text, date);
    var bod = {
      "date": dateIso,
      "title": titleController.text,
      "description": description,
      "startTime": startTime,
      "endTime": endTime,
      "duration": int.tryParse(durationMinutesController.text),
      "discount": int.tryParse(priceDiscountController.text),
      "price": int.tryParse(priceController.text),
      "community": createdCommunityId,
      "image": base64,
      "webinarType": "Private",
    };
    log(bod.toString());
    var response = await ApiBase.pachRequest(
      body: {
        "date": dateIso,
        "title": titleController.text,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "duration": int.tryParse(durationMinutesController.text),
        "discount": int.tryParse(priceDiscountController.text),
        "price": int.tryParse(priceController.text),
        "community": createdCommunityId,
        "image": base64,
        "webinarType": "Private",
      },
      withToken: true,
      extendedURL: ApiUrl.updateWebinar + webinarId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      communityEvents.getCommunityEvents();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future deleteCommunityWebinar(webinarId) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteCommunityWebinar + webinarId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      communityWebinarsList.removeWhere((webinar) => webinar.id == webinarId);
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      communityEvents.getCommunityEvents();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);

      return false;
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController infoController = TextEditingController();

  Future communityScheduleEvent(webinarId, day, startTime, endTime) async {
    var response = await ApiBase.postRequest(
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "additionalInfo": infoController.text,
        "date": formattedDate,
        "startTime": startTime.replaceAll(RegExp(r"\sAM|\sPM"), ""),
        "endTime": endTime.replaceAll(RegExp(r"\sAM|\sPM"), ""),
      },
      withToken: true,
      extendedURL: ApiUrl.scheduleEvent + webinarId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      communityWebinars.getCommunityWebinars();
      return true;
    } else {
      Get.back();
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
