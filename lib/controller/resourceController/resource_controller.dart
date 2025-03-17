import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/model/resourceModel/get_all_resources_by_id_model.dart';
import 'package:capitalhub_crm/model/resourceModel/get_all_resources_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:get/get.dart';

class ResourceController extends GetxController {
  String resourceId = "";
  var isLoading = false.obs;

  AllResources allResources = AllResources();
  Future<void> getAllResources() async {
    try {
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getAllResources);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetAllResourcesModel allResourcesModel =
            GetAllResourcesModel.fromJson(data);
        allResources = allResourcesModel.data!;
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading.value = false;
    }
  }

  ResourceById resourceById = ResourceById();
  Future<void> getAllResourcesById() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getResourceById + resourceId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetAllResourcesByIdModel resourceByIdModel =
            GetAllResourcesByIdModel.fromJson(data);
        resourceById = resourceByIdModel.data!;
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading.value = false;
    }
  }
}
