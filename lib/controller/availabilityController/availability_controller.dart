import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';

import 'package:get/get.dart';

class AvailabilityController extends GetxController {
  Future updateAvailability(dayAvailability, minGap) async {
    var response = await ApiBase.postRequest(
      body: {"dayAvailability": dayAvailability, "minGap": minGap},
      withToken: true,
      extendedURL: ApiUrl.updateAvailability,
    );
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
}
