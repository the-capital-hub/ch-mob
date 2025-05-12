import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/documentationModel/documentation_model.dart';
import '../../model/documentationModel/pitch_recording_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';
import '../../widget/bottomSheet/create_post_bottomsheet.dart';

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
      // HelperSnackBar.snackBar("Success", data["message"]);
      showPostUpdateBottomSheet(
          postDescription: data['postText'],
          sheetDescription: "Upload Document");
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

  TextEditingController videoUrlController = TextEditingController();

  Future createPitchRecording() async {
    var body = {
      if (base64Image != null)
        "file": {"name": "${DateTime.now()}", "base64": "$base64Image"},
      "videoUrl": videoUrlController.text
    };
    log(body.toString());
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.uploadPitchRecording, withToken: true);
    var data = json.decode(response.body);
    log(response.body.toString());
    Get.back();
    Get.back();
    if (data['status'] == true) {
      await fetchPitchRecord();
      HelperSnackBar.snackBar("Success", data["message"]);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
  }

  var isLoadingPitch = false.obs;
  List<PitchRecord> pitchRecordList = [];
  Future fetchPitchRecord() async {
    isLoadingPitch.value = true;
    pitchRecordList.clear();
    var response = await ApiBase.postRequest(
        body: {"folder_name": "onelinkpitch"},
        withToken: true,
        extendedURL: ApiUrl.getDocument);
    log(response.body);
    var data = json.decode(response.body);
    if (data['status'] == true) {
      PitchRecordModel pitchRecordModel = PitchRecordModel.fromJson(data);
      pitchRecordList.addAll(pitchRecordModel.data!);
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
    isLoadingPitch.value = false;
  }

  Future<bool> deletePitch(String folderName, String docID) async {
    var body = {
      "folder_name": folderName,
      "documentId": docID,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.deleteDocument, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    Get.back(closeOverlays: true);
    Get.back();
    if (data['status'] == true) {
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
