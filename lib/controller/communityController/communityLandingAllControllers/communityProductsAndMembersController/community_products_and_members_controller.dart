import 'dart:convert';
import 'dart:developer';
import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/communityLandingAllModels/getCommunityProductsAndMembersModel/get_community_products_and_members_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';

class CommunityProductsAndMembersController extends GetxController {
  String productId = "";
  var isLoading = false.obs;
  RxList<CommunityProductsAndMembers> communityProductsAndMembersList =
      <CommunityProductsAndMembers>[].obs;
  RxList<Product> communityProductsList = <Product>[].obs;
  RxList<Member> communityMembersList = <Member>[].obs;
  Future<void> getCommunityProductsandMembers() async {
    try {
      isLoading.value = true;
      communityProductsList.clear();
      communityMembersList.clear();
      var response = await ApiBase.getRequest(
          extendedURL:
              ApiUrl.getCommunityProductsAndMembers + createdCommunityId);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"]) {
        GetCommunityProductsAndMembersModel communityProductsAndMembersModel =
            GetCommunityProductsAndMembersModel.fromJson(data);
        communityProductsList
            .assignAll(communityProductsAndMembersModel.data.products);
        communityMembersList
            .assignAll(communityProductsAndMembersModel.data.members);
      }
    } catch (e) {
      log(" $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future buyProduct(context, productId) async {
    Helper.loader(context);
    var response = await ApiBase.postRequest(
      body: {},
      withToken: true,
      extendedURL: "${ApiUrl.buyProduct}$createdCommunityId/$productId",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  Future deleteCommunityProduct(productId) async {
    var response = await ApiBase.deleteRequest(
      extendedURL:
          "${ApiUrl.deleteCommunityProduct}$createdCommunityId/$productId",
    );
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"]) {
      communityProductsList.removeWhere((product) => product.id == productId);
      HelperSnackBar.snackBar("Success", data["message"]);
      return true;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }
}
