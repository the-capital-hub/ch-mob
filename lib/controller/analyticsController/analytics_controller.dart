import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/analyticsModel/analytics_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';

class AnalyticsController extends GetxController {
  var isLoading = false.obs;
  
  AnalyticsData analyticsData =AnalyticsData();
  Future getAnnalytics(time) async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getAnnalytics+time);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        AnalyticsModel analyticsModel =
            AnalyticsModel.fromJson(data);
        analyticsData =analyticsModel.data!;
      }
    } catch (e) {
      log("getCamp List $e");
    } finally {
      isLoading.value = false;
    }
  }

}