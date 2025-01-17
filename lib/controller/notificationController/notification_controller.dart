import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/notificationModel/notification_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class NotificaitonController extends GetxController {
  RxBool isLoading = false.obs;

  List<NotificationData> notificationList = [];

  Future getNotificationList() async {
    try {
      notificationList.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getNotification+GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        NotificationModel notificationModel = NotificationModel.fromJson(data);
        notificationList.addAll(notificationModel.data!);
      }
    } catch (e) {
      log("getnotification list $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future markAsRead(context, index) async {
    Helper.loader(context);
    var body = {};
    var response = await ApiBase.pachRequest(
        body: body,
        extendedURL: ApiUrl.readNotification + notificationList[index].id!,
        withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      notificationList[index].isRead = true;
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future markAllAsRead(context) async {
    var body = {};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.allReadNotification, withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data["status"]) {
      getNotificationList();
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  var notificationCount = "".obs;
  Future getNotificationCount() async {
    try {
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getNotificationCount);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        notificationCount.value = data['data']['unreadCount'].toString();
      }
    } catch (e) {
      log("getnotificationCount $e");
    } finally {
    }
  }
}
