import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/mystartupModel/my_startup_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class MyStartupsController extends GetxController {
  var isLoading = false.obs;
  String base64 = "";
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

  Future<bool> addMyInvestment({
    required String userId,
    required String connectionStatus,
  }) async {
    var body = {
      "image": base64,
      "name": companyNameController.text,
      "description": companyDescriptionController.text,
      "equity": equityController.text
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.addMyInvestment, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> addPastInvestment({
    required String userId,
    required String connectionStatus,
  }) async {
    var body = {
      "image": base64,
      "name": companyNameController.text,
      "description": companyDescriptionController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.addPastInvestment, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
