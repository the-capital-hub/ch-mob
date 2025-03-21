import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/documentationModel/documentation_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

class DocumentController extends GetxController {
  List<PlatformFile> selectedFiles = [];
  var isLoading = false.obs;
  var isLoadingFolder = false.obs;
  List<DocData> docList = [];
  Future getDocument(String folderName) async {
    isLoading.value = true;
    docList.clear();
    var body = {"folder_name": folderName};
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.getDocument, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      DocumentationModel documentationModel = DocumentationModel.fromJson(data);
      docList.addAll(documentationModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future deleteDocument(String folderName, String docID) async {
    isLoading.value = true;
    docList.clear();

    var body = {
      "folder_name": folderName,
      "documentId": docID,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.deleteDocument, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      DocumentationModel documentationModel = DocumentationModel.fromJson(data);
      docList.addAll(documentationModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoading.value = false;
  }

  Future uploadDocument(Map<String, dynamic> uploadObject) async {
    isLoading.value = true;
    docList.clear();
    var body = uploadObject;
    log(body.toString());
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.uploadDocument, withToken: true);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      DocumentationModel documentationModel = DocumentationModel.fromJson(data);
      docList.addAll(documentationModel.data!);
      HelperSnackBar.snackBar("Success", data["message"]);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    selectedFiles.clear();
    isLoading.value = false;
  }

  TextEditingController folderNameController = TextEditingController();

  List<String> getFolders = [];
  String? base64Image;

  Future fetchFolder() async {
    isLoadingFolder.value = true;
    getFolders.clear();
    var response =
        await ApiBase.getRequest(extendedURL: ApiUrl.getFolderByUser);
    log(response.body);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      getFolders
          .addAll(List<String>.from(data['data'].map((e) => e.toString())));
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoadingFolder.value = false;
  }
}
