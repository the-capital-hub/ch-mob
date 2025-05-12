import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../model/homeScreenLandingModel/comments_model.dart';
import '../../model/homeScreenLandingModel/home_screen_landing_model.dart';
import '../../model/homeScreenLandingModel/post_data_model.dart';
import '../../model/savedCollectionModel/saved_collection_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/getStore/get_store.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class HomeControllerNew extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isAllFeedLoading = true.obs;
  RxBool isCommentLoading = true.obs;

  Rx<HomeData> homeData = HomeData().obs;

  Future getHomeData() async {
    try {
      isLoading.value = true;

      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getHomeLandingUrl);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        HomeModel homeModel = HomeModel.fromJson(data);
        homeData.value = homeModel.data!;
      }
    } catch (e) {
      log("getHome Feed $e");
    } finally {
      isLoading.value = false;
    }
  }

  RxList<PostData> allFeed = <PostData>[].obs;
  RxBool isPaginating = false.obs;

  Future<void> getAllFeed({required int page}) async {
    try {
      if (page == 1) {
        allFeed.clear();
        isAllFeedLoading.value = true;
      } else {
        isPaginating.value = true;
      }

      var response = await ApiBase.getRequest(
          extendedURL: "${ApiUrl.getAllFeedUrl}page=$page&limit=10");
      var data = jsonDecode(response.body);

      if (data['status'] == true) {
        final List<PostData> fetchedPosts =
            (data['data'] as List).map((e) => PostData.fromJson(e)).toList();
        allFeed.addAll(fetchedPosts);
      }
    } catch (e) {
      log("getHome Feed $e");
    } finally {
      isAllFeedLoading.value = false;
      isPaginating.value = false;
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

  Future likeUnlike(postID) async {
    var body = {};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.likeUnlikePostUrl + postID,
        withToken: true);
    log(response.body);
  }

  Future<bool> commentPost(context,
      {required String postID,
      required String userId,
      required String text}) async {
    isCommentLoading.value = true;
    var body = {"userId": userId, "text": text};
    var response = await ApiBase.postRequest(
        body: body,
        extendedURL: ApiUrl.commentPostUrl + postID,
        withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    // Get.back();
    if (data["status"] == true) {
      getCommentsList(postID);
      final postIndex = allFeed.indexWhere((post) => post.postId == postID);
      if (postIndex != -1) {
        allFeed[postIndex].commentsCount =
            (allFeed[postIndex].commentsCount ?? 0) + 1;
        allFeed.refresh();
      }
      final homePostIndex =
          homeData.value.posts!.indexWhere((post) => post.postId == postID);
      if (homePostIndex != -1) {
        homeData.value.posts![homePostIndex].commentsCount =
            (homeData.value.posts![homePostIndex].commentsCount ?? 0) + 1;
        homeData.refresh();
      }
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> commentDelete(
    context, {
    required String postID,
    required String commentID,
  }) async {
    var response = await ApiBase.deleteRequest(
      extendedURL: "${ApiUrl.deleteCommentUrl}$postID/$commentID",
    );
    log(response.body);
    var data = json.decode(response.body);

    if (data["status"] == true) {
      commentList.removeWhere((comment) => comment.id == commentID);
      final postIndex = allFeed.indexWhere((post) => post.postId == postID);
      if (postIndex != -1) {
        allFeed[postIndex].commentsCount =
            (allFeed[postIndex].commentsCount ?? 0) - 1;
        allFeed.refresh();
      }
      final homePostIndex =
          homeData.value.posts!.indexWhere((post) => post.postId == postID);
      if (homePostIndex != -1) {
        homeData.value.posts![homePostIndex].commentsCount =
            (homeData.value.posts![homePostIndex].commentsCount ?? 0) - 1;
        homeData.refresh();
      }
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxList<CommentData> commentList = <CommentData>[].obs;

  Future getCommentsList(id) async {
    try {
      isCommentLoading.value = true;
      commentList.clear();
      var response =
          await ApiBase.getRequest(extendedURL: ApiUrl.getCommentsUrl + id);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        CommentsModel commentsModel = CommentsModel.fromJson(data);
        commentList.addAll(commentsModel.data!);
      }
    } catch (e) {
      log("getComment Feed $e");
    } finally {
      isCommentLoading.value = false;
    }
  }

  Future<bool> commentLikeDislike({
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

  List<CollectionList> collectionList = [];
  Future getUserCollection() async {
    try {
      collectionList.clear();

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
    } finally {}
  }

  Future<bool> savePost(context,
      {required String postID, required String colelctionName}) async {
    var body = {
      "userId": GetStoreData.getStore.read('id').toString(),
      "collectionName" : colelctionName
    };
    var response = await ApiBase.pachRequest(
        body: body, extendedURL: ApiUrl.savePostUrl + postID, withToken: true);
    log(response.body);
    var data = json.decode(response.body);

    if (data["status"] == true) {
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future<bool> unSavePost(
    context, {
    required String postID,
  }) async {
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
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
