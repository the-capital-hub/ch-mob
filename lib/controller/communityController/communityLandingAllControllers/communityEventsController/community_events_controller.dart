import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/communityLandingAllControllers/communityWebinarsController/community_webinars_controller.dart';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityWebinarsModel/community_webinar_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../model/communityModel/communityLandingAllModels/communityEventsModel/community_event_model.dart';
import '../../../../widget/bottomSheet/create_post_bottomsheet.dart';

class CommunityEventsController extends GetxController {
  var isLoading = false.obs;
  RxList<CommunityEvents> communityEventList = <CommunityEvents>[].obs;
  Future<void> getCommunityEvent() async {
    try {
      isLoading.value = true;
      communityEventList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityEvent + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityEventsModel communityWebinarsModel =
            GetCommunityEventsModel.fromJson(data);
        communityEventList.assignAll(communityWebinarsModel.data!);
      }
    } catch (e) {
      log("getCommunityevent $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  // String cleanHtmlDescription(String description) {
  //   description = description.replaceAll(RegExp(r'(<br>\s*)+'), '<br>');

  //   description = description.replaceAll(RegExp(r'<p>\s*<\/p>'), '');

  //   description =
  //       description.replaceAll(RegExp(r'<p>\s*<br>\s*<\/p>'), '<p><br></p>');

  //   description = description.trim();

  //   return description;
  // }

  Future createCommunityEvent() async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);

    var response = await ApiBase.postRequest(
      body: {
        "title": titleController.text,
        "description": description,
        "duration": int.tryParse(durationMinutesController.text),
        "price": int.tryParse(priceController.text),
        "discount": int.tryParse(priceDiscountController.text),
        "communityId": createdCommunityId,
        "eventType": "Private"
// googleLogin
      },
      withToken: true,
      extendedURL: ApiUrl.createEvent,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      // HelperSnackBar.snackBar("Success", data["message"]);
      await getCommunityEvent();
      showPostUpdateBottomSheet(
          postDescription: data['postText'], sheetDescription: "Event");
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateCommunityEvent(id) async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    // description = cleanHtmlDescription(description);
    var response = await ApiBase.pachRequest(
      body: {
        "title": titleController.text,
        "description": description,
        "duration": int.tryParse(durationMinutesController.text),
        "price": int.tryParse(priceController.text),
        "discount": int.tryParse(priceDiscountController.text),
        "communityId": createdCommunityId,
        "eventType": "Private"
      },
      withToken: true,
      extendedURL: ApiUrl.updateEvent + id,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityEvent();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future disableCommunityEvent(id) async {
    try {
      isLoading.value = true;
      var body = {"eventId": id};
      var response = await ApiBase.pachRequest(
          extendedURL: ApiUrl.disableEvent + id, body: body, withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data["status"]) {
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        getCommunityEvent();
        return true;
      } else {
        Get.back();
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("disableEvent $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  String formattedDate = "";
  String selectedDayName = "";
  int selectedDayIndex = 0;
  bool isDaySelected = false;
  String slot = "";
  String startTime = "";
  String endTime = "";

  Future communityScheduleEvent(webinarId, day, startTime, endTime) async {
    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "additionalInfo": infoController.text,
      "date": formattedDate,
      "startTime":
          DateFormat("HH:mm").format(DateFormat("hh:mm a").parse(startTime)),
      "endTime":
          DateFormat("HH:mm").format(DateFormat("hh:mm a").parse(endTime)),
    };
    var response = await ApiBase.postRequest(
      body: body,
      withToken: true,
      extendedURL: ApiUrl.scheduleEvent + webinarId,
    );
    print(startTime);
    print(endTime);
    print(body);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityEvent();
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
