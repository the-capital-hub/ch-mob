import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/mystartupModel/my_startup_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class MyStartupsController extends GetxController {
  var isLoading = false.obs;
  String? base64;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyDescriptionController = TextEditingController();
  TextEditingController equityController = TextEditingController();

  StartupData startupData = StartupData();
  Future getStartupsList() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getInvStartupInfo);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        MyStartupModel myStartupModel = MyStartupModel.fromJson(data);
        startupData = myStartupModel.data!;
      }
    } catch (e) {
      log("getstartups list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addEditMyInvestment({
    String? userId,
    required bool isEdit,
  }) async {
    var body = {
      if (base64 != null) "logo": base64,
      "name": companyNameController.text,
      "description": companyDescriptionController.text,
      "investedEquity": equityController.text
    };
    var response = isEdit
        ? await ApiBase.pachRequest(
            body: body,
            extendedURL: "${ApiUrl.addMyInvestment}/$userId",
            withToken: true)
        : await ApiBase.postRequest(
            body: body, extendedURL: ApiUrl.addMyInvestment, withToken: true);
    log(response.body);
    Get.back(closeOverlays: true);
    Get.back();
    var data = json.decode(response.body);
    if (data["status"] == true) {
      getStartupsList();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> delMyInvestment(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.addMyInvestment}/$id",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back(closeOverlays: true);
      Get.back();
      getStartupsList();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> delMyIntrest(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.delMyInterest}/$id",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      getStartupsList();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> addPastInvestment({
    String? userId,
    required bool isEdit,
  }) async {
    var body = {
      if (base64 != null) "logo": base64,
      "name": companyNameController.text,
      "description": companyDescriptionController.text,
    };
    var response = isEdit
        ? await ApiBase.pachRequest(
            body: body,
            extendedURL: "${ApiUrl.addPastInvestment}/$userId",
            withToken: true)
        : await ApiBase.postRequest(
            body: body, extendedURL: ApiUrl.addPastInvestment, withToken: true);
    log(response.body);
    Get.back(closeOverlays: true);
    Get.back();
    var data = json.decode(response.body);
    if (data["status"] == true) {
      getStartupsList();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
  
  Future<bool> delPastInvestment(id) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.addPastInvestment}/$id",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back(closeOverlays: true);
      Get.back();
      getStartupsList();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

}
