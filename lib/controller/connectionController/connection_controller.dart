import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/connectionModel/connection_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class ConnectionController extends GetxController {
  var isLoading = false.obs;
  List<ConnectionData> connectionData = [];

  Future getReceivedData() async {
    try {
      connectionData.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getReceivedConnection);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ConnectionModel connectionModel = ConnectionModel.fromJson(data);
        connectionData.addAll(connectionModel.data!);
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future getSentData() async {
    try {
      connectionData.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getSentConnection);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ConnectionModel connectionModel = ConnectionModel.fromJson(data);
        connectionData.addAll(connectionModel.data!);
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future getAcceptedData() async {
    try {
      connectionData.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getAcceptedConnection+GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ConnectionModel connectionModel = ConnectionModel.fromJson(data);
        connectionData.addAll(connectionModel.data!);
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future acceptRequest(id) async {
    isLoading.value = true;
    connectionData.clear();
    var body = {};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: "${ApiUrl.acceptReq}$id", withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ConnectionModel connectionModel = ConnectionModel.fromJson(data);
      connectionData.addAll(connectionModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future rejectRequest(id) async {
    isLoading.value = true;
    connectionData.clear();
    var body = {};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: "${ApiUrl.rejectReq}$id", withToken: true);
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ConnectionModel connectionModel = ConnectionModel.fromJson(data);
      connectionData.addAll(connectionModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future removeRequest(id) async {
    isLoading.value = true;
    connectionData.clear();
    var body = {};
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.removeConnectionReq}$id",
    );
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ConnectionModel connectionModel = ConnectionModel.fromJson(data);
      connectionData.addAll(connectionModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future cancelRequest(id) async {
    isLoading.value = true;
    connectionData.clear();
    var body = {};
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.cancelConnectionReq}$id",
    );
    log(response.body);

    var data = json.decode(response.body);
    if (data['status'] == true) {
      ConnectionModel connectionModel = ConnectionModel.fromJson(data);
      connectionData.addAll(connectionModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }
}
