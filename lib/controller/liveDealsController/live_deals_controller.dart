import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/liveDealsModel/live_deals_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class LiveDealsController extends GetxController {
  var isLoading = true.obs;
  List<LiveDealData> liveDealsList = [];
  Future getLiveDeals() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(extendedURL: ApiUrl.livedealsUrl);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        liveDealsList.clear();
        LiveDealsModel liveDealsModel = LiveDealsModel.fromJson(data);
        liveDealsList.addAll(liveDealsModel.data!);
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  var isButtonLoading = false.obs;
  Future intrestedUnintrestedDeal({required String id}) async {
    try {
      isButtonLoading.value = true;
      var body = {
        "liveDealId": id,
      };
      var response = await ApiBase.pachRequest(
          body: body, extendedURL: ApiUrl.toggelDealsUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {
      isButtonLoading.value = false;
    }
  }
Future onelinkSent({required String id}) async {
    try {
      isButtonLoading.value = true;
      var body = {
        "startUpId": id,
      };
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.onelinkSentUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        HelperSnackBar.snackBar("Success", data["message"]);
        return true;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return false;
      }
    } catch (e) {
      log("message $e");
    } finally {
      isButtonLoading.value = false;
    }
  }
}
