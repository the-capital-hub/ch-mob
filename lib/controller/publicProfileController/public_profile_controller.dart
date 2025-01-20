import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/01-StartupModel/publicProfileModel/public_profile_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class PublicProfileController extends GetxController {
  RxBool isLoading = false.obs;
  PublicData publicData = PublicData();
  Future getPublicProfile(id) async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getPublicProfileUrl + id);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        PublicProfileModel publicProfileModel =
            PublicProfileModel.fromJson(data);
        publicData = publicProfileModel.data;
      }
    } catch (e) {
      log("getPublicProfile $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future addEmailToFounder(context, id) async {
    Helper.loader(context);
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.addFounderEmailUrl + id,
        withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      UserEmail userEmail = UserEmail.fromJson(data['data']);
      publicData.userEmail = userEmail;
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
