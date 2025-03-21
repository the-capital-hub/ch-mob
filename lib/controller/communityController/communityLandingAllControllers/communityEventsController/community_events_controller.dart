import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityEventsModel/community_events_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CommunityEventsController extends GetxController {
  var isLoading = false.obs;
  CommunityEvent communityEventsData = CommunityEvent();
  Future<void> getCommunityEvents() async {
    try {
      isLoading.value = true;

      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getWebinarsByCommunityId + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityEventsModel communityEventsModel =
            GetCommunityEventsModel.fromJson(data);
        communityEventsData = communityEventsModel.data;
      }
    } catch (e) {
      log("getCommunityEvents $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();

  Future createCommunityEvent() async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    var response = await ApiBase.postRequest(
      body: {
        "title": titleController.text,
        "description": description,
        "duration": durationMinutesController.text,
        "price": priceController.text,
        "discount": priceDiscountController.text,
        "communityId": createdCommunityId
      },
      withToken: true,
      extendedURL: ApiUrl.createEvent,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityEvents();
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future updateCommunityEvent(id) async {
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    var response = await ApiBase.pachRequest(
      body: {
        "title": titleController.text,
        "description": description,
        "duration": durationMinutesController.text,
        "price": priceController.text,
        "discount": priceDiscountController.text,
        "communityId": createdCommunityId
      },
      withToken: true,
      extendedURL: ApiUrl.updateEvent + id,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityEvents();
      return true;
    } else {
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
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("disableEvent $e");
    } finally {
      isLoading.value = false;
    }
  }
}
