import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/profileModel/profile_post_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';

class SavedPostController extends GetxController {
  RxBool isLoading = false.obs;
  List<String> tabNames = [];

  Future getSavedFolder() async {
    try {
      tabNames.clear();
      isLoading.value = true;
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getSavedPostFolderList);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        for (var i = 0; i < data['data'].length; i++) {
          tabNames.add(data['data'][i]);
        }
      }
    } catch (e) {
      log("getProfile $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<ProfilePost> savedPost = [];
  RxBool isTabLoading = false.obs;

  Future getSavedPost(tabValue) async {
    try {
      savedPost.clear();
      isTabLoading.value = true;
      var body = {"collectionName": tabValue};

      var response = await ApiBase.postRequest(
          extendedURL: ApiUrl.getSavedPost, body: body, withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ProfilePostModel profilePostModel = ProfilePostModel.fromJson(data);
        savedPost.addAll(profilePostModel.data!);
      }
    } catch (e) {
      log("getPost $e");
    } finally {
      isTabLoading.value = false;
    }
  }

  Future removePost(postId) async {
    try {
      isTabLoading.value = true;
      var body = {"postId": postId};

      var response = await ApiBase.pachRequest(
          extendedURL: ApiUrl.removeSavedPost, body: body, withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {}
    } catch (e) {
      log("getPost $e");
    } finally {
      isTabLoading.value = false;
    }
  }
}
