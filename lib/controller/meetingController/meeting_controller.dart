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
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MeetingController extends GetxController {
  var isLoading = false.obs;
  Future updateAvailability(context, dayAvailability, minimumGap) async {
    Helper.loader(context);
    var response = await ApiBase.postRequest(
      body: {"dayAvailability": dayAvailability, "minimumGap": minimumGap,},
      withToken: true,
      extendedURL: ApiUrl.updateAvailability,
    );
print(GetStoreData.getStore.read('access_token'));
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
      {
      context,
      required String title,
      required String description,
      required String duration,
      required String eventType,
      required String price,
      required String discount}) async {
        Helper.loader(context);
    
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
    var data = json.decode(response.body);
    if (data["status"]) {
      // getEvents(context);
      
     Get.back();
     HelperSnackBar.snackBar("Success", data["message"]);
    
      return true;
      
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
 RxList<Event> eventsList = <Event>[].obs;
  Future<void> getEvents() async {
  try {
    isLoading.value = true; // Set loading state to true
    eventsList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getEvents);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetEventsModel eventsModel = GetEventsModel.fromJson(data);

      // Update the observable list with new data
      eventsList.assignAll(eventsModel.data); // Adding events to the list
    } 
  } catch (e) {
    log("getEvents $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
  
  Future disableEvent(id) async {
    try {
      isLoading.value = true;
      var body = {"eventId": id};

      var response = await ApiBase.pachRequest(
          extendedURL: ApiUrl.disableEvent+id, body: body, withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data["status"]) {
        HelperSnackBar.snackBar("Success", data["message"]);
      
      return true;
      }
       else {
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
    
    print(GetStoreData.getStore.read('access_token'));
  try {
    isLoading.value = true; // Set loading state to true
    meetingsList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getALLScheduledMeetings+status);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetMeetingsModel meetingsModel = GetMeetingsModel.fromJson(data);

      // Update the observable list with new data
      meetingsList.assignAll(meetingsModel.data); // Adding events to the list
    } 
  } catch (e) {
    log("getALLScheduledMeetings $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
Future cancelScheduledMeeting(id) async {
  
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.cancelScheduledMeeting + id,
    );
    log(response.body);
    var data = json.decode(response.body);
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
    isLoading.value = true; // Set loading state to true
    webinarsList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getWebinars);
    log(response.body);
    print(GetStoreData.getStore.read('access_token'));
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetWebinarsModel webinarsModel = GetWebinarsModel.fromJson(data);

      // Update the observable list with new data
      webinarsList.assignAll(webinarsModel.data); // Adding events to the list
    } 
  } catch (e) {
    log("getALLScheduledMeetings $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
Future deleteWebinar(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.deleteWebinar + id,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      // messages.removeWhere((item) => item.messageId == id);
      webinarsList.removeWhere((webinar) => webinar.id == id);
      HelperSnackBar.snackBar("Success", data["message"]);
      
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController durationMinutesController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  String type = "";
  
  Future createWebinar()
       async {
        DateTime? startTime = DateTime.tryParse(startTimeController.text);
DateTime? endTime = DateTime.tryParse(endTimeController.text);
DateTime? date = DateTime.tryParse(dateController.text);

// If startTime, endTime, and date are not null, convert to UTC and then format them as ISO 8601 strings
String? startTimeIso = startTime?.toUtc().toIso8601String();
String? endTimeIso = endTime?.toUtc().toIso8601String();
String? dateIso = date?.toUtc().toIso8601String();
    
    var response = await ApiBase.postRequest(
      body: {
        
        "date": dateIso,
        "title": titleController.text,
        "description": descriptionController.text,
        "webinarType": type,
        "startTime": startTimeIso,
        "endTime": endTimeIso,
        "duration": int.tryParse(durationMinutesController.text),
        "discount": int.tryParse(priceDiscountController.text),
        "price": int.tryParse(priceController.text),
        
      },
      withToken: true,
      extendedURL: ApiUrl.createWebinar,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      // getEvents(context);
      
     Get.back();
     HelperSnackBar.snackBar("Success", data["message"]);
    
      return true;
      
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
  RxList<User> userList = <User>[].obs;
  Future<void> getPriorityDMForUser() async {
  try {
    isLoading.value = true; // Set loading state to true
    userList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getPriorityDMForUser);
    log(response.body);
    
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetPriorityDmUserModel userModel = GetPriorityDmUserModel.fromJson(data);

      // Update the observable list with new data
      userList.assignAll([userModel.data]); // Adding events to the list
    } 
  } catch (e) {
    log("getPriorityDMForUser $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
  RxList<Founder> founderList = <Founder>[].obs;
  Future<void> getPriorityDMForFounder() async {
  try {
    isLoading.value = true; // Set loading state to true
    founderList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getPriorityDMForFounder);
    log(response.body);
    
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetPriorityDmFounderModel founderModel = GetPriorityDmFounderModel.fromJson(data);

      // Update the observable list with new data
      founderList.assignAll([founderModel.data]); // Adding events to the list
    } 
  } catch (e) {
    log("getPriorityDMForUser $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
RxList<Availability> availabilityList = <Availability>[].obs;
  Future<void> getAvailability() async {
  try {
    isLoading.value = true; // Set loading state to true
    availabilityList.clear();
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getAvailability);
    log(response.body);
    print(GetStoreData.getStore.read('access_token'));
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetAvailabilityModel availabilityModel = GetAvailabilityModel.fromJson(data);

      // Update the observable list with new data
      availabilityList.assignAll([availabilityModel.data]); // Adding events to the list
    } 
  } catch (e) {
    log("getALLScheduledMeetings $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
}
