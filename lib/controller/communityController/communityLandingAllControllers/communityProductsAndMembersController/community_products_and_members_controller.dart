import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/controller/communityController/community_controller.dart';
import 'package:capitalhub_crm/model/01-StartupModel/communityModel/getCommunityProductsAndMembersModel/get_community_products_and_members_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/helper/helper.dart';
import 'package:capitalhub_crm/utils/helper/helper_sncksbar.dart';
import 'package:get/get.dart';

class CommunityProductsAndMembersController extends GetxController{
  var isLoading = false.obs;
  RxList<CommunityProductsAndMembers> communityProductsAndMembersList = <CommunityProductsAndMembers>[].obs;
  RxList<Product> communityProductsList = <Product>[].obs;
  RxList<Member> communityMembersList = <Member>[].obs;
  Future<void> getCommunityProductsandMembers() async {
  try {
    isLoading.value = true; // Set loading state to true
    communityProductsList.clear();
    communityMembersList.clear();
    
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getCommunityProductsAndMembers+createdCommunityId);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetCommunityProductsAndMembersModel communityProductsAndMembersModel = GetCommunityProductsAndMembersModel.fromJson(data);

      // Update the observable list with new data
      // communityProductsAndMembersList.assignAll([communityProductsAndMembersModel.data]); // Adding events to the list
      // print(eventsList.toString());

      communityProductsList.assignAll(communityProductsAndMembersModel.data.products);
      communityMembersList.assignAll(communityProductsAndMembersModel.data.members);

    } 
  } catch (e) {
    log(" $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
 Future buyProduct(context,productId) async {

Helper.loader(context);
    
    var response = await ApiBase.postRequest(
      body: {},
      
      withToken: true,
      extendedURL: ApiUrl.buyProduct+createdCommunityId+"/"+productId,
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

}