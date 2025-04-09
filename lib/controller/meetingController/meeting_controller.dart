import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_availability_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_events_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_meetings_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_priority_dm_founder_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_priority_dm_user_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/meetingModel/get_webinars_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class MeetingController extends GetxController {
  List<Map<String, dynamic>> availabilityData = [];
  var isLoading = false.obs;
  DateTime dateSelected = DateTime.now();

  Future updateAvailability(context, dayAvailability, minimumGap) async {
    Helper.loader(context);
    var response = await ApiBase.postRequest(
      body: {
        "dayAvailability": dayAvailability,
        "minimumGap": minimumGap,
      },
      withToken: true,
      extendedURL: ApiUrl.updateAvailability,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back(closeOverlays: true);
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future createEvent(
      {required String title,
      required String description,
      required String duration,
      required String eventType,
      required String price,
      required String discount}) async {
    var response = await ApiBase.postRequest(
      body: {
        "title": title,
        "description": description,
        "duration": duration,
        "eventType": eventType,
        "price": price,
        "discount": discount,
        "communityId": "communityId"
      },
      withToken: true,
      extendedURL: ApiUrl.createEvent,
    );
    log(response.body);
    Get.back();
    Get.back();
    var data = json.decode(response.body);
    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<Datum> eventsList = <Datum>[].obs;
  Future<void> getEvents() async {
    try {
      isLoading.value = true;
      eventsList.clear();
      var response = await ApiBase.getRequest(extendedURL: ApiUrl.getEvents);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetEventsModel eventsModel = GetEventsModel.fromJson(data);
        eventsList.assignAll(eventsModel.data);
      }
    } catch (e) {
      log("getEvents $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future disableEvent(id) async {
    try {
      isLoading.value = true;
      var body = {"eventId": id};
      var response = await ApiBase.pachRequest(
          extendedURL: ApiUrl.disableEvent + id, body: body, withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      Get.back();
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

  RxList<Meeting> meetingsList = <Meeting>[].obs;
  Future<void> getALLScheduledMeetings(status) async {
    try {
      isLoading.value = true;
      meetingsList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getALLScheduledMeetings + status);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetMeetingsModel meetingsModel = GetMeetingsModel.fromJson(data);
        meetingsList.assignAll(meetingsModel.data); // Adding events to the list
      }
    } catch (e) {
      log("getALLScheduledMeetings $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future cancelScheduledMeeting(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.cancelScheduledMeeting + id,
    );
    log(response.body);
    var data = json.decode(response.body);

    Get.back();
    if (data["status"]) {
      meetingsList.removeWhere((meeting) => meeting.id == id);
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<Webinar> webinarsList = <Webinar>[].obs;
  Future<void> getWebinars() async {
    try {
      isLoading.value = true;
      webinarsList.clear();
      var response = await ApiBase.getRequest(extendedURL: ApiUrl.getWebinars);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetWebinarsModel webinarsModel = GetWebinarsModel.fromJson(data);
        webinarsList.assignAll(webinarsModel.data);
      }
    } catch (e) {
      log("getWebinars $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future disableWebinar(id) async {
    var body = {"webinarId": id};
    var response = await ApiBase.pachRequest(
        extendedURL: ApiUrl.disableWebinar + id, body: body, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  TextEditingController titleController = TextEditingController();
  QuillEditorController descriptionController = QuillEditorController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  String type = "";
  String communityWebinarId = "";

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

  Future createWebinar() async {
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
        "webinarType": type,
        "startTime": startTime,
        "endTime": endTime,
        "duration": int.tryParse(durationMinutesController.text),
        "discount": int.tryParse(priceDiscountController.text),
        "price": int.tryParse(priceController.text),
        "communityId": communityWebinarId
      },
      withToken: true,
      extendedURL: ApiUrl.createWebinar,
    );
    log(response.body);
    Get.back();
    Get.back();
    var data = json.decode(response.body);
    if (data["status"]) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<User> userList = <User>[].obs;
  Future<void> getPriorityDMForUser() async {
    try {
      isLoading.value = true;
      userList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getPriorityDMForUser);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetPriorityDmUserModel userModel =
            GetPriorityDmUserModel.fromJson(data);
        userList.assignAll(userModel.data);
      }
    } catch (e) {
      log("getPriorityDMForUser $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<Founder> founderList = <Founder>[].obs;
  Future<void> getPriorityDMForFounder() async {
    try {
      isLoading.value = true;
      founderList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getPriorityDMForFounder);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetPriorityDmFounderModel founderModel =
            GetPriorityDmFounderModel.fromJson(data);
        founderList.assignAll(founderModel.data);
      }
    } catch (e) {
      log("getPriorityDMForFounder $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController answerController = TextEditingController();
  Future answerPriorityDM(priorityDMId) async {
    var response = await ApiBase.pachRequest(
      body: {
        "answer": answerController.text,
      },
      withToken: true,
      extendedURL:
          "${ApiUrl.answerPriorityDM}$priorityDMId",
    );

    log(response.body);
    var data = json.decode(response.body);
    Get.back();
    Get.back();
    if (data["status"]) {
      answerController.clear();
      HelperSnackBar.snackBar("Success", data["message"]);
      getPriorityDMForUser();
      getPriorityDMForFounder();
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<Availability> availabilityList = <Availability>[].obs;
  Future<void> getAvailability() async {
    try {
      isLoading.value = true;
      availabilityList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getAvailability);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetAvailabilityModel availabilityModel =
            GetAvailabilityModel.fromJson(data);
        availabilityList.assignAll([availabilityModel.data]);
      }
    } catch (e) {
      log("getAvailability $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool get isAvailabilityAvailable {
    return availabilityList.isNotEmpty;
  }
}
