import 'dart:convert';
import 'dart:developer';

import 'package:capitalhub_crm/model/resourceModel/get_all_resources_by_id_model.dart';
import 'package:capitalhub_crm/model/resourceModel/get_all_resources_model.dart';
import 'package:capitalhub_crm/utils/apiService/api_base.dart';
import 'package:capitalhub_crm/utils/apiService/api_url.dart';
import 'package:capitalhub_crm/utils/constant/asset_constant.dart';
import 'package:get/get.dart';

class ResourceController extends GetxController{
String resourceId = "";
var isLoading = false.obs;

  final List<String> menuTemplatesName=['GTM Strategy','Sales & Marketing Plans', 'Pitch Deck','Financial Modeling'];


  final List<String> menuTemplateIcons=[PngAssetPath.gtmStrategyImg,PngAssetPath.salesImg,
    PngAssetPath.pickDeckImg, PngAssetPath.financialImg
  ];

  final List<String> menuItemsName=['Sales Playbook','Marketing Playbook',
    'Go-to-Market Strategy','Pitch Deck Playbook','Financial Modeling Playbook'];

  final List<String> menuItemsIcons=[PngAssetPath.salesImg,PngAssetPath.marketingImg,PngAssetPath.gtmStrategyImg,
    PngAssetPath.pickDeckImg,PngAssetPath.financialImg
  ];
RxList<AllResources> allResourcesDetails = <AllResources>[].obs;
  Future<void> getAllResources() async {
    
  try {
    isLoading.value = true; // Set loading state to true
   
    
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getAllResources);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      
      GetAllResourcesModel allResourcesModel = GetAllResourcesModel.fromJson(data);

      
      allResourcesDetails.assignAll([allResourcesModel.data]); // Adding events to the list
     
    } 
  } catch (e) {
    log(" $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}

RxList<ResourceById> resourceByIdDetails = <ResourceById>[].obs;
  Future<void> getAllResourcesById() async {
   
  try {
    isLoading.value = true; // Set loading state to true
   
    
    var response = await ApiBase.getRequest(extendedURL: ApiUrl.getResourceById+resourceId);
    log(response.body);
    
    var data = json.decode(response.body);

    if (data["status"]) {
      
      GetAllResourcesByIdModel resourcesByIdModel = GetAllResourcesByIdModel.fromJson(data);

      
      resourceByIdDetails.assignAll([resourcesByIdModel.data]); // Adding events to the list
     
    } 
  } catch (e) {
    log(" $e");
    // HelperSnackBar.snackBar("Error", "An error occurred while fetching events");
  } finally {
    isLoading.value = false; // Set loading state to false after request
  }
}
}