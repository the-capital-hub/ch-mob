import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityPriorityDMsModel/community_priority_dms_model.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityPriorityDMsModel/your_questions_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../../../widget/bottomSheet/create_post_bottomsheet.dart';

class CommunityPriorityDMsController extends GetxController {
  String selectedTimeLine = "Hours";
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
  int? timeLine = 0;

  Future createCommunityPriorityDM(topics) async {
    // if (selectedTimeLine == "Hours") {
    //   timeLine = responseTimelineController.text.isEmpty
    //       ? null
    //       : int.tryParse(responseTimelineController.text)! * 60;
    // } else if (selectedTimeLine == "Days") {
    //   timeLine = responseTimelineController.text.isEmpty
    //       ? null
    //       : int.tryParse(responseTimelineController.text)! * 60 * 24;
    // }
    String description = "";
    await descriptionController.getText().then((val) => description = val);

    var body = {
      "title": titleController.text,
      "description": description,
      "amount": amountController.text.isEmpty
          ? null
          : int.tryParse(amountController.text),
      "timeline": responseTimelineController.text.isEmpty
          ? null
          : int.tryParse(responseTimelineController.text),
      "timeline_unit": selectedTimeLine.toLowerCase(),
      "topics": topics
    };
    log(body.toString());
    var response = await ApiBase.postRequest(
      body: body,
      withToken: true,
      extendedURL: ApiUrl.createCommunityPriorityDM + createdCommunityId,
    );

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityPriorityDMs();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  // String cleanHtmlDescription(String description) {
  //   description = description.replaceAll(RegExp(r'(<br>\s*)+'), '<br>');

  //   description = description.replaceAll(RegExp(r'<p>\s*<\/p>'), '');

  //   description =
  //       description.replaceAll(RegExp(r'<p>\s*<br>\s*<\/p>'), '<p><br></p>');

  //   description = description.trim();

  //   return description;
  // }

  Future updateCommunityPriorityDM(topics, priorityDMId) async {
    // if (selectedTimeLine == "Hours") {
    //   timeLine = responseTimelineController.text.isEmpty
    //       ? null
    //       : int.tryParse(responseTimelineController.text)! * 60;
    // } else if (selectedTimeLine == "Days") {
    //   timeLine = responseTimelineController.text.isEmpty
    //       ? null
    //       : int.tryParse(responseTimelineController.text)! * 60 * 24;
    // }
    String description = "";
    await descriptionController.getText().then((val) => description = val);
    // description = cleanHtmlDescription(description);
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
          "timeline_unit": selectedTimeLine.toLowerCase(),
          "topics": topics
        },
        withToken: true,
        extendedURL:
            "${ApiUrl.updateCommunityPriorityDM}$createdCommunityId/$priorityDMId");
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityPriorityDMs();
      return true;
    } else {
      Get.back();
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
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  TextEditingController questionController = TextEditingController();

  Future communityPriorityDMyAskQuestion(priorityDMId) async {
    var response = await ApiBase.postRequest(
      body: {
        "question": questionController.text,
      },
      withToken: true,
      extendedURL:
          "${ApiUrl.askQuestionCommunityPriorityDM}$createdCommunityId/$priorityDMId",
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

  TextEditingController answerController = TextEditingController();
  Future communityAnswerPriorityDM(priorityDMId, questionId) async {
    var response = await ApiBase.postRequest(
      body: {
        "answer": answerController.text,
      },
      withToken: true,
      extendedURL:
          "${ApiUrl.answerCommunityPriorityDM}$createdCommunityId/$priorityDMId/$questionId",
    );

    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityPriorityDMs();
      return true;
    } else {
      Get.back();
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  YourQuestions yourQuestionsData = YourQuestions(questions: []);
  Future<void> getCommunityPriorityDMYourQuestions(priorityDMId) async {
    try {
      isLoading.value = true;

      var response = await ApiBase.getRequest(
        extendedURL:
            "${ApiUrl.getCommunityPriorityDMYourQuestions}$createdCommunityId/$priorityDMId",
      );
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetYourQuestionsModel communityPriorityDMYourQuestionsModel =
            GetYourQuestionsModel.fromJson(data);
        yourQuestionsData = communityPriorityDMYourQuestionsModel.data!;
      }
    } catch (e) {
      log("getCommunityPriorityDMYourQuestions $e");
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  Future askAQuestion(priorityDMId) async {
    var bod = {
      "name": nameController.text,
      "email": emailController.text,
      "mobile": mobileController.text
    };
    log(bod.toString());
    var response = await ApiBase.postRequest(
      body: {
        "name": nameController.text,
        "email": emailController.text,
        "mobile": mobileController.text
      },
      withToken: true,
      extendedURL: ApiUrl.registerWebinar + priorityDMId,
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      // Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      getCommunityPriorityDMs();
      return true;
    } else {
      // Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
