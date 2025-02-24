import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/communityPostModel/community_post_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/savedCommunityCollectionModel/saved_community_collection_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CommunityHomeController extends GetxController {
  int selectIndex = 0;
  var isLoading = false.obs;
  List<CommunityPost> communityPostList = [];
  Future getCommunityPosts(int page, bool isLoadOn) async {
    try {
      if (page == 1) {
        communityPostList.clear();
        isLoading.value = isLoadOn;
      }
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityPosts+createdCommunityId+"?page="+page.toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        CommunityPostModel communityPostModel =
            CommunityPostModel.fromJson(data);
        communityPostList.addAll(communityPostModel.data!);
      }
      else{
        HelperSnackBar.snackBar("Info", data["message"]);
      }
    } catch (e) {
      log("getHome Feed $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> sendJoinRequest() async {
    var wbody = {
      "name": "${GetStoreData.getStore.read('name')}",
      "email": "${GetStoreData.getStore.read('email')}",
      "requestedNumber": "${GetStoreData.getStore.read('phone')}",
      "adminEmail": "${GetStoreData.getStore.read('email')}",
      "phoneNumber": "${GetStoreData.getStore.read('phone')}"
    };

    var response = await ApiBase.postRequest(
      body: wbody,
      withToken: true,
      extendedURL: ApiUrl.sendJoinRequest,
    );
    log(wbody.toString());
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      HelperSnackBar.snackBar("Success", data["message"]);

      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future likeUnlikeCommunityPost(postID) async {
    // Helper.loader(context);
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.likeUnlikeCommunityPost + postID,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
  }

  Future<bool> commentCommunityPost(context,
      {required String postID,
      required String userId,
      required String text}) async {
    Helper.loader(context);
    var body = {"userId": userId, "text": text};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.commentCommunityPost + postID,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> deleteCommentCommunityPost(
    context, {
    required String postID,
    required String commentID,
  }) async {
    Helper.loader(context);

    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.deleteCommentCommunityPost}$postID/$commentID",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> toggleLikeCommentCommunityPost(
    context, {
    required String postID,
    required String commentID,
  }) async {
    var response = await ApiBase.postRequest(
      body: {},
      withToken: true,
      extendedURL: "${ApiUrl.toggleLikeCommentCommunityPost}$postID/$commentID",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCommunityPost(
    context, {
    required String postID,
  }) async {
    Helper.loader(context);
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.deleteCommunityPost}$postID",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  List<CommunityCollection> communityCollectionList = [];
  Future getSavedCommunityPostCollections() async {
    try {
      communityCollectionList.clear();
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getSavedCommunityPostCollections +
              GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        GetSavedCommunityCollectionModel savedCommunityCollectionModel =
            GetSavedCommunityCollectionModel.fromJson(data);
        communityCollectionList.addAll(savedCommunityCollectionModel.data!);
      }
      else{
        HelperSnackBar.snackBar("Info", data["message"]);
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> saveCommunityPost(context,
      {required String postID, required String colelctionName}) async {
    Helper.loader(context);
    var body = {
      "userId": GetStoreData.getStore.read('id').toString(),
      "collectionName": colelctionName
    };
    var response = await ApiBase.pachRequest(
        body: body,
        extendedURL: ApiUrl.saveCommunityPost + postID,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);

    if (data["status"] == true) {
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> unsaveCommunityPost(
    context, {
    required String postID,
  }) async {
    Helper.loader(context);
    var body = {
      "userId": GetStoreData.getStore.read('id').toString(),
      "postId": postID
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.unsaveCommunityPost, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> voteCommunityPost(
    context, {
    required String postID,
    required String optionID,
  }) async {
    var body = {"optionId": optionID, "postId": postID};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.voteCommunityPost, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> reportPost(
    context, {
    required String postID,
    required String reportReason,
  }) async {
    var body = {"postId": postID, "reportReason": reportReason};
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.reportPost, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
