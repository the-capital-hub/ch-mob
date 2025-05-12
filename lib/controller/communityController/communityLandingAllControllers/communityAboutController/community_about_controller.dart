import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/communityModel/communityLandingAllModels/communityAboutModel/community_about_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:get/get.dart';

class CommunityAboutController extends GetxController {
  var isLoading = false.obs;
  RxList<AboutCommunity> aboutCommunityList = <AboutCommunity>[].obs;
  RxList<Community> aboutCommunityDetailsList = <Community>[].obs;
  RxList<Post> aboutCommunityPostsList = <Post>[].obs;
  RxList<Product> aboutCommunityProductsList = <Product>[].obs;
  RxList<Event> aboutCommunityEventsList = <Event>[].obs;
  Future<void> getAboutCommunity() async {
    try {
      isLoading.value = true;
      aboutCommunityList.clear();
      var response = await ApiBase.getRequest(
          extendedURL: ApiUrl.getCommunityById + createdCommunityId);
      log(response.body);

      var data = json.decode(response.body);

      if (data["status"]) {
        GetAboutCommunityModel communityAboutModel =
            GetAboutCommunityModel.fromJson(data);

        aboutCommunityList.assignAll([communityAboutModel.data!]);

        aboutCommunityDetailsList
            .assignAll([communityAboutModel.data!.community!]);
        aboutCommunityPostsList.assignAll(communityAboutModel.data!.posts!);
        aboutCommunityProductsList
            .assignAll(communityAboutModel.data!.products!);
        aboutCommunityEventsList.assignAll(communityAboutModel.data!.events!);
      }
    } catch (e) {
      log("getAboutCommunity $e");
    } finally {
      isLoading.value = false;
    }
  }
}
