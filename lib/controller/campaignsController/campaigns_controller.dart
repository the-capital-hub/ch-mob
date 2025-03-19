import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import '../../model/01-StartupModel/campaignModel/campaign_list_model.dart';
import '../../model/01-StartupModel/campaignModel/campaign_list_view_model.dart';
import '../../model/01-StartupModel/campaignModel/outreach_list_model.dart';
import '../../model/01-StartupModel/campaignModel/outreach_view_model.dart';
import '../../model/01-StartupModel/campaignModel/proceed_template_model.dart';
import '../../model/01-StartupModel/campaignModel/template_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class CampaignsController extends GetxController {
  late TabController tabController;
  var isLoading = false.obs;
  TextEditingController listNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String sharingType = "Private";
  List<String> listIds = [];

  Future createCampaignList({
    String? listId,
    required bool isEdit,
  }) async {
    try {
      var body = {
        if (listId != null) "list_id": listId,
        "list_name": listNameController.text,
        "isEdit": isEdit,
        "description": descriptionController.text,
        "visibility": sharingType,
      };
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.createCampaignUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);

      if (data["status"] == true) {
        await getCampaignLists();
        Get.back(closeOverlays: true);
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  List<AllCampaignList> campaignList = [];
  Future getCampaignLists() async {
    try {
      isLoading.value = true;
      campaignList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getAllCampaignDetailUrl);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        AllCampaignListModel allCampaignListModel =
            AllCampaignListModel.fromJson(data);
        campaignList.addAll(allCampaignListModel.data!);
      }
    } catch (e) {
      log("getCamp List $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteList({String? listId}) async {
    try {
      var response = await ApiBase.deleteRequest(
        extendedURL: ApiUrl.deleteList + listId!,
      );
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        Get.back(closeOverlays: true);
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("delete $e");
    } finally {}
  }

  ViewCampaignData viewCampaignData = ViewCampaignData();
  var isListViewLoading = false.obs;
  Future getCampaignView(id) async {
    try {
      isListViewLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getInvListById + id);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        CampaignListViewModel campaignListViewModel =
            CampaignListViewModel.fromJson(data);
        viewCampaignData = campaignListViewModel.data!;
      }
    } catch (e) {
      log("getCamp View $e");
    } finally {
      isListViewLoading.value = false;
    }
  }

  Future removeInvFromViewList(
      {required List<String> invIds,required bool isInv, required String listId}) async {
    try {
      var body = {isInv?"investorIds":"vcIds": invIds};
      var response = await ApiBase.postRequest(
          body: body,
          extendedURL: ApiUrl.removeInvFromList + listId,
          withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        await getCampaignLists();
        Get.back(closeOverlays: true);
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("delete $e");
    } finally {}
  }

  //TEMPATE SECTIONS

  TextEditingController templateNameController = TextEditingController();
  TextEditingController templateSubjectController = TextEditingController();
  String templateFolder = "Capitalhub";
  String templateVisibility = "Only you";
  String templateFreeOrPaid = "Free";
  final QuillEditorController templateBodyController = QuillEditorController();
  TextEditingController templateAmountController = TextEditingController();
  Future createTemplate() async {
    String emailBody = "";
    await templateBodyController.getText().then((val) => emailBody = val);
    try {
      var body = {
        "templateName": templateNameController.text,
        "emailSubject": templateSubjectController.text,
        "emailBody": emailBody,
        "folder": templateFolder,
        "visibility": templateVisibility,
        "pricingType": templateFreeOrPaid,
        "price":
            templateFreeOrPaid == "Free" ? "0" : templateAmountController.text
      };
      log(body.toString());

      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.createTemplate, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        await getTemplateView();
        Get.back(closeOverlays: true);
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  Future editTemplate(id) async {
    String emailBody = "";
    await templateBodyController.getText().then((val) => emailBody = val);
    try {
      var body = {
        "templateName": templateNameController.text,
        "emailSubject": templateSubjectController.text,
        "emailBody": emailBody,
        "folder": templateFolder,
        "visibility": templateVisibility,
        "pricingType": templateFreeOrPaid,
        "price":
            templateFreeOrPaid == "Free" ? "0" : templateAmountController.text
      };
      log(body.toString());

      var response = await ApiBase.pachRequest(
          body: body, extendedURL: ApiUrl.updateTemplate + id, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        await getTemplateView();
        Get.back(closeOverlays: true);
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  List<TemplateList> templateList = [];
  var isTemplateLoading = false.obs;
  Future getTemplateView() async {
    try {
      isTemplateLoading.value = true;
      templateList.clear();
      var response = await ApiBase.getRequest(extendedURL: ApiUrl.viewTemplate);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        TemplateViewModel templateViewModel = TemplateViewModel.fromJson(data);
        templateList.addAll(templateViewModel.data!);
      }
    } catch (e) {
      log("getTemplate View $e");
    } finally {
      isTemplateLoading.value = false;
    }
  }

  Future deleteTemplet({String? id}) async {
    try {
      var response = await ApiBase.deleteRequest(
        extendedURL: ApiUrl.deleteTemplate + id!,
      );
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        Get.back(closeOverlays: true);
        Get.back();
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("delete $e");
    } finally {}
  }

  List<OutreachData> outreachList = [];
  var isOutreachLoading = false.obs;
  Future getOutrechList({bool? isload}) async {
    try {
      isOutreachLoading.value = isload ?? true;
      outreachList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getOutreachCampaign);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        OutreachListModel outreachListModel = OutreachListModel.fromJson(data);
        outreachList.addAll(outreachListModel.data!);
      }
    } catch (e) {
      log("getOutreach View $e");
    } finally {
      isOutreachLoading.value = false;
    }
  }

  OutreachView outreachView = OutreachView();
  var isOutreachViewLoading = false.obs;
  Future getOutrechView(id, {bool? isload}) async {
    try {
      isOutreachViewLoading.value = isload ?? true;
      var response =
          await ApiBase.getRequest(extendedURL: "${ApiUrl.getViewCampaign}$id");
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        OutreachViewModel outreachViewModel = OutreachViewModel.fromJson(data);
        outreachView = outreachViewModel.data!;
      }
    } catch (e) {
      log("getOutreach View $e");
    } finally {
      isOutreachViewLoading.value = false;
    }
  }

  Future runOutreachCampaign(id, bool fromViewScreen) async {
    try {
      var body = {};
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.runCampaign + id, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        if (fromViewScreen) {
          await getOutrechView(id, isload: false);
        }
        await getOutrechList(isload: false);
        Get.back(closeOverlays: true);
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  TextEditingController scheduleDateController = TextEditingController(
      text: Helper.formatDatePost(DateTime.now().toString()));
  TextEditingController scheduleTimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  Future scheduleOutreachCampaign({
    required String id,
    required bool isCancel,
    required bool fromViewScreen,
  }) async {
    try {
      var body = isCancel
          ? {"scheduledAt": null}
          : {
              "scheduledAt":
                  "${scheduleDateController.text} ${scheduleTimeController.text}"
            };
      var response = await ApiBase.postRequest(
          body: body,
          extendedURL: ApiUrl.scheduleCampaign + id,
          withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        if (fromViewScreen) {
          await getOutrechView(id, isload: false);
        }
        await getOutrechList(isload: false);

        Get.back(closeOverlays: true);
        if (isCancel == false) {
          Get.back();
        }
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  Future duplicateOutreachCampaign(id) async {
    try {
      var body = {};
      var response = await ApiBase.postRequest(
          body: body,
          extendedURL: ApiUrl.duplicateCampaign + id,
          withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        await getOutrechList(isload: false);
        Get.back(closeOverlays: true);

        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  Future deleteOutreachCampaign({String? id}) async {
    try {
      var response = await ApiBase.deleteRequest(
        extendedURL: ApiUrl.deleteCampaign + id!,
      );
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        await getOutrechList(isload: false);
        Get.back(closeOverlays: true);
        Get.back();
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("delete $e");
    } finally {}
  }

  TextEditingController campaignNameController = TextEditingController();
  TextEditingController campaignSubjectController = TextEditingController();
  final QuillEditorController emailContentcontroller = QuillEditorController();
  List<String> ccEmails = [];
  List<String> bccEmails = [];
  ProceedTemplateData proceedTemplateData = ProceedTemplateData();
  Future proceedWithTemplate(String templateID) async {
    try {
      var body = {"list_ids": listIds, "template_id": templateID};
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.preCreatedDate, withToken: true);
      log(body.toString());
      var data = json.decode(response.body);
      Get.back(closeOverlays: true);
      if (data["status"] == true) {
        ProceedTemplateModel proceedTemplateModel =
            ProceedTemplateModel.fromJson(data);
        proceedTemplateData = proceedTemplateModel.data!;
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }

  String newCampaignID = "";
  Future createCampaign(String templateID) async {
    try {
      var body = {
        "investorLists": listIds,
        "template": templateID,
        "campaignName": campaignNameController.text,
        "cc": ccEmails,
        "bcc": bccEmails,
      };
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.createCampaign, withToken: true);
      log(body.toString());
      var data = json.decode(response.body);
      Get.back(closeOverlays: true);
      if (data["status"] == true) {
        newCampaignID = data['data'];
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {}
  }
}
