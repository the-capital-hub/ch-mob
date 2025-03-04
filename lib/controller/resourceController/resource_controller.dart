import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/model/resourceModel/resource_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:get/get.dart';

class ResourceController extends GetxController{

  // final List<String> menuTemplatesName=['GTM Strategy','Sales & Marketing Plans', 'Pitch Deck','Financial Modeling'];

  // final List<String> menuTemplateIcons=[PngAssetPath.gtmStrategyImg,PngAssetPath.salesImg,
  //   PngAssetPath.pickDeckImg, PngAssetPath.financialImg
  // ];

  // final List<String> menuItemsName=['Sales Playbook','Marketing Playbook',
  //   'Go-to-Market Strategy','Pitch Deck Playbook','Financial Modeling Playbook'];

  // final List<String> menuItemsIcons=[PngAssetPath.salesImg,PngAssetPath.marketingImg,PngAssetPath.gtmStrategyImg,
  //   PngAssetPath.pickDeckImg,PngAssetPath.financialImg
  // ];
RxList<AllResources> allResourcesDetails = <AllResources>[].obs;
  Future<void> getAllResources() async {
    var isLoading = false.obs;
  try {
    isLoading.value = true; // Set loading state to true
   
    
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getAllCommunities);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      // Parse the response into GetEventsModel
      GetAllResourcesModel allResourcesModel = GetAllResourcesModel.fromJson(data);

      // Update the observable list with new data
      // allCommunitiesDetails.assignAll(allResources.data); // Adding events to the list
      // print(eventsList.toString());
      // log("Created Community Details: $createdCommunityDetails");
    } 
  } catch (e) {
    log(" $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}

}