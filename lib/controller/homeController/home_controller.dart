import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/model/01-StartupModel/publicPostModel/public_post_model.dart';
import 'package:capitalhub_crm/model/01-StartupModel/savedCollectionModel/saved_collection_model.dart';
import 'package:capitalhub_crm/utils/getStore/get_store.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/01-StartupModel/communityModel/communityCornerModel/community_corner_model.dart';
import '../../model/01-StartupModel/newsModel/startup_corner_news_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';

class HomeController extends GetxController {
  int selectIndex = 0;
  RxBool isLoading = false.obs;

  List<PostPublic> postList = [];

  Future getPublicPost(int page, bool isLoadOn) async {
    try {
      if (page == 1) {
        postList.clear();
        isLoading.value = isLoadOn;
      }
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getPublicPostUrl + page.toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        PublicPostModel publicPostModel = PublicPostModel.fromJson(data);
        postList.addAll(publicPostModel.data!);
      }
    } catch (e) {
      log("getHome Feed $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<StartupNews> startUpNewsList = [];

  Future getStartupNews({required int offSet}) async {
    try {
      if (offSet == 10) {
        isLoading.value = true;
        startUpNewsList.clear();
      }
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getStartupCornerNews + offSet.toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        StartupCornerNews startupCornerNews = StartupCornerNews.fromJson(data);
        startUpNewsList.addAll(startupCornerNews.data!);
      }
    } catch (e) {
      log("getHome Feed $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<CommunityCornerData> communityCornerList = [];
  
  Future geCommunityCorner() async {
    try {
      isLoading.value = true;
      communityCornerList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getComunityCorner);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        CommunityCornerModel communityCornerModel =
            CommunityCornerModel.fromJson(data);
        communityCornerList.addAll(communityCornerModel.data!);
      }
    } catch (e) {
      log("getcommunity corner $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future likeUnlike(postID) async {
    // Helper.loader(context);
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.likeUnlikePostUrl + postID,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
  }

  Future<bool> commentPost(context,
      {required String postID,
      required String userId,
      required String text}) async {
    Helper.loader(context);
    var body = {"userId": userId, "text": text};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.commentPostUrl + postID,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    Get.back();
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

  Future<bool> commentDelete(
    context, {
    required String postID,
    required String commentID,
  }) async {
    Helper.loader(context);

    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.deleteCommentUrl}$postID/$commentID",
    );
    log(response.body);
    var data = json.decode(response.body);
    Get.back();
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

  Future<bool> commentLikeDislike(
    context, {
    required String postID,
    required String commentID,
  }) async {
    var response = await ApiBase.postRequest(
      body: {},
      withToken: true,
      extendedURL: "${ApiUrl.commentLikeUnlikeUrl}$postID/$commentID",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> postDelete(
    context, {
    required String postID,
  }) async {
    Helper.loader(context);
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.deletePostUrl}$postID",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      await getPublicPost(1, true);
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> addPostCompany(
    context, {
    required String postID,
  }) async {
    var response = await ApiBase.postRequest(
      body: {},
      withToken: true,
      extendedURL: "${ApiUrl.addPostCompanyUrl}$postID",
    );
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

  Future<bool> addPostFeature(
    context, {
    required String postID,
  }) async {
    var response = await ApiBase.postRequest(
      body: {},
      withToken: true,
      extendedURL: "${ApiUrl.addPostFeatureUrl}$postID",
    );
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

  List<CollectionList> collectionList = [];
  Future getUserCollection() async {
    try {
      collectionList.clear();
      isLoading.value = true;
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.collectionGetUrl +
              GetStoreData.getStore.read('id').toString());
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        SavedCollectionModel savedCollectionModel =
            SavedCollectionModel.fromJson(data);
        collectionList.addAll(savedCollectionModel.data!);
      }
    } catch (e) {
      log("getcollection $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> savePost(context,
      {required String postID, required String colelctionName}) async {
    Helper.loader(context);
    var body = {
      "userId": GetStoreData.getStore.read('id').toString(),
      "collectionName": colelctionName
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.savePostUrl + postID, withToken: true);
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

  Future<bool> unSavePost(
    context, {
    required String postID,
  }) async {
    Helper.loader(context);
    var body = {
      "userId": GetStoreData.getStore.read('id').toString(),
      "postId": postID
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.unSavePostUrl, withToken: true);
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

  Future<bool> votePoll(
    context, {
    required String postID,
    required String optionID,
  }) async {
    var body = {"optionId": optionID, "postId": postID};
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.pollVote, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> followUnfollow({
    required String userId,
    required String connectionStatus,
  }) async {
    // pending==cancel accepted==unfollow notsent==follow
    var body = {"userId": userId};
    var response = connectionStatus == "not_sent"
        ? await ApiBase.postRequest(
            body: body, extendedURL: ApiUrl.sendReq + userId, withToken: true)
        : await ApiBase.deleteRequest(
            extendedURL: ApiUrl.removeConnectionReq + userId);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      // HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
