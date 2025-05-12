import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/screen/communityScreen/communityLandingAllScreens/communityLandingScreen/community_landing_screen.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../../model/profileModel/profile_post_model.dart';
import '../../model/publicPostModel/public_post_model.dart';

class CreatePostController extends GetxController {
  List<String> base64ImageList = [];
  String videoBase64 = "";
  String documentBase64 = "";
  List<String> pollOptions = [];
  bool isPublicPost = true;
  bool isCommunityPost = false;
  QuillEditorController titleController = QuillEditorController();

  base64Convert(context, List<Asset> selectedImages, video, document,
      String postId) async {
    Helper.loader(context);
    if (selectedImages.isNotEmpty) {
      base64ImageList.clear();
      for (var asset in selectedImages) {
        final ByteData byteData = await asset.getByteData();
        final List<int> byteList = byteData.buffer.asUint8List();
        final String base64String = base64Encode(Uint8List.fromList(byteList));
        base64ImageList.add(base64String);
        log("image length ${base64ImageList.length}");
      }
    }
    if (video != null) {
      final Uint8List videoBytes = await video.readAsBytes();
      videoBase64 = base64Encode(videoBytes);
      // log(videoBase64);
    }
    if (document != null) {
      final Uint8List documentBytes = await document.readAsBytes();
      documentBase64 = base64Encode(documentBytes);
      // log(documentBase64);
    }
    await addPost(postId);
  }

  Future addPost(String? postId) async {
    String title = "";
    await titleController.getText().then((val) => title = val);
    var body = {
      "description": title,
      "images": base64ImageList,
      "video": videoBase64,
      "documentUrl": documentBase64,
      "pollOptions": pollOptions,
      "postType": isCommunityPost
          ? "community"
          : isPublicPost
              ? "public"
              : "company",
      "resharedPostId": postId ?? "",
      "communityId": createdCommunityId,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.addPost, withToken: true);

    var data = json.decode(response.body);
    Get.back();
    if (data["status"]) {
      titleController.clear();
      base64ImageList.clear();
      videoBase64 = "";
      documentBase64 = "";
      pollOptions.clear();
      isPublicPost = true;
      if (isCommunityPost) Get.to(() => CommunityLandingScreen());
      isCommunityPost = false;

      HelperSnackBar.snackBar("Success", data["message"]);

      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  ProfilePost postData = ProfilePost();
  Future getPostDetail(String id) async {
    try {
      var response = await ApiBase.postRequest(
          extendedURL: ApiUrl.getPostDetail,
          body: {"postId": id},
          withToken: true);
      log(response.body);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        ProfilePost getPostData = ProfilePost.fromJson(data['data']);
        postData = getPostData;
      }
    } catch (e) {
      log("getPost $e");
    } finally {}
  }
}
