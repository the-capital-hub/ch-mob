import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  Future createEvent(
      title, description, duration, eventType, price, discount) async {
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
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
